import 'dart:async';
import 'package:permission_handler/permission_handler.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

/// Free, fully offline listener.
///
/// HISTORY: this used to be built on vosk_flutter_2, a third-party library
/// that bundles its own ~40MB speech model inside the app and loads it via
/// a custom native (JNI) call, createModel(). After many rounds of testing
/// directly on the real device this app failed on, we proved conclusively
/// that createModel() was never a slowness problem and never a corrupted
/// model or a swallowed crash — it was a genuine native hang specific to
/// that device: even a full 4-minute wait never returned. No timeout, no
/// retry, no cache fix could ever have solved that, because the native
/// call itself was never coming back.
///
/// So instead of continuing to patch around a single third-party library's
/// native code we cannot see inside of, this switches to the phone's own
/// built-in speech engine (the same one Android itself uses for its mic
/// button, dictation, and Google Assistant). It is exposed to Flutter by
/// the `speech_to_text` package, but the actual recognition still happens
/// natively on the device via `onDevice: true` below — no network call, no
/// API key, no LLM, no server, ever. It also skips the whole "unzip a 40MB
/// model into app storage the first time" step entirely, which removes the
/// exact code path that was hanging.
///
/// Practical note: on-device recognition requires the phone to have an
/// offline language pack downloaded (Google app → Settings → Voice →
/// Offline speech recognition → English). Almost every real Android phone
/// already has this by default. If a phone genuinely has none installed,
/// listening will fail fast with a clear "didn't catch that" instead of
/// hanging — which is a world away from the old bug.
///
/// ANDROID-13 NOTE: a handful of Android 13 phones/builds (this is a
/// documented, widely-reported flaky spot in Android's own on-device
/// speech engine — the same class of "error 9 / insufficient permissions"
/// or "error_client" failure shows up across many unrelated apps and
/// frameworks on Android 13, and is generally gone again by Android 14+)
/// occasionally fail the very first on-device recognition attempt even
/// though the phone genuinely supports it and permission is genuinely
/// granted. Two defences below target exactly that, without ever sending
/// audio off the device: a short one-time pause the very first time the
/// microphone permission is freshly granted (some builds need a moment to
/// propagate that grant to the separate speech-recognition system
/// service), and a single silent retry of the SAME on-device attempt when
/// the engine itself reports a technical error — never when the student
/// simply said nothing recognizable, which is left alone exactly as
/// before.
class StudentMic {
  StudentMic._();
  static final StudentMic instance = StudentMic._();

  final stt.SpeechToText _speech = stt.SpeechToText();
  bool _available = false;
  bool _initializing = false;
  String? _initError;

  // Which recognizer locale we ended up using. Students here speak
  // Tamil-accented English, and the teacher's demo audio is now deliberately
  // played in an Indian-English voice too (see teacher_tts.dart) — but none
  // of that helps scores if the recognizer itself is listening for American
  // English. Android's speech_to_text defaults to the phone's system
  // locale when none is given, which on plenty of devices is en_US even
  // though the phone is set up and used in India, and that mismatch was
  // exactly why repeated answers were scoring lower than they should.
  // We resolve the best available Indian-English locale once, during
  // _ensureReady(), and pass it explicitly to every listen() call below.
  String? _localeId;
  String? get activeLocaleId => _localeId;

  // If a listen attempt is currently active, this lets the persistent
  // onStatus/onError callbacks (registered once, in _ensureReady) tell it
  // "the platform says listening has ended" even when no finalResult ever
  // arrives — e.g. the student stayed silent, or said something the
  // recognizer couldn't match. Without this, every ordinary "didn't catch
  // that" case would sit waiting for the full safety-net timeout instead
  // of returning right away.
  void Function()? _activeListenDone;

  // The most recent error code the platform's speech engine reported (e.g.
  // "error_client", "error_insufficient_permissions", "error_no_match").
  // Used internally to tell "the engine itself hiccupped" (worth a silent
  // retry, still fully on-device) apart from "the student said nothing
  // recognizable" (not worth retrying — retrying won't manufacture speech
  // that was never there). Also exposed read-only in case a future report
  // needs the exact native reason instead of guessing.
  String? _lastEngineError;
  String? get lastEngineError => _lastEngineError;

  bool get isReady => _available;
  String? get initError => _initError;

  // How long the CURRENT (or most recent) init attempt has been running.
  // The UI polls this once a second to show a live "Preparing… (2s)"
  // counter. With the OS's own speech engine this step is normally near-
  // instant (no model to unzip), but we keep the live counter anyway as a
  // safety net in case a particular phone is slow to spin up the service.
  final Stopwatch _loadStopwatch = Stopwatch();
  Duration get loadingElapsed => _loadStopwatch.elapsed;

  Future<bool> _ensureReady() async {
    if (_available) return true;
    if (_initializing) {
      while (_initializing) {
        await Future.delayed(const Duration(milliseconds: 100));
      }
      return _available;
    }
    _initializing = true;
    _loadStopwatch
      ..reset()
      ..start();
    try {
      final ok = await _speech
          .initialize(
            onError: (error) {
              _lastEngineError = error.errorMsg;
              _activeListenDone?.call();
            },
            onStatus: (status) {
              if (status == "done" || status == "notListening") {
                _activeListenDone?.call();
              }
            },
          )
          .timeout(const Duration(seconds: 20), onTimeout: () => false);
      _available = ok;
      if (!ok) {
        _initError = "speech-recognition-unavailable (after ${_loadStopwatch.elapsed.inSeconds}s)";
      } else {
        await _resolveIndianLocale();
      }
    } catch (e) {
      _available = false;
      _initError = "$e (after ${_loadStopwatch.elapsed.inSeconds}s)";
    } finally {
      _initializing = false;
      _loadStopwatch.stop();
    }
    return _available;
  }

  /// Pre-warms the speech engine without starting to listen. Safe to call
  /// eagerly (e.g. on the Home screen) so it's already ready by the time
  /// the student taps "Your turn".
  Future<bool> init() => _ensureReady();

  /// Picks the best available Indian-English recognizer locale installed
  /// on this phone, preferring en_IN, then en_GB, then plain en_US as a
  /// last resort. If the phone genuinely has none of these offline packs,
  /// we leave localeId unset and the recognizer falls back to whatever the
  /// platform default is — same "subject to device capability" caveat as
  /// everywhere else offline on this app.
  Future<void> _resolveIndianLocale() async {
    try {
      final locales = await _speech.locales();
      String normalize(String id) => id.replaceAll('-', '_').toLowerCase();
      for (final candidate in const ["en_in", "en_gb", "en_us"]) {
        for (final l in locales) {
          if (normalize(l.localeId) == candidate) {
            _localeId = l.localeId;
            return;
          }
        }
      }
    } catch (_) {
      // locales() isn't supported, or failed — listen() will just use the
      // platform's own default locale.
    }
  }

  /// True for engine-side error codes worth a single silent retry (still
  /// fully on-device, never touches the network) rather than giving up
  /// immediately. These are the codes phones report when the recognizer
  /// service itself hiccupped on this attempt — a documented flaky spot on
  /// some Android 13 builds in particular — never when the student simply
  /// said nothing understandable ("error_no_match" / "error_speech_timeout"
  /// are deliberately excluded: retrying those just delays the honest
  /// "didn't catch that" without ever helping).
  bool _isRecoverableEngineError(String? errorMsg) {
    const recoverable = {
      "error_client",
      "error_insufficient_permissions",
      "error_audio",
      "error_server",
      "error_recognizer_busy",
      "error_network",
      "error_network_timeout",
    };
    return errorMsg != null && recoverable.contains(errorMsg);
  }

  /// Listens for a single utterance and returns the transcript. Guaranteed
  /// to finish (with "" if nothing usable was heard) within roughly
  /// [timeout] plus a few seconds, no matter what the platform does —
  /// there is always a hard safety-net timer as a last resort.
  Future<String> listenOnce({Duration timeout = const Duration(seconds: 8)}) async {
    final wasAlreadyGranted = await Permission.microphone.status == PermissionStatus.granted;
    final micStatus = await Permission.microphone.request().timeout(
          const Duration(seconds: 10),
          onTimeout: () => PermissionStatus.denied,
        );
    if (!micStatus.isGranted) {
      throw StateError("mic-permission-denied");
    }
    if (!wasAlreadyGranted) {
      // The very first time this phone grants microphone access, some
      // Android builds take a brief moment to propagate that grant to the
      // separate speech-recognition system service. Starting the
      // recognizer immediately after the grant can then fail with an
      // "insufficient permissions" error even though the permission truly
      // is granted — this has been reported specifically on some Android
      // 13 devices. This pause runs only this once per install, so it
      // costs everyone else nothing.
      await Future.delayed(const Duration(milliseconds: 400));
    }

    final ready = await _ensureReady();
    if (!ready) {
      throw StateError(_initError ?? "mic-unavailable");
    }

    final firstTry = await _attemptListen(timeout);
    if (firstTry.isNotEmpty || !_isRecoverableEngineError(_lastEngineError)) {
      return firstTry;
    }

    // The on-device engine reported a technical hiccup rather than genuine
    // silence — one silent retry of the same fully-on-device attempt
    // resolves this far more often than not.
    _lastEngineError = null;
    await Future.delayed(const Duration(milliseconds: 300));
    return _attemptListen(timeout);
  }

  /// One attempt at listening for a single utterance. Broken out from
  /// [listenOnce] so that method can retry it once without duplicating the
  /// completer/timer plumbing.
  Future<String> _attemptListen(Duration timeout) async {
    final completer = Completer<String>();
    String lastWords = "";
    bool done = false;
    Timer? safetyTimer;

    void finish(String text) {
      if (done) return;
      done = true;
      safetyTimer?.cancel();
      _activeListenDone = null;
      if (!completer.isCompleted) completer.complete(text);
    }

    _activeListenDone = () => finish(lastWords);

    final pauseFor = timeout < const Duration(seconds: 3) ? timeout : const Duration(seconds: 3);

    try {
      await _speech.listen(
        onResult: (result) {
          lastWords = result.recognizedWords;
          if (result.finalResult) finish(lastWords);
        },
        listenFor: timeout,
        pauseFor: pauseFor,
        cancelOnError: true,
        partialResults: true,
        // Forces the platform's on-device engine — never sends audio
        // anywhere. If the phone has no offline pack installed this fails
        // fast (via onError above) rather than silently going online.
        onDevice: true,
        // Recognize against Indian English when the phone has that pack
        // installed (resolved once in _resolveIndianLocale) — otherwise
        // omit it and let the platform use its own default locale.
        localeId: _localeId,
      );
    } catch (e) {
      finish("");
    }

    // Belt-and-braces: guarantees this attempt can never hang forever even
    // if the platform never sends any status/error/result callback at all
    // — the exact failure mode that made the old engine unusable.
    safetyTimer = Timer(timeout + const Duration(seconds: 8), () async {
      try {
        await _speech.stop();
      } catch (_) {
        // Ignore — we're giving up on this attempt either way.
      }
      finish(lastWords);
    });

    return completer.future;
  }

  Future<void> cancel() async {
    try {
      await _speech.stop();
    } catch (_) {
      // Ignore — nothing to cancel if it was never listening.
    }
  }
}
