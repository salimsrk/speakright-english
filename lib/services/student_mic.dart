import 'dart:async';
import 'dart:convert';
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

  final VoskFlutterPlugin _vosk = VoskFlutterPlugin.instance();
  Model? _model;
  Recognizer? _recognizer;
  SpeechService? _speechService;
  bool _initializing = false;
  bool _modelReady = false;
  String? _initError;

  bool get isReady => _modelReady;
  String? get initError => _initError;

  /// Loads the (slow-ish, especially the very first time — unzipping a
  /// ~40MB model to the phone's storage) model + recognizer once and keeps
  /// them for the whole app session. Safe to call many times — it only
  /// does the real work the first time.
  ///
  /// Every native step here is wrapped in its own timeout. Reason: on the
  /// very first "Your turn" of a fresh install, this whole chain (unzip →
  /// createModel → createRecognizer) has to run before the student's 8s
  /// listening window even starts, and none of those native calls are
  /// covered by that window's timer. If any single one of them ever fails
  /// to call back to Dart (a native hiccup on a background thread, exactly
  /// like the recording hang we fixed earlier — just at a different stage)
  /// there was nothing stopping the whole app from sitting on "Listening…"
  /// forever with no error and no result. Now every step gives up after a
  /// bounded time and reports a real error instead of hanging silently.
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
      final modelPath = await ModelLoader().loadFromAssets(_modelAsset).timeout(
            const Duration(seconds: 30),
            onTimeout: () => throw TimeoutException("model-extract-timeout"),
          );
      _model = await _vosk.createModel(modelPath).timeout(
            const Duration(seconds: 15),
            onTimeout: () => throw TimeoutException("model-create-timeout"),
          );
      _recognizer = await _vosk
          .createRecognizer(model: _model!, sampleRate: _sampleRate)
          .timeout(const Duration(seconds: 10), onTimeout: () => throw TimeoutException("recognizer-create-timeout"));
      _modelReady = true;
    } catch (e) {
      _initError = e.toString();
      _modelReady = false;
      // Leave things in a clean state so the NEXT attempt starts fresh
      // instead of being wedged on a half-built model/recognizer forever.
      _model = null;
      _recognizer = null;
    } finally {
      _initializing = false;
    }
    return _modelReady;
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
        .timeout(const Duration(seconds: 10), onTimeout: () => throw TimeoutException("speech-service-init-timeout"));
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
  /// "Listening…" state end — as a normal "didn't catch that, try again"
  /// — instead of it being stuck with no response, which is the exact bug
  /// this whole file exists to prevent.
  Future<String> listenOnce({Duration timeout = const Duration(seconds: 8)}) {
    return _listenOnceInner(timeout).timeout(
      timeout + const Duration(seconds: 35),
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
