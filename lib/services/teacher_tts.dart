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

  Future<void> init() async {
    if (_ready) return;
    await _loadRateMultiplier();
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
  }

  /// The locale we ended up selecting (best-effort — for diagnostics only).
  String? _activeLocale;
  String? get activeLocale => _activeLocale;

  /// True only when [activeLocale] was confirmed against the engine's own
  /// list of installed voices (step 1 above) — not just requested blind.
  bool _activeLocaleConfirmed = false;
  bool get activeLocaleConfirmed => _activeLocaleConfirmed;

  /// Speaks [text] as the given [speaker] and completes once the phone has
  /// finished saying it (or the speech was paused/stopped/errored).
  /// Awaiting this is always safe — it can never hang forever.
  Future<void> speak(String text, {TtsSpeaker speaker = TtsSpeaker.teacher}) async {
    await init();
    await _tts.stop();
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
