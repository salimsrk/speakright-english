import 'package:flutter/material.dart';
import '../services/teacher_tts.dart';
import '../theme/app_theme.dart';

/// Settings tab — Teacher Voice Speed, plus a TEMPORARY "Tamil Voice"
/// testing card. The permanent English voice picker (Indian-voice chips
/// the student could tap to preview/choose) was removed per the client's
/// explicit request: they listened to every voice and picked one specific
/// one ("Indian English 7") to use everywhere, with no further choice
/// shown to students — see TeacherTts._selectIndianEnglish for where that
/// pinned voice is applied.
///
/// The Tamil card below exists only because the auto-picked Tamil voice
/// turned out to sound female and the client wants a different one, and
/// there is no "gender" field the app can read from the TTS engine to
/// pick correctly on its own — same situation the English picker solved
/// by letting the client tap through voices and tell us which one to
/// pin. Once the client confirms a Tamil voice here, it should be
/// hardcoded the same way "Indian English 7" was, and this card removed.
class SettingsTabScreen extends StatefulWidget {
  const SettingsTabScreen({super.key});

  @override
  State<SettingsTabScreen> createState() => _SettingsTabScreenState();
}

class _SettingsTabScreenState extends State<SettingsTabScreen> {
  double _rate = 1.0;
  bool _loaded = false;

  // --- Temporary Tamil Voice testing list ---
  List<TtsVoiceOption> _tamilVoices = [];
  TtsVoiceOption? _selectedTamilVoice;
  String? _previewingTamilVoiceName;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    // Ensures TeacherTts (and its saved rate, and its pinned voices) is
    // initialized even if the student opens Settings before ever using
    // the mic/teacher voice.
    await TeacherTts.instance.init();
    if (!mounted) return;
    setState(() {
      _rate = TeacherTts.instance.rateMultiplier;
      _tamilVoices = TeacherTts.instance.tamilVoiceOptions;
      _selectedTamilVoice = TeacherTts.instance.selectedTamilVoice;
      _loaded = true;
    });
  }

  String _label(double rate) {
    if ((rate - 1.0).abs() < 0.03) return "Normal";
    if (rate < 1.0) return "${rate.toStringAsFixed(1)}×";
    return "${rate.toStringAsFixed(1)}×";
  }

  Future<void> _previewTamilVoice(TtsVoiceOption voice) async {
    setState(() => _previewingTamilVoiceName = voice.name);
    await TeacherTts.instance.previewTamilVoice(voice);
    if (!mounted) return;
    setState(() {
      _selectedTamilVoice = TeacherTts.instance.selectedTamilVoice;
      _previewingTamilVoiceName = null;
    });
  }

  Widget _tamilVoiceChip(TtsVoiceOption voice) {
    final selected = _selectedTamilVoice?.name == voice.name;
    final loading = _previewingTamilVoiceName == voice.name;
    return GestureDetector(
      onTap: _previewingTamilVoiceName != null ? null : () => _previewTamilVoice(voice),
      child: Container(
        margin: const EdgeInsets.only(right: 10),
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
        decoration: BoxDecoration(
          color: selected ? AppColors.primary : AppColors.surface,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: selected ? AppColors.primary : AppColors.primary.withOpacity(0.3), width: 1.4),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (loading) ...[
              SizedBox(
                width: 14,
                height: 14,
                child: CircularProgressIndicator(strokeWidth: 2, color: selected ? Colors.white : AppColors.primary),
              ),
              const SizedBox(width: 8),
            ] else if (selected) ...[
              const Icon(Icons.volume_up, size: 16, color: Colors.white),
              const SizedBox(width: 6),
            ],
            Text(
              voice.label,
              style: TextStyle(
                fontSize: 13.5,
                fontWeight: FontWeight.w700,
                color: selected ? Colors.white : AppColors.ink,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(18),
          children: [
            const Padding(
              padding: EdgeInsets.only(bottom: 18, top: 6),
              child: Text("Settings", style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800, color: AppColors.ink)),
            ),
            Container(
              padding: const EdgeInsets.all(18),
              decoration: cardDecoration(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 44,
                        height: 44,
                        decoration: BoxDecoration(color: AppColors.primary.withOpacity(0.12), borderRadius: BorderRadius.circular(12)),
                        alignment: Alignment.center,
                        child: const Icon(Icons.record_voice_over, color: AppColors.primary),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text("Teacher Voice Speed", style: TextStyle(fontSize: 15.5, fontWeight: FontWeight.w800)),
                            SizedBox(height: 2),
                            Text("Drag to adjust how fast the teacher speaks",
                                style: TextStyle(fontSize: 12.5, color: AppColors.inkSoft, height: 1.35)),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(color: AppColors.bg, borderRadius: BorderRadius.circular(20)),
                        child: Text(_loaded ? _label(_rate) : "…",
                            style: const TextStyle(color: AppColors.primaryDark, fontWeight: FontWeight.w800, fontSize: 13)),
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),
                  SliderTheme(
                    data: SliderTheme.of(context).copyWith(
                      activeTrackColor: AppColors.primary,
                      inactiveTrackColor: AppColors.primary.withOpacity(0.18),
                      thumbColor: AppColors.primary,
                      overlayColor: AppColors.primary.withOpacity(0.15),
                    ),
                    child: Slider(
                      value: _rate.clamp(0.5, 1.5),
                      min: 0.5,
                      max: 1.5,
                      divisions: 10,
                      onChanged: _loaded
                          ? (v) => setState(() => _rate = v)
                          : null,
                      onChangeEnd: (v) => TeacherTts.instance.setRateMultiplier(v),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text("0.5× Slow", style: TextStyle(fontSize: 11.5, color: AppColors.inkSoft)),
                        Text("1.5× Fast", style: TextStyle(fontSize: 11.5, color: AppColors.inkSoft)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(18),
              decoration: cardDecoration(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 44,
                        height: 44,
                        decoration: BoxDecoration(color: AppColors.primary.withOpacity(0.12), borderRadius: BorderRadius.circular(12)),
                        alignment: Alignment.center,
                        child: const Icon(Icons.language, color: AppColors.primary),
                      ),
                      const SizedBox(width: 14),
                      const Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Tamil Voice (testing)", style: TextStyle(fontSize: 15.5, fontWeight: FontWeight.w800)),
                            SizedBox(height: 2),
                            Text("Tap a voice to hear it — tell us which one to keep",
                                style: TextStyle(fontSize: 12.5, color: AppColors.inkSoft, height: 1.35)),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),
                  if (!_loaded)
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 8),
                      child: Text("Checking…", style: TextStyle(fontSize: 13, color: AppColors.inkSoft)),
                    )
                  else if (_tamilVoices.isEmpty)
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 4),
                      child: Text(
                        "No Tamil voice found on this phone. Install one from phone Settings → System → "
                        "Languages & input → Text-to-speech output → Install voice data → \"Tamil\".",
                        style: TextStyle(fontSize: 12.5, color: AppColors.inkSoft, height: 1.45),
                      ),
                    )
                  else if (_tamilVoices.length == 1)
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      child: Text(
                        "Only one Tamil voice (\"${_tamilVoices.first.label}\") is installed on this phone — "
                        "no alternative to switch to here. A different-sounding Tamil voice pack would need to "
                        "be installed from phone Settings first.",
                        style: const TextStyle(fontSize: 12.5, color: AppColors.inkSoft, height: 1.45),
                      ),
                    )
                  else
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(children: [for (final v in _tamilVoices) _tamilVoiceChip(v)]),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
