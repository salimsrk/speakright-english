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

  /// Loads the (slow-ish, ~1s) model + recognizer once and keeps them for
  /// the whole app session. Safe to call many times — it only does the
  /// real work the first time.
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
      final modelPath = await ModelLoader().loadFromAssets(_modelAsset);
      _model = await _vosk.createModel(modelPath);
      _recognizer = await _vosk.createRecognizer(model: _model!, sampleRate: _sampleRate);
      _modelReady = true;
    } catch (e) {
      _initError = e.toString();
      _modelReady = false;
    } finally {
      _initializing = false;
    }
    return _modelReady;
  }

  /// Backward-compatible alias — pre-warms the model/recognizer without
  /// starting to listen. Safe to call eagerly (e.g. on the Home screen)
  /// so the very first "Your turn" press doesn't have to wait for it.
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
        await old.dispose();
      } catch (_) {
        // Ignore — we're replacing it either way.
      }
    }
    final service = await _vosk.initSpeechService(_recognizer!);
    _speechService = service;
    return service;
  }

  /// Listens for a single utterance and returns the transcript.
  /// Times out after [timeout] if the student says nothing.
  Future<String> listenOnce({Duration timeout = const Duration(seconds: 8)}) async {
    final micStatus = await Permission.microphone.request();
    if (!micStatus.isGranted) {
      throw StateError("mic-permission-denied");
    }

    final modelOk = await _ensureModelReady();
    if (!modelOk || _recognizer == null) {
      throw StateError(_initError ?? "mic-unavailable");
    }

    final service = await _freshSpeechService();
    final completer = Completer<String>();
    StreamSubscription? sub;
    Timer? timer;

    void finish(String text) {
      if (!completer.isCompleted) completer.complete(text);
      sub?.cancel();
      timer?.cancel();
      service.stop();
    }

    sub = service.onResult().listen((resultJson) {
      final text = _extractText(resultJson);
      if (text.isNotEmpty) finish(text);
    }, onError: (_) {
      finish("");
    });

    timer = Timer(timeout, () => finish(""));

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

  String _extractText(dynamic resultJson) {
    try {
      final decoded = resultJson is String ? jsonDecode(resultJson) : resultJson;
      if (decoded is Map && decoded["text"] != null) {
        return (decoded["text"] as String).trim();
      }
    } catch (_) {
      // fall through
    }
    return "";
  }
}
