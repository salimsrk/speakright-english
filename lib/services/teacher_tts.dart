import 'dart:async';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Which "character" is speaking a line. We only have one real TTS engine
/// (the phone's own on-device voice), so we tell the two characters apart
/// with a different pitch/speed instead of a second voice — this always
/// works offline, on every phone, with zero extra downloads.
enum TtsSpeaker { teacher, friend }

/// One real Indian-English voice we found via the TTS engine's own
/// getVoices() list — which (unlike getLanguages()) only ever lists a
/// voice if its data is genuinely installed on this phone. Students pick
/// between these in Settings ("Teacher Voice"). Every option here is
/// always an Indian English voice by design — see _loadVoiceOptions below.
class TtsVoiceOption {
  final String name; // engine-internal id, e.g. "en-in-x-ene-network"
  final String locale; // e.g. "en-IN"
  final String label; // what we show the student, e.g. "Indian English 1"
  const TtsVoiceOption({required this.name, required this.locale, required this.label});
}

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

  // --- Settings-screen "Teacher Voice Speed" control ---
  // A multiplier on top of the base rates below (not a replacement for
  // them) so the carefully-tuned teacher/friend pitch difference is kept
  // no matter what speed the student picks. Persisted so the choice
  // survives app restarts. 1.0 = the original "Normal" behavior this app
  // always had.
  static const _rateKey = "speakright_tts_rate_multiplier_v1";
  double _rateMultiplier = 1.0;
  double get rateMultiplier => _rateMultiplier;

  Future<void> setRateMultiplier(double value) async {
    _rateMultiplier = value.clamp(0.5, 1.5);
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setDouble(_rateKey, _rateMultiplier);
    } catch (e) {
      // Non-fatal — the new speed still applies for the rest of this
      // session, it just won't be remembered next time the app opens.
    }
  }

  Future<void> _loadRateMultiplier() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final saved = prefs.getDouble(_rateKey);
      if (saved != null) _rateMultiplier = saved.clamp(0.5, 1.5);
    } catch (e) {
      // Non-fatal — just use the default (1.0, "Normal").
    }
  }

  // --- Settings-screen "Teacher Voice" picker ---
  // Which real on-device Indian-English voices we found (see
  // TtsVoiceOption above), and which one the student picked. Persisted so
  // the choice survives app restarts, same pattern as the speed
  // multiplier.
  static const _voiceNameKey = "speakright_tts_voice_name_v1";
  List<TtsVoiceOption> _voiceOptions = [];
  List<TtsVoiceOption> get voiceOptions => _voiceOptions;
  TtsVoiceOption? _selectedVoice;
  TtsVoiceOption? get selectedVoice => _selectedVoice;

  // --- Tamil speech (for the Tamil-translation speaker button) ---
  // A confirmed-installed Tamil voice, found the same way the English
  // picker finds Indian voices — only trusted if getVoices() itself lists
  // it, since that's the only reliable signal the voice data really is on
  // this phone. Not every phone has one; see speakTamil below for the
  // honest fallback/failure behavior when it's missing.
  String? _tamilVoiceName;
  String? _tamilVoiceLocale;
  bool _tamilConfirmed = false;
  bool get tamilAvailable => _tamilConfirmed;

  Future<void> init() async {
    if (_ready) return;
    await _loadRateMultiplier();
    await _selectIndianEnglish();
    await _detectTamilVoice();
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
    // Lets us approximate a real pause/resume (see pause()/resumeFrom()
    // below): the engine calls this as it starts each new word, reporting
    // that word's character offset into whatever text we last handed to
    // speak(). Not every engine/Android version supports this — wrapped
    // defensively so a device that doesn't just never calls it, and
    // resume silently behaves like the old Stop-and-restart instead of
    // crashing or doing nothing.
    try {
      _tts.setProgressHandler((text, start, end, word) {
        _curWordOffset = start;
      });
    } catch (_) {
      // Progress callback unsupported on this platform/plugin version —
      // pause()/resumeFrom() still work, they just always resume from the
      // very beginning on this device.
    }
    _ready = true;
  }

  void _finishSpeak() {
    final c = _speakCompleter;
    if (c != null && !c.isCompleted) c.complete();
  }

  /// Builds [_voiceOptions] from the engine's own getVoices() list — the
  /// only reliable signal that a voice's data is genuinely installed (see
  /// the note on _selectIndianEnglish below). Only locale "en-IN" voices
  /// are ever included here: every chip the Settings screen shows must be
  /// a real Indian-accent voice, never a US/UK/Australian fallback, per
  /// the client's explicit requirement. If the phone genuinely has more
  /// than one distinct Indian voice installed (common on Google's TTS
  /// engine — e.g. a male and a female "network" voice), each one gets
  /// its own numbered option: "Indian English 1", "Indian English 2", etc.
  Future<void> _loadVoiceOptions() async {
    final found = <Map<String, String>>[]; // [{name, locale}]
    try {
      final voices = await _tts.getVoices;
      if (voices is List) {
        for (final v in voices.cast<dynamic>()) {
          if (v is! Map) continue;
          final rawLocale = (v["locale"] ?? "").toString();
          final locale = rawLocale.toLowerCase().replaceAll("_", "-");
          if (locale != "en-in") continue;
          final name = (v["name"] ?? "").toString();
          if (name.isEmpty) continue;
          // A handful of engines list the exact same voice twice under
          // slightly different metadata — skip an exact name repeat.
          if (found.any((f) => f["name"] == name)) continue;
          found.add({"name": name, "locale": rawLocale});
        }
      }
    } catch (_) {
      // getVoices not supported on this platform — _voiceOptions stays
      // empty and the Settings screen falls back to a "get more voices"
      // message instead of showing anything non-Indian.
    }

    final multiple = found.length > 1;
    _voiceOptions = [
      for (var i = 0; i < found.length; i++)
        TtsVoiceOption(
          name: found[i]["name"]!,
          locale: found[i]["locale"]!,
          label: multiple ? "Indian English ${i + 1}" : "Indian English",
        ),
    ];
  }

  /// Looks for a genuinely-installed Tamil voice the same way
  /// [_loadVoiceOptions] looks for Indian English ones — only trusting
  /// getVoices(), never just assuming setLanguage("ta-IN") will work.
  /// Tamil locale shows up as "ta-IN" (or occasionally "ta-LK") depending
  /// on the engine, so any "ta-*" locale counts.
  Future<void> _detectTamilVoice() async {
    _tamilConfirmed = false;
    _tamilVoiceName = null;
    _tamilVoiceLocale = null;
    try {
      final voices = await _tts.getVoices;
      if (voices is List) {
        for (final v in voices.cast<dynamic>()) {
          if (v is! Map) continue;
          final rawLocale = (v["locale"] ?? "").toString();
          final locale = rawLocale.toLowerCase().replaceAll("_", "-");
          if (locale == "ta-in" || locale == "ta-lk" || locale.startsWith("ta-") || locale == "ta") {
            final name = (v["name"] ?? "").toString();
            if (name.isEmpty) continue;
            _tamilVoiceName = name;
            _tamilVoiceLocale = rawLocale;
            _tamilConfirmed = true;
            break;
          }
        }
      }
    } catch (_) {
      // getVoices not supported — Tamil speech falls back to a best-effort
      // setLanguage attempt in speakTamil(), same honesty pattern as
      // English's own unconfirmed fallback below.
    }
  }

  /// Picks an Indian-English voice for the on-device TTS engine, and builds
  /// the voice list the Settings screen offers.
  ///
  /// Students here are learning Tamil-accented English, and then have
  /// their spoken repeat scored by the on-device speech recognizer
  /// (see student_mic.dart). If the teacher's demo audio comes out sounding
  /// American, students end up imitating an accent that doesn't match how
  /// they'll actually be recognised — which was making scores lower than
  /// they should be. So we deliberately prefer en-IN everywhere we can,
  /// and (per the client's explicit ask) the Settings picker only ever
  /// offers Indian voices, never a US/UK one as a substitute.
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
    _activeLocaleConfirmed = false;
    await _loadVoiceOptions();

    if (_voiceOptions.isNotEmpty) {
      // Re-pick whatever the student chose last time, if that exact voice
      // is still available on this phone; otherwise default to the first
      // one found.
      TtsVoiceOption chosen = _voiceOptions.first;
      try {
        final prefs = await SharedPreferences.getInstance();
        final savedName = prefs.getString(_voiceNameKey);
        if (savedName != null) {
          chosen = _voiceOptions.firstWhere((v) => v.name == savedName, orElse: () => chosen);
        }
      } catch (_) {
        // Non-fatal — just use the default.
      }
      try {
        await _tts.setVoice({"name": chosen.name, "locale": chosen.locale});
        _selectedVoice = chosen;
        _activeLocale = chosen.locale;
        _activeLocaleConfirmed = true;
        return;
      } catch (_) {
        // This particular voice failed to bind — fall through to the
        // less-reliable setLanguage attempt below.
      }
    }

    // Fallback for engines where getVoices()/setVoice() didn't give us a
    // confirmed Indian voice: still ask for en-IN directly as a last,
    // unconfirmed attempt. Some engines accept setLanguage for a locale
    // that isn't enumerated by getLanguages/getVoices but is genuinely
    // installed; others silently keep speaking in whatever voice was
    // already active. Either way, this never populates the Settings
    // picker — only a getVoices()-confirmed match does that.
    try {
      await _tts.setLanguage("en-IN");
      _activeLocale = "en-IN";
    } catch (e) {
      // Nothing worked — the engine will just use its own default voice.
      // (Matches the agreed "offline, subject to device capability" caveat.)
    }
  }

  /// Switches the active Teacher voice to [voice] and remembers the choice
  /// for next time the app opens. Used by the Settings screen's voice
  /// chips — tapping a chip previews it (see previewVoice below), which
  /// calls this first.
  Future<void> selectVoice(TtsVoiceOption voice) async {
    await init();
    try {
      await _tts.setVoice({"name": voice.name, "locale": voice.locale});
      _selectedVoice = voice;
      _activeLocale = voice.locale;
      _activeLocaleConfirmed = true;
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_voiceNameKey, voice.name);
    } catch (_) {
      // Non-fatal — the student just stays on whichever voice was active.
    }
  }

  /// Selects [voice] and immediately speaks a short sample so the student
  /// (or whoever's testing on the client's phone) can hear it before
  /// committing — exactly the "tap a voice to hear it" interaction on the
  /// Settings screen.
  Future<void> previewVoice(TtsVoiceOption voice) async {
    await selectVoice(voice);
    await speak("Hello! I am your teacher. Let's practice English together.");
  }

  /// Re-detects available voices without restarting the app — lets the
  /// Settings screen's refresh control pick up a voice pack the student
  /// just installed from the phone's own Settings app, with no app
  /// reinstall needed.
  Future<void> recheckVoice() async {
    await init(); // ensures the engine itself is initialized at least once
    await _selectIndianEnglish();
    await _detectTamilVoice();
  }

  /// The locale we ended up selecting (best-effort — for diagnostics only).
  String? _activeLocale;
  String? get activeLocale => _activeLocale;

  /// True only when [activeLocale] was confirmed against the engine's own
  /// list of installed voices (step 1 above) — not just requested blind.
  bool _activeLocaleConfirmed = false;
  bool get activeLocaleConfirmed => _activeLocaleConfirmed;

  // --- Approximate pause/resume state -------------------------------
  // Android's on-device TextToSpeech has no public API to resume an
  // utterance from a mid-point — speak() always starts a brand-new
  // utterance from its beginning. We approximate a real pause/resume
  // instead: _curWordOffset is kept up to date by the progress handler
  // registered in init() above (last reported word-start offset, relative
  // to whatever slice of text we most recently handed to speak()).
  // _curBaseOffset is how far into the ORIGINAL full text that slice
  // itself started — so the two added together is always the true offset
  // into the original text, even after several pause/resume round-trips.
  String? _curFullText;
  int _curBaseOffset = 0;
  int _curWordOffset = 0;

  /// Speaks [text] as the given [speaker] and completes once the phone has
  /// finished saying it (or the speech was paused/stopped/errored).
  /// Awaiting this is always safe — it can never hang forever. Always
  /// starts from the beginning — see [resumeFrom] to continue from a
  /// previous [pause].
  Future<void> speak(String text, {TtsSpeaker speaker = TtsSpeaker.teacher}) =>
      _speakSlice(text, fullText: text, baseOffset: 0, tamil: false, speaker: speaker);

  /// Speaks [text] (expected to be Tamil script) using a genuinely-
  /// installed Tamil voice when one was found (see [tamilAvailable]), or a
  /// best-effort attempt otherwise. Throws a [StateError] with message
  /// "tamil-voice-unavailable" if even the best-effort attempt fails to
  /// bind a voice — callers should show an honest "Tamil voice not found
  /// on this phone" message rather than silently doing nothing.
  Future<void> speakTamil(String text) =>
      _speakSlice(text, fullText: text, baseOffset: 0, tamil: true);

  /// Pauses whatever is currently speaking (English or Tamil) roughly
  /// where it is, and returns the absolute character offset into the
  /// ORIGINAL text passed to [speak]/[speakTamil]/[resumeFrom] to continue
  /// from. Returns 0 if nothing was speaking, or if this particular
  /// engine/device never reported a word boundary — in which case the
  /// next [resumeFrom] call just starts over from the beginning, exactly
  /// like the old Stop button. Never worse than before, just not always a
  /// perfect mid-sentence pause (that part is honestly best-effort and
  /// depends on the phone's TTS engine).
  Future<int> pause() async {
    final text = _curFullText;
    final resumeAt = text == null ? 0 : (_curBaseOffset + _curWordOffset).clamp(0, text.length);
    await stop();
    return resumeAt;
  }

  /// Resumes speaking [fullText] from [fromOffset] (normally whatever
  /// [pause] just returned) — pass the same [tamil]/[speaker] the original
  /// speak call used. If [fromOffset] is at or past the end of the text,
  /// this does nothing (nothing left to say).
  Future<void> resumeFrom(String fullText, int fromOffset, {bool tamil = false, TtsSpeaker speaker = TtsSpeaker.teacher}) async {
    final start = fromOffset.clamp(0, fullText.length);
    if (start >= fullText.length) return;
    await _speakSlice(fullText.substring(start), fullText: fullText, baseOffset: start, tamil: tamil, speaker: speaker);
  }

  Future<void> _speakSlice(
    String slice, {
    required String fullText,
    required int baseOffset,
    required bool tamil,
    TtsSpeaker speaker = TtsSpeaker.teacher,
  }) async {
    await init();
    await _tts.stop();
    _curFullText = fullText;
    _curBaseOffset = baseOffset;
    _curWordOffset = 0;

    if (tamil) {
      bool voiceSet = false;
      if (_tamilVoiceName != null) {
        try {
          await _tts.setVoice({"name": _tamilVoiceName!, "locale": _tamilVoiceLocale!});
          voiceSet = true;
        } catch (_) {
          // Fall through to the best-effort attempt below.
        }
      }
      if (!voiceSet) {
        try {
          await _tts.setLanguage("ta-IN");
        } catch (_) {
          throw StateError("tamil-voice-unavailable");
        }
      }
      await _tts.setPitch(1.0);
      await _tts.setSpeechRate((0.42 * _rateMultiplier).clamp(0.1, 1.0));
    } else {
      // Base rates stay exactly as originally tuned; rateMultiplier (from
      // the Settings screen) scales on top of them. flutter_tts expects a
      // rate roughly in 0.0-1.0 on Android, so the final value is clamped
      // to stay in range even at the fastest 1.5x setting.
      if (speaker == TtsSpeaker.friend) {
        await _tts.setPitch(1.35);
        await _tts.setSpeechRate((0.46 * _rateMultiplier).clamp(0.1, 1.0));
      } else {
        await _tts.setPitch(1.0);
        await _tts.setSpeechRate((0.42 * _rateMultiplier).clamp(0.1, 1.0));
      }
    }

    final completer = Completer<void>();
    _speakCompleter = completer;
    // Fire-and-forget on purpose — see the note in init() above about why
    // we don't await this call directly.
    // ignore: unawaited_futures
    _tts.speak(slice);
    // Belt-and-suspenders: if the platform never calls any of our
    // completion/error/cancel handlers for some reason, don't let a
    // caller (like the lesson auto-play loop) hang forever.
    await completer.future.timeout(const Duration(seconds: 30), onTimeout: () {});

    if (tamil) {
      // Switch back to the student's chosen English teacher voice so the
      // next "Listen" tap on English text isn't stuck on the Tamil one.
      final v = _selectedVoice;
      if (v != null) {
        try {
          await _tts.setVoice({"name": v.name, "locale": v.locale});
        } catch (_) {
          // Non-fatal — worst case the next English speak() call re-binds
          // its own voice anyway via _selectIndianEnglish's saved choice.
        }
      }
    }
  }

  /// Stops speaking right now — a hard stop, forgetting any paused
  /// position (unlike [pause]). Safe to call even if nothing is speaking.
  /// Immediately unblocks anything awaiting speak() — a caller doing
  /// `await speak(...)` in a loop (like the lesson auto-play) can check a
  /// "did the user pause?" flag right after this and stop cleanly, instead
  /// of the audio continuing to read on with no way to interrupt it.
  Future<void> stop() async {
    _finishSpeak();
    await _tts.stop();
    _curFullText = null;
    _curBaseOffset = 0;
    _curWordOffset = 0;
  }
}
