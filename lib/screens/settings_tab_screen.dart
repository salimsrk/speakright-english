import 'package:flutter/material.dart';
import '../services/teacher_tts.dart';
import '../theme/app_theme.dart';

/// Settings tab — Teacher Voice Speed only. The permanent English voice
/// picker (Indian-voice chips the student could tap to preview/choose) was
/// removed per the client's explicit request: they listened to every voice
/// and picked one specific one ("Indian English 7") to use everywhere, with
/// no further choice shown to students — see TeacherTts._selectIndianEnglish
/// for where that pinned voice is applied.
///
/// The temporary "Tamil Voice (testing)" card that lived here has likewise
/// been removed: the client tested the Tamil voices on their phone and
/// confirmed "Tamil 2" — now hardcoded in TeacherTts._pinnedTamilVoiceIndex,
/// the same pinning pattern used for the English voice above.
class SettingsTabScreen extends StatefulWidget {
  const SettingsTabScreen({super.key});

  @override
  State<SettingsTabScreen> createState() => _SettingsTabScreenState();
}

class _SettingsTabScreenState extends State<SettingsTabScreen> {
  double _rate = 1.0;
  bool _loaded = false;

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
      _loaded = true;
    });
  }

  String _label(double rate) {
    if ((rate - 1.0).abs() < 0.03) return "Normal";
    if (rate < 1.0) return "${rate.toStringAsFixed(1)}×";
    return "${rate.toStringAsFixed(1)}×";
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
          ],
        ),
      ),
    );
  }
}
