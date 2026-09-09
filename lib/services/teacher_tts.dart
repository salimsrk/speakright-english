import 'package:flutter_tts/flutter_tts.dart';

/// Free built-in "Teacher" voice — uses the phone's own on-device
/// text-to-speech engine (Android TextToSpeech). Works fully offline
/// once the phone's English voice pack is installed, which is true on
/// virtually every Android phone by default. No API key, no LLM,
/// no server.
class TeacherTts {
  TeacherTts._();
  static final TeacherTts instance = TeacherTts._();

  final FlutterTts _tts = FlutterTts();
  bool _ready = false;
  void Function()? _onComplete;

  Future<void> init() async {
    if (_ready) return;
    try {
      final languages = await _tts.getLanguages;
      final available = (languages is List) ? languages.cast<dynamic>().map((e) => e.toString()).toList() : <String>[];
      String chosen = "en-US";
      for (final candidate in ["en-IN", "en-GB", "en-US"]) {
        if (available.any((l) => l.toLowerCase() == candidate.toLowerCase())) {
          chosen = candidate;
          break;
        }
      }
      await _tts.setLanguage(chosen);
    } catch (e) {
      // If language listing fails, just use the engine's default.
    }
    await _tts.setSpeechRate(0.42);
    await _tts.setPitch(1.0);
    await _tts.awaitSpeakCompletion(true);
    _tts.setCompletionHandler(() {
      _onComplete?.call();
    });
    _tts.setErrorHandler((msg) {
      _onComplete?.call();
    });
    _ready = true;
  }

  Future<void> speak(String text, {void Function()? onComplete}) async {
    await init();
    _onComplete = onComplete;
    await _tts.stop();
    await _tts.speak(text);
  }

  Future<void> stop() async {
    await _tts.stop();
  }
}
