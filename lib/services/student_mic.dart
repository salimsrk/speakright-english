import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:vosk_flutter_2/vosk_flutter_2.dart';

/// Free, fully offline listener — uses a small Vosk speech-recognition
/// model bundled inside the app itself (downloaded once at build time,
/// shipped inside the .apk). Recognition happens entirely on the phone:
/// no network call, no API key, no LLM, no server, ever — including
/// with the phone in airplane mode.
class StudentMic {
  StudentMic._();
  static final StudentMic instance = StudentMic._();

  static const _modelAsset = "assets/models/vosk-model-small-en-us-0.15.zip";
  static const _sampleRate = 16000;
  // Written by our own Android crash-guard (SpeakRightApplication.kt) into
  // the SAME folder Flutter's getApplicationDocumentsDirectory() resolves
  // to on Android — see the comment on _tryLoadModel below.
  static const _crashLogFileName = "last_native_crash.txt";

  final VoskFlutterPlugin _vosk = VoskFlutterPlugin.instance();
  Model? _model;
  Recognizer? _recognizer;
  SpeechService? _speechService;
  bool _initializing = false;
  bool _modelReady = false;
  String? _initError;

  bool get isReady => _modelReady;
  String? get initError => _initError;

  // How long the CURRENT (or most recent) model-loading attempt has been
  // running. The UI polls this (once a second) to show a live "Preparing…
  // (12s)" counter instead of a static label — see the comment on
  // _tryLoadModel for why that matters this round.
  final Stopwatch _loadStopwatch = Stopwatch();
  Duration get loadingElapsed => _loadStopwatch.elapsed;

  /// Loads the (slow-ish, especially the very first time — unzipping a
  /// ~40MB model to the phone's storage) model + recognizer once and keeps
  /// them for the whole app session. Safe to call many times — it only
  /// does the real work the first time.
  Future<bool> _ensureModelReady() async {
    if (_modelReady) return true;
    if (_initializing) {
      // Wait for the in-flight init to finish.
      while (_initializing) {
        await Future.delayed(const Duration(milliseconds: 100));
      }
      return _modelReady;
    }
    _initializing = true;
    try {
      _modelReady = await _tryLoadModel();
    } finally {
      _initializing = false;
    }
    return _modelReady;
  }

  /// One full attempt at unzip → createModel → createRecognizer.
  ///
  /// HISTORY, because this has taken several rounds to nail down: a real
  /// device kept hitting "model-create-timeout" no matter what we tried —
  /// first a generous timeout increase (ruled out pure slowness... or so
  /// we thought), then a forced fresh re-extract in case the cached model
  /// was corrupted (ruled that out too — identical failure either way),
  /// then a crash-log capture in case a native crash was being silently
  /// swallowed by our own crash-guard (ruled that out as well — no crash
  /// was ever recorded, meaning createModel() is not crashing, it is
  /// genuinely never calling back at all).
  ///
  /// That combination of results actually narrows things down a lot:
  /// not corrupted data, not a caught native crash, not resolving even
  /// after a full minute. The two explanations left standing are (a) this
  /// device is simply far slower at loading the model into memory than a
  /// minute can cover — real, but strange for a ~40MB "small" model — or
  /// (b) createModel() never returns AT ALL on this device (a genuine
  /// native deadlock/incompatibility), no matter how long we wait. There
  /// is no way to tell these two apart without actually testing "does it
  /// ever finish, given enough time" — so createModel's timeout below is
  /// deliberately pushed way out (4 minutes) purely as that experiment.
  /// If it succeeds within that window, we know it's (a) and can tune a
  /// sane permanent timeout; if it still never completes, that proves (b)
  /// and rules out timeout-tuning as a fix entirely, pointing instead at
  /// swapping out the offline recognition engine for this device.
  Future<bool> _tryLoadModel() async {
    await _clearNativeCrashLog();
    _loadStopwatch
      ..reset()
      ..start();
    try {
      final modelPath = await ModelLoader().loadFromAssets(_modelAsset, forceReload: true).timeout(
            const Duration(seconds: 90),
            onTimeout: () => throw TimeoutException("model-extract-timeout"),
          );
      final model = await _vosk.createModel(modelPath).timeout(
            const Duration(seconds: 240),
            onTimeout: () => throw TimeoutException("model-create-timeout"),
          );
      final recognizer = await _vosk
          .createRecognizer(model: model, sampleRate: _sampleRate)
          .timeout(const Duration(seconds: 30), onTimeout: () => throw TimeoutException("recognizer-create-timeout"));
      _model = model;
      _recognizer = recognizer;
      return true;
    } catch (e) {
      // Give a just-crashed background thread a brief moment to finish
      // writing the crash file before we go looking for it.
      await Future.delayed(const Duration(milliseconds: 300));
      final crash = await _readNativeCrashLog();
      final elapsed = _loadStopwatch.elapsed.inSeconds;
      _initError = (crash != null && crash.isNotEmpty)
          ? "$e (after ${elapsed}s) || native crash: $crash"
          : "$e (after ${elapsed}s)";
      // Leave things in a clean state so the next attempt starts from
      // scratch instead of being wedged on a half-built model forever.
      _model = null;
      _recognizer = null;
      return false;
    } finally {
      _loadStopwatch.stop();
    }
  }

  Future<File?> _crashLogFile() async {
    try {
      final dir = await getApplicationDocumentsDirectory();
      return File("${dir.path}/$_crashLogFileName");
    } catch (_) {
      return null;
    }
  }

  Future<void> _clearNativeCrashLog() async {
    try {
      final file = await _crashLogFile();
      if (file != null && await file.exists()) {
        await file.delete();
      }
    } catch (_) {
      // Best-effort diagnostics only — never let this break model loading.
    }
  }

  Future<String?> _readNativeCrashLog() async {
    try {
      final file = await _crashLogFile();
      if (file != null && await file.exists()) {
        return await file.readAsString();
      }
    } catch (_) {
      // Best-effort diagnostics only.
    }
    return null;
  }

  /// Pre-warms the model/recognizer without starting to listen. Safe to
  /// call eagerly (e.g. on the Home screen, right when the app opens) so
  /// that by the time the student actually taps "Your turn", the slow
  /// one-time unzip-and-load work is already done or well underway.
  Future<bool> init() => _ensureModelReady();

  /// Creates a brand-new native speech-recognition session for this one
  /// listening attempt, instead of reusing the previous one.
  ///
  /// Why: the offline voice engine records audio on its own background
  /// thread. If a previous attempt ever hit a hiccup on that thread, the
  /// native side can be left thinking recording is still "in progress"
  /// forever — every future start() call then silently does nothing,
  /// which is exactly the "shows Listening… and never responds" bug.
  /// Disposing and recreating the speech service for every attempt (it
  /// reuses the already-loaded model, so this is cheap) guarantees each
  /// attempt starts from a clean slate.
  Future<SpeechService> _freshSpeechService() async {
    final old = _speechService;
    _speechService = null;
    if (old != null) {
      try {
        await old.dispose().timeout(const Duration(seconds: 5), onTimeout: () {});
      } catch (_) {
        // Ignore — we're replacing it either way.
      }
    }
    final service = await _vosk
        .initSpeechService(_recognizer!)
        .timeout(const Duration(seconds: 20), onTimeout: () => throw TimeoutException("speech-service-init-timeout"));
    _speechService = service;
    return service;
  }

  /// Listens for a single utterance and returns the transcript.
  /// Times out after [timeout] if the student says nothing once listening
  /// has actually started.
  ///
  /// This outer wrapper is a second, coarser safety net on top of all the
  /// per-step timeouts above: no matter which native call turns out to be
  /// the culprit on a given phone, the student is guaranteed to see the
  /// "Listening…"/"Preparing…" state end — as a normal "didn't catch
  /// that, try again" — instead of it being stuck with no response, which
  /// is the exact bug this whole file exists to prevent.
  ///
  /// 380s here (only ever spent once, on the very first mic use of a
  /// session — see _tryLoadModel's comment for why createModel alone now
  /// gets up to 4 minutes as a one-time "does it ever finish" test)
  /// comfortably covers the worst case of every per-step timeout above
  /// firing in sequence, so a real answer is never cut off too early.
  Future<String> listenOnce({Duration timeout = const Duration(seconds: 8)}) {
    return _listenOnceInner(timeout).timeout(
      timeout + const Duration(seconds: 380),
      onTimeout: () => "",
    );
  }

  Future<String> _listenOnceInner(Duration timeout) async {
    final micStatus = await Permission.microphone.request().timeout(
          const Duration(seconds: 10),
          onTimeout: () => PermissionStatus.denied,
        );
    if (!micStatus.isGranted) {
      throw StateError("mic-permission-denied");
    }

    final modelOk = await _ensureModelReady();
    if (!modelOk || _recognizer == null) {
      throw StateError(_initError ?? "mic-unavailable");
    }

    final service = await _freshSpeechService();
    final completer = Completer<String>();
    StreamSubscription? resultSub;
    StreamSubscription? partialSub;
    Timer? timer;
    Timer? grace;
    // Vosk keeps updating a "partial" transcript live while the student is
    // talking, but by default it only ever finalizes ("result") a phrase
    // when we explicitly call stop() — it does NOT reliably finalize just
    // because the student paused. Earlier this listener threw the partial
    // transcript away and only acted on a "result" event, so on a normal
    // short answer nothing ever arrived before the timer fired — the exact
    // "Listening… never captures what I said" bug. We now track the latest
    // partial as a fallback, and stop() before giving up.
    String lastPartial = "";
    bool stopRequested = false;

    void finish(String text) {
      if (!completer.isCompleted) completer.complete(text);
      resultSub?.cancel();
      partialSub?.cancel();
      timer?.cancel();
      grace?.cancel();
      service.stop();
    }

    void requestStop() {
      if (stopRequested) return;
      stopRequested = true;
      timer?.cancel();
      // Calling stop() makes Vosk flush whatever it has heard so far as
      // one final "result" event on the same onResult() stream below.
      // Give that a brief moment to arrive instead of discarding it —
      // this is the part that was missing before, and the actual reason
      // real speech was never being captured.
      service.stop();
      grace = Timer(const Duration(milliseconds: 1200), () => finish(lastPartial));
    }

    resultSub = service.onResult().listen((resultJson) {
      final text = _extractText(resultJson);
      if (text.isNotEmpty) {
        finish(text);
      } else if (stopRequested) {
        // The post-stop() flush arrived but had nothing new — fall back
        // to the last live partial transcript instead of an empty string.
        finish(lastPartial);
      }
    }, onError: (_) => finish(lastPartial));

    partialSub = service.onPartial().listen((partialJson) {
      final text = _extractText(partialJson);
      if (text.isNotEmpty) lastPartial = text;
    });

    timer = Timer(timeout, requestStop);

    final started = await service.start();
    if (started == false) {
      // Native side refused to start — fail fast instead of silently
      // sitting on "Listening…" for the whole timeout.
      finish("");
    }

    return completer.future;
  }

  Future<void> cancel() async {
    await _speechService?.stop();
  }

  /// Reads either a final result (`{"text": "..."}`) or a live partial
  /// result (`{"partial": "..."}`) — Vosk uses different JSON keys for
  /// each, so we check both.
  String _extractText(dynamic resultJson) {
    try {
      final decoded = resultJson is String ? jsonDecode(resultJson) : resultJson;
      if (decoded is Map) {
        final value = decoded["text"] ?? decoded["partial"];
        if (value is String) return value.trim();
      }
    } catch (_) {
      // fall through
    }
    return "";
  }
}
