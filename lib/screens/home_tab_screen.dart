import 'package:flutter/material.dart';
import '../services/app_progress.dart';
import '../theme/app_theme.dart';

/// The shell's "Home" tab — a welcome header, a small row of feature
/// highlights, and a "Start Learning" button that jumps straight to the
/// Lessons tab. Purely a landing page; all real navigation into modules
/// happens from the Lessons tab.
class HomeTabScreen extends StatefulWidget {
  final VoidCallback onStartLearning;
  const HomeTabScreen({super.key, required this.onStartLearning});

  @override
  State<HomeTabScreen> createState() => _HomeTabScreenState();
}

class _HomeTabScreenState extends State<HomeTabScreen> {
  AppProgressSnapshot? _snapshot;

  @override
  void initState() {
    super.initState();
    _refresh();
  }

  Future<void> _refresh() async {
    final s = await AppProgress.load();
    if (!mounted) return;
    setState(() => _snapshot = s);
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
                    const Row(
                      children: [
                        Text("🗣️", style: TextStyle(fontSize: 28)),
                        SizedBox(width: 8),
                        Expanded(
                          child: Text("SpeakRight English",
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
                child: Text("Why students like it",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800, color: AppColors.ink)),
              ),
              Padding(
                padding: const EdgeInsets.all(18),
                child: GridView.count(
                  crossAxisCount: 2,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  mainAxisSpacing: 14,
                  crossAxisSpacing: 14,
                  childAspectRatio: 1.15,
                  children: const [
                    _FeatureCard(icon: Icons.mic, label: "Speak", subtitle: "Practice out loud, get scored instantly"),
                    _FeatureCard(icon: Icons.record_voice_over, label: "Teacher", subtitle: "A patient voice guides every lesson"),
                    _FeatureCard(icon: Icons.cloud_off, label: "Offline", subtitle: "Works with no internet connection"),
                    _FeatureCard(icon: Icons.insights, label: "Tracked", subtitle: "See your progress across every module"),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(18, 10, 18, 0),
                child: SizedBox(
                  height: 52,
                  child: ElevatedButton(
                    onPressed: widget.onStartLearning,
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
}

class _FeatureCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final String subtitle;
  const _FeatureCard({required this.icon, required this.label, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: cardDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(color: AppColors.primary.withOpacity(0.12), borderRadius: BorderRadius.circular(12)),
            alignment: Alignment.center,
            child: Icon(icon, color: AppColors.primary, size: 22),
          ),
          const SizedBox(height: 10),
          Text(label, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w800, color: AppColors.ink)),
          const SizedBox(height: 3),
          Text(subtitle, style: const TextStyle(fontSize: 11, color: AppColors.inkSoft, height: 1.3)),
        ],
      ),
    );
  }
}
