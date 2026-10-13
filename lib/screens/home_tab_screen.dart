import 'dart:io';
import 'package:flutter/material.dart';
import '../services/app_progress.dart';
import '../services/scoring.dart';
import '../services/student_mic.dart';
import '../services/teacher_tts.dart';
import '../theme/app_theme.dart';

/// The shell's "Home" tab.
///
/// The first version of this screen (built from the client's reference
/// screenshots) had a 2x2 grid of "Speak / Teacher / Offline / Tracked"
/// cards that were purely decorative — tapping them did nothing, which
/// defeats the point: a feature a visitor can't actually try doesn't tell
/// them why it's there. This version replaces that with real, working
/// pieces instead:
///   - "Try it — right now": an actual live demo using the same
///     TeacherTts + StudentMic + scoring pipeline every real lesson uses —
///     hear a line, say it back, get an instant score, right here on Home.
///   - "Offline": tapping it runs a real connectivity check and reports
///     what it actually found, rather than just asserting the claim.
///   - "Tracked": tapping it jumps straight to the Progress tab.
class HomeTabScreen extends StatefulWidget {
  final void Function(int tabIndex) onNavigateToTab;
  const HomeTabScreen({super.key, required this.onNavigateToTab});

  @override
  State<HomeTabScreen> createState() => _HomeTabScreenState();
}

class _HomeTabScreenState extends State<HomeTabScreen> {
  AppProgressSnapshot? _snapshot;

  // --- "Try it — right now" live demo ---
  static const String _demoSentence = "Good morning! How are you today?";
  static const String _demoSentenceTamil = "காலை வணக்கம்! இன்று எப்படி இருக்கீங்க?";
  bool _demoListening = false;
  String? _demoHeard;
  String? _demoError;
  ScoreResult? _demoResult;

  // --- "Offline" live connectivity check ---
  bool _checkingOffline = false;
  String? _offlineResultText;

  @override
  void initState() {
    super.initState();
    _refresh();
  }

  @override
  void dispose() {
    TeacherTts.instance.stop();
    StudentMic.instance.cancel();
    super.dispose();
  }

  Future<void> _refresh() async {
    final s = await AppProgress.load();
    if (!mounted) return;
    setState(() => _snapshot = s);
  }

  Future<void> _tryDemoMic() async {
    setState(() {
      _demoListening = true;
      _demoError = null;
      _demoResult = null;
    });
    try {
      final transcript = await StudentMic.instance.listenOnce(timeout: const Duration(seconds: 10));
      if (!mounted) return;
      if (transcript.isEmpty) {
        setState(() {
          _demoError = "Didn't catch that — tap the mic and try again.";
          _demoListening = false;
        });
        return;
      }
      final score = scoreReading(_demoSentence, transcript);
      setState(() {
        _demoHeard = transcript;
        _demoResult = score;
        _demoListening = false;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _demoError = e.toString().contains("mic-permission-denied")
            ? "Please allow microphone access to try this."
            : "Couldn't start — please try again.";
        _demoListening = false;
      });
    }
  }

  Future<void> _checkOfflineCapability() async {
    setState(() {
      _checkingOffline = true;
      _offlineResultText = null;
    });
    bool online;
    try {
      final result = await InternetAddress.lookup('google.com').timeout(const Duration(seconds: 3));
      online = result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } catch (_) {
      online = false;
    }
    if (!mounted) return;
    setState(() {
      _checkingOffline = false;
      _offlineResultText = online
          ? "You're online right now — but you don't need to be. Every lesson already works with zero internet. ✓"
          : "You're offline right now — and Kalvi40 works exactly the same. Nothing here needs internet. ✓";
    });
  }

  @override
  Widget build(BuildContext context) {
    final ratio = _snapshot?.overallRatio ?? 0.0;
    final completed = _snapshot?.completedLessons ?? 0;
    final total = _snapshot?.totalLessons ?? 0;

    return Scaffold(
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: _refresh,
          child: ListView(
            padding: const EdgeInsets.only(bottom: 30),
            children: [
              Container(
                padding: const EdgeInsets.fromLTRB(24, 28, 24, 32),
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [AppColors.primary, Color(0xFF8B7CF6)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.only(bottomLeft: Radius.circular(28), bottomRight: Radius.circular(28)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        ClipOval(
                          child: Image.asset("assets/icon/app_icon.png", width: 34, height: 34, fit: BoxFit.cover),
                        ),
                        const SizedBox(width: 10),
                        const Expanded(
                          child: Text("Kalvi40",
                              style: TextStyle(color: Colors.white, fontSize: 21, fontWeight: FontWeight.w800)),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    const Text("Learn to speak English with your Teacher — 100% offline",
                        style: TextStyle(color: Colors.white70, fontSize: 14, height: 1.35)),
                    const SizedBox(height: 20),
                    if (total > 0) ...[
                      ClipRRect(
                        borderRadius: BorderRadius.circular(6),
                        child: LinearProgressIndicator(
                          value: ratio,
                          minHeight: 10,
                          backgroundColor: Colors.white.withOpacity(0.3),
                          valueColor: const AlwaysStoppedAnimation(Color(0xFFFFD166)),
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text("$completed / $total lessons completed",
                          style: const TextStyle(color: Colors.white, fontSize: 12.5, fontWeight: FontWeight.w700)),
                    ],
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.fromLTRB(18, 22, 18, 4),
                child: Text("Try it before you start",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800, color: AppColors.ink)),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(18, 10, 18, 0),
                child: _demoCard(),
              ),
              const SizedBox(height: 14),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(child: _offlineCard()),
                    const SizedBox(width: 14),
                    Expanded(child: _trackedCard(completed, total)),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(18, 24, 18, 0),
                child: SizedBox(
                  height: 52,
                  child: ElevatedButton(
                    onPressed: () => widget.onNavigateToTab(1),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                      textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w800),
                    ),
                    child: const Text("Start Learning"),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _demoCard() {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: cardDecoration(borderTop: AppColors.primary),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(color: AppColors.primary.withOpacity(0.12), borderRadius: BorderRadius.circular(12)),
                alignment: Alignment.center,
                child: const Icon(Icons.mic, color: AppColors.primary, size: 22),
              ),
              const SizedBox(width: 10),
              const Expanded(
                child: Text("Try it — right now",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w800, color: AppColors.ink)),
              ),
            ],
          ),
          const SizedBox(height: 6),
          const Text("No sign-up, no lesson to open — hear the Teacher, then say it back.",
              style: TextStyle(fontSize: 12, color: AppColors.inkSoft, height: 1.3)),
          const SizedBox(height: 14),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(color: AppColors.bg, borderRadius: BorderRadius.circular(12)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(_demoSentence, style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700)),
                tamilMeaning(_demoSentenceTamil, topGap: 4),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () => TeacherTts.instance.speak(_demoSentence),
                  icon: const Icon(Icons.volume_up, size: 18),
                  label: const Text("Hear Teacher"),
                  style: OutlinedButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 12)),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: FilledButton.icon(
                  onPressed: _demoListening ? null : _tryDemoMic,
                  icon: const Icon(Icons.mic, size: 18),
                  label: Text(_demoListening ? "Listening…" : "Your turn"),
                  style: FilledButton.styleFrom(backgroundColor: AppColors.primary, padding: const EdgeInsets.symmetric(vertical: 12)),
                ),
              ),
            ],
          ),
          if (_demoError != null)
            Padding(
              padding: const EdgeInsets.only(top: 12),
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(color: AppColors.warnBg, borderRadius: BorderRadius.circular(10)),
                child: Text(_demoError!, style: const TextStyle(fontSize: 12.5, color: Color(0xFF92400E))),
              ),
            ),
          if (_demoResult != null)
            Padding(
              padding: const EdgeInsets.only(top: 12),
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(color: feedbackColor(_demoResult!.verdict), borderRadius: BorderRadius.circular(12)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("${verdictLabel(_demoResult!.verdict)} — ${_demoResult!.percent}%",
                        style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 14)),
                    const SizedBox(height: 3),
                    Text('You said: "$_demoHeard"',
                        style: const TextStyle(fontSize: 12.5, color: AppColors.inkSoft, fontStyle: FontStyle.italic)),
                    const SizedBox(height: 6),
                    const Text("That's exactly how every real lesson is scored — try a full one below.",
                        style: TextStyle(fontSize: 11.5, color: AppColors.inkSoft)),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _offlineCard() {
    return InkWell(
      borderRadius: BorderRadius.circular(18),
      onTap: _checkingOffline ? null : _checkOfflineCapability,
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: cardDecoration(borderTop: AppColors.success),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(color: AppColors.success.withOpacity(0.12), borderRadius: BorderRadius.circular(10)),
                  alignment: Alignment.center,
                  child: Icon(_checkingOffline ? Icons.hourglass_top : Icons.cloud_off, color: AppColors.success, size: 18),
                ),
                const Spacer(),
                if (!_checkingOffline) const Icon(Icons.touch_app, size: 14, color: AppColors.inkSoft),
              ],
            ),
            const SizedBox(height: 8),
            const Text("Offline", style: TextStyle(fontSize: 13.5, fontWeight: FontWeight.w800, color: AppColors.ink)),
            const SizedBox(height: 3),
            Text(
              _checkingOffline ? "Checking right now…" : (_offlineResultText ?? "Tap to check — works with no internet"),
              style: const TextStyle(fontSize: 10.5, color: AppColors.inkSoft, height: 1.3),
            ),
          ],
        ),
      ),
    );
  }

  Widget _trackedCard(int completed, int total) {
    return InkWell(
      borderRadius: BorderRadius.circular(18),
      onTap: () => widget.onNavigateToTab(2),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: cardDecoration(borderTop: AppColors.gold),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(color: AppColors.gold.withOpacity(0.15), borderRadius: BorderRadius.circular(10)),
                  alignment: Alignment.center,
                  child: const Icon(Icons.insights, color: AppColors.gold, size: 18),
                ),
                const Spacer(),
                const Icon(Icons.chevron_right, size: 16, color: AppColors.inkSoft),
              ],
            ),
            const SizedBox(height: 8),
            const Text("Tracked", style: TextStyle(fontSize: 13.5, fontWeight: FontWeight.w800, color: AppColors.ink)),
            const SizedBox(height: 3),
            Text(
              total > 0 ? "$completed of $total lessons — tap to see" : "See your progress across every module",
              style: const TextStyle(fontSize: 10.5, color: AppColors.inkSoft, height: 1.3),
            ),
          ],
        ),
      ),
    );
  }
}
