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
  SpeechService? _speechService;
  bool _initializing = false;
  bool _ready = false;
  String? _initError;

  bool get isReady => _ready;
  String? get initError => _initError;

  Future<bool> init() async {
    if (_ready) return true;
    if (_initializing) {
      // Wait for the in-flight init to finish.
      while (_initializing) {
        await Future.delayed(const Duration(milliseconds: 100));
      }
      return _ready;
    }
    _initializing = true;
    try {
      final modelPath = await ModelLoader().loadFromAssets(_modelAsset);
      final model = await _vosk.createModel(modelPath);
      final recognizer = await _vosk.createRecognizer(model: model, sampleRate: _sampleRate);
      _speechService = await _vosk.initSpeechService(recognizer);
      _ready = true;
    } catch (e) {
      _initError = e.toString();
      _ready = false;
    } finally {
      _initializing = false;
    }
    return _ready;
  }

  /// Listens for a single utterance and returns the transcript.
  /// Times out after [timeout] if the student says nothing.
  Future<String> listenOnce({Duration timeout = const Duration(seconds: 8)}) async {
    final micStatus = await Permission.microphone.request();
    if (!micStatus.isGranted) {
      throw StateError("mic-permission-denied");
    }

    final ok = await init();
    if (!ok || _speechService == null) {
      throw StateError(_initError ?? "mic-unavailable");
    }

    final service = _speechService!;
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

    await service.start();
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
