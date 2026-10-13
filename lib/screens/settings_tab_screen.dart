import 'package:flutter/material.dart';
import '../services/teacher_tts.dart';
import '../theme/app_theme.dart';

/// Settings tab — Teacher Voice Speed (always worked) plus the newer
/// Teacher Voice picker: real, on-device Indian-English voices the
/// student can tap to preview and choose, built from whatever the
/// engine's own getVoices() genuinely has installed on this phone.
class SettingsTabScreen extends StatefulWidget {
  const SettingsTabScreen({super.key});

  @override
  State<SettingsTabScreen> createState() => _SettingsTabScreenState();
}

class _SettingsTabScreenState extends State<SettingsTabScreen> {
  double _rate = 1.0;
  bool _loaded = false;

  // --- Teacher Voice picker ---
  List<TtsVoiceOption> _voices = [];
  TtsVoiceOption? _selectedVoice;
  String? _previewingVoiceName; // name of the chip currently speaking
  bool _refreshing = false;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    // Ensures TeacherTts (and its saved rate/voice) is initialized even if
    // the student opens Settings before ever using the mic/teacher voice.
    await TeacherTts.instance.init();
    if (!mounted) return;
    setState(() {
      _rate = TeacherTts.instance.rateMultiplier;
      _voices = TeacherTts.instance.voiceOptions;
      _selectedVoice = TeacherTts.instance.selectedVoice;
      _loaded = true;
    });
  }

  String _label(double rate) {
    if ((rate - 1.0).abs() < 0.03) return "Normal";
    if (rate < 1.0) return "${rate.toStringAsFixed(1)}×";
    return "${rate.toStringAsFixed(1)}×";
  }

  /// Taps a voice chip: switches to that voice and speaks a short sample
  /// so the student can hear it right away — "tap a voice to hear it".
  Future<void> _previewVoice(TtsVoiceOption voice) async {
    setState(() => _previewingVoiceName = voice.name);
    await TeacherTts.instance.previewVoice(voice);
    if (!mounted) return;
    setState(() {
      _selectedVoice = TeacherTts.instance.selectedVoice;
      _previewingVoiceName = null;
    });
  }

  /// Re-detects voices — picks up an Indian English voice pack just
  /// installed from the phone's own Settings app, without closing and
  /// reopening SpeakRight.
  Future<void> _refreshVoices() async {
    setState(() => _refreshing = true);
    await TeacherTts.instance.recheckVoice();
    if (!mounted) return;
    setState(() {
      _voices = TeacherTts.instance.voiceOptions;
      _selectedVoice = TeacherTts.instance.selectedVoice;
      _refreshing = false;
    });
  }

  String _voiceSubtitle() {
    if (!_loaded) return "Checking available voices…";
    if (_voices.isEmpty) return "No Indian voice installed on this phone yet";
    return "Indian English · tap a voice to hear it";
  }

  void _showGetMoreVoicesSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (ctx) => Container(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 28),
        decoration: const BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 40,
              height: 4,
              margin: const EdgeInsets.only(bottom: 18),
              decoration: BoxDecoration(color: AppColors.bg, borderRadius: BorderRadius.circular(4)),
              alignment: Alignment.center,
            ),
            const Text("Get more Indian voices", style: TextStyle(fontSize: 17, fontWeight: FontWeight.w800)),
            const SizedBox(height: 12),
            const Text(
              "1. Open this phone's own Settings app\n"
              "2. Go to System → Languages & input → Text-to-speech output\n"
              "3. Tap the gear icon next to the preferred engine (usually Google)\n"
              "4. Tap \"Install voice data\"\n"
              "5. Find \"English (India)\" and download it\n"
              "6. Come back to SpeakRight → Settings and tap the refresh icon above",
              style: TextStyle(fontSize: 13.5, color: AppColors.inkSoft, height: 1.6),
            ),
            const SizedBox(height: 18),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => Navigator.of(ctx).pop(),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 13),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                child: const Text("Got it", style: TextStyle(fontWeight: FontWeight.w800)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _voiceChip(TtsVoiceOption voice) {
    final selected = _selectedVoice?.name == voice.name;
    final loading = _previewingVoiceName == voice.name;
    return GestureDetector(
      onTap: _previewingVoiceName != null ? null : () => _previewVoice(voice),
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
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text("Teacher Voice", style: TextStyle(fontSize: 15.5, fontWeight: FontWeight.w800)),
                            const SizedBox(height: 2),
                            Text(_voiceSubtitle(),
                                style: const TextStyle(fontSize: 12.5, color: AppColors.inkSoft, height: 1.35)),
                          ],
                        ),
                      ),
                      IconButton(
                        onPressed: _refreshing ? null : _refreshVoices,
                        tooltip: "Check for more voices",
                        icon: _refreshing
                            ? const SizedBox(width: 18, height: 18, child: CircularProgressIndicator(strokeWidth: 2))
                            : const Icon(Icons.refresh, color: AppColors.primary),
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),
                  if (!_loaded)
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 8),
                      child: Text("Checking…", style: TextStyle(fontSize: 13, color: AppColors.inkSoft)),
                    )
                  else if (_voices.isEmpty)
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 4),
                      child: Text(
                        "This phone's Indian English voice pack isn't installed yet — the teacher is using "
                        "the phone's default voice for now.",
                        style: TextStyle(fontSize: 12.5, color: AppColors.inkSoft, height: 1.45),
                      ),
                    )
                  else
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(children: [for (final v in _voices) _voiceChip(v)]),
                    ),
                  const SizedBox(height: 14),
                  GestureDetector(
                    onTap: _showGetMoreVoicesSheet,
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.file_download_outlined, size: 16, color: AppColors.primary),
                        SizedBox(width: 6),
                        Text("Get more voices", style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.w800, fontSize: 13.5)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40),
            const Center(
              child: Text("Developed by SRK Nexus AI", style: TextStyle(color: AppColors.inkSoft, fontSize: 13, fontWeight: FontWeight.w700)),
            ),
          ],
        ),
      ),
    );
  }
}
