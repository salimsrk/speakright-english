import 'package:flutter/material.dart';
import '../services/app_progress.dart';
import '../theme/app_theme.dart';

/// The shell's "Progress" tab. The reference screenshots showed a daily
/// streak ("Day 1/8/9/10, Activity 0") — this app has no day/streak
/// tracking anywhere, so rather than fabricate fake streak data, this
/// shows what we can actually back with real numbers: an overall
/// completion ring plus a real per-module breakdown, from AppProgress.
class ProgressTabScreen extends StatefulWidget {
  const ProgressTabScreen({super.key});

  @override
  State<ProgressTabScreen> createState() => _ProgressTabScreenState();
}

class _ProgressTabScreenState extends State<ProgressTabScreen> {
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
    final snapshot = _snapshot;
    final ratio = snapshot?.overallRatio ?? 0.0;
    final completed = snapshot?.completedLessons ?? 0;
    final total = snapshot?.totalLessons ?? 0;

    return Scaffold(
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: _refresh,
          child: ListView(
            padding: const EdgeInsets.all(18),
            children: [
              const Padding(
                padding: EdgeInsets.only(bottom: 18, top: 6),
                child: Text("Progress", style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800, color: AppColors.ink)),
              ),
              Container(
                padding: const EdgeInsets.all(20),
                decoration: cardDecoration(borderTop: AppColors.primary),
                child: Column(
                  children: [
                    SizedBox(
                      width: 120,
                      height: 120,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          SizedBox(
                            width: 120,
                            height: 120,
                            child: CircularProgressIndicator(
                              value: total == 0 ? 0 : ratio,
                              strokeWidth: 10,
                              backgroundColor: AppColors.bg,
                              valueColor: const AlwaysStoppedAnimation(AppColors.primary),
                            ),
                          ),
                          Text("${(ratio * 100).round()}%",
                              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w800, color: AppColors.ink)),
                        ],
                      ),
                    ),
                    const SizedBox(height: 14),
                    Text("$completed of $total lessons completed",
                        style: const TextStyle(fontSize: 13.5, color: AppColors.inkSoft, fontWeight: FontWeight.w700)),
                  ],
                ),
              ),
              const SizedBox(height: 22),
              const Text("By module", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800, color: AppColors.ink)),
              const SizedBox(height: 12),
              if (snapshot != null)
                for (final m in snapshot.modules)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: cardDecoration(),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(m.module.emoji, style: const TextStyle(fontSize: 20)),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Text(m.module.title,
                                    style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w800, color: AppColors.ink)),
                              ),
                              Text("${m.completedLessons}/${m.totalLessons}",
                                  style: TextStyle(fontSize: 12.5, fontWeight: FontWeight.w800, color: m.module.color)),
                            ],
                          ),
                          const SizedBox(height: 10),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(6),
                            child: LinearProgressIndicator(
                              value: m.ratio,
                              minHeight: 8,
                              backgroundColor: AppColors.bg,
                              valueColor: AlwaysStoppedAnimation(m.module.color),
                            ),
                          ),
                        ],
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
