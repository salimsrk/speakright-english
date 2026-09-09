import 'dart:async';
import 'package:flutter_tts/flutter_tts.dart';

/// Which "character" is speaking a line. We only have one real TTS engine
/// (the phone's own on-device voice), so we tell the two characters apart
/// with a different pitch/speed instead of a second voice — this always
/// works offline, on every phone, with zero extra downloads.
enum TtsSpeaker { teacher, friend }

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
  Completer<void>? _speakCompleter;

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
    await _tts.awaitSpeakCompletion(true);
    // We deliberately do NOT rely on the Future returned by the native
    // `speak` call to know when speech is done — on some devices/plugin
    // versions that Future can fail to resolve after `stop()` is called
    // mid-sentence, which would leave a caller stuck awaiting forever
    // (exactly the "stuck, no response" class of bug we've already hit
    // once with the microphone). Instead we track completion ourselves
    // with a Completer that ALSO gets resolved directly by our own
    // stop() — so awaiting speak() can never hang.
    _tts.setCompletionHandler(_finishSpeak);
    _tts.setErrorHandler((msg) => _finishSpeak());
    _tts.setCancelHandler(_finishSpeak);
    _ready = true;
  }

  void _finishSpeak() {
    final c = _speakCompleter;
    if (c != null && !c.isCompleted) c.complete();
  }

  /// Speaks [text] as the given [speaker] and completes once the phone has
  /// finished saying it (or the speech was paused/stopped/errored).
  /// Awaiting this is always safe — it can never hang forever.
  Future<void> speak(String text, {TtsSpeaker speaker = TtsSpeaker.teacher}) async {
    await init();
    await _tts.stop();
    if (speaker == TtsSpeaker.friend) {
      await _tts.setPitch(1.35);
      await _tts.setSpeechRate(0.46);
    } else {
      await _tts.setPitch(1.0);
      await _tts.setSpeechRate(0.42);
    }
    final completer = Completer<void>();
    _speakCompleter = completer;
    // Fire-and-forget on purpose — see the note in init() above about why
    // we don't await this call directly.
    // ignore: unawaited_futures
    _tts.speak(text);
    // Belt-and-suspenders: if the platform never calls any of our
    // completion/error/cancel handlers for some reason, don't let a
    // caller (like the lesson auto-play loop) hang forever.
    return completer.future.timeout(const Duration(seconds: 30), onTimeout: () {});
  }

  /// Stops speaking right now. Safe to call even if nothing is speaking.
  /// Immediately unblocks anything awaiting speak() — a caller doing
  /// `await speak(...)` in a loop (like the lesson auto-play) can check a
  /// "did the user pause?" flag right after this and stop cleanly, instead
  /// of the audio continuing to read on with no way to interrupt it.
  Future<void> stop() async {
    _finishSpeak();
    await _tts.stop();
  }
}
