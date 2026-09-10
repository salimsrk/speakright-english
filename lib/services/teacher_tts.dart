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
    await _selectIndianEnglish();
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

  /// Picks an Indian-English voice for the on-device TTS engine.
  ///
  /// Students here are learning Tamil-accented English, and then have
  /// their spoken repeat scored by the on-device speech recognizer
  /// (see student_mic.dart). If the teacher's demo audio comes out sounding
  /// American, students end up imitating an accent that doesn't match how
  /// they'll actually be recognised — which was making scores lower than
  /// they should be. So we deliberately prefer en-IN everywhere we can.
  ///
  /// `setLanguage("en-IN")` alone isn't fully reliable: some engines report
  /// a locale as "available" in getLanguages() even when only its default
  /// (usually US) voice data is actually downloaded, and silently keep
  /// speaking in that voice. Explicitly selecting a *voice* whose locale is
  /// en-IN (via getVoices()/setVoice()) is the more reliable signal, because
  /// a voice only shows up there if its data is actually present on the
  /// device. We try that first, then fall back to setLanguage, then to
  /// whatever the engine defaults to — exactly the "subject to the
  /// capabilities of the device" caveat we've already flagged to the client.
  Future<void> _selectIndianEnglish() async {
    const preferredLocales = ["en-IN", "en-GB", "en-US"];

    // 1) Try to bind an explicit voice whose locale matches, best candidate
    // first. This is the most reliable option when it's available.
    try {
      final voices = await _tts.getVoices;
      if (voices is List) {
        final list = voices.cast<dynamic>();
        for (final candidate in preferredLocales) {
          for (final v in list) {
            if (v is Map) {
              final locale = (v["locale"] ?? "").toString();
              if (locale.toLowerCase() == candidate.toLowerCase() ||
                  locale.toLowerCase().replaceAll("_", "-") == candidate.toLowerCase()) {
                try {
                  await _tts.setVoice({"name": (v["name"] ?? "").toString(), "locale": locale});
                  _activeLocale = candidate;
                  return;
                } catch (_) {
                  // This particular voice failed to bind — keep looking.
                }
              }
            }
          }
        }
      }
    } catch (_) {
      // getVoices/setVoice not supported on this platform — fall through.
    }

    // 2) Fall back to setLanguage with the same preference order.
    try {
      final languages = await _tts.getLanguages;
      final available = (languages is List) ? languages.cast<dynamic>().map((e) => e.toString()).toList() : <String>[];
      for (final candidate in preferredLocales) {
        if (available.any((l) => l.toLowerCase() == candidate.toLowerCase())) {
          await _tts.setLanguage(candidate);
          _activeLocale = candidate;
          return;
        }
      }
      // 3) Neither list told us anything useful — still ask for en-IN
      // directly. Some engines accept setLanguage for a locale that isn't
      // enumerated by getLanguages/getVoices but is genuinely installed.
      await _tts.setLanguage("en-IN");
      _activeLocale = "en-IN";
    } catch (e) {
      // Nothing worked — the engine will just use its own default voice.
      // (Matches the agreed "offline, subject to device capability" caveat.)
    }
  }

  /// The locale we ended up selecting (best-effort — for diagnostics only).
  String? _activeLocale;
  String? get activeLocale => _activeLocale;

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
