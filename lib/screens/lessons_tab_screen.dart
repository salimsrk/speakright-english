import 'package:flutter/material.dart';
import '../data/module_catalog.dart';
import '../services/app_progress.dart';
import '../theme/app_theme.dart';
import 'home_screen.dart';
import 'module2/vocab_home_screen.dart';
import 'module3/grammar_home_screen.dart';
import 'module4/comprehension_home_screen.dart';
import 'module5/composition_home_screen.dart';

/// The shell's "Lessons" tab — this replaces the old ModuleSelectScreen as
/// the way into the 5 modules, but now with a real overall progress bar up
/// top and a real per-module progress bar + "X of Y lessons" count on each
/// card, sourced from AppProgress (ProgressStore for Module 1, which is
/// score-gated, combined with LessonProgressStore for Modules 2-5, which is
/// view-gated — see app_progress.dart).
class LessonsTabScreen extends StatefulWidget {
  const LessonsTabScreen({super.key});

  @override
  State<LessonsTabScreen> createState() => _LessonsTabScreenState();
}

class _LessonsTabScreenState extends State<LessonsTabScreen> {
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

  Widget _screenFor(String moduleId) {
    switch (moduleId) {
      case "module1":
        return const HomeScreen();
      case "module2":
        return const VocabHomeScreen();
      case "module3":
        return const GrammarHomeScreen();
      case "module4":
        return const ComprehensionHomeScreen();
      case "module5":
      default:
        return const CompositionHomeScreen();
    }
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
            padding: const EdgeInsets.only(bottom: 24),
            children: [
              Container(
                padding: const EdgeInsets.fromLTRB(24, 24, 24, 26),
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
                    const Text("Lessons", style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.w800)),
                    const SizedBox(height: 4),
                    const Text("All 5 modules from your course book",
                        style: TextStyle(color: Colors.white70, fontSize: 13.5)),
                    const SizedBox(height: 16),
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
              const SizedBox(height: 18),
              for (final module in moduleCatalog)
                Padding(
                  padding: const EdgeInsets.fromLTRB(18, 0, 18, 14),
                  child: _ModuleTile(
                    module: module,
                    progress: _snapshot?.modules.firstWhere(
                      (m) => m.module.id == module.id,
                      orElse: () => ModuleProgress(module: module, completedLessons: 0),
                    ),
                    onTap: () async {
                      await Navigator.of(context).push(MaterialPageRoute(builder: (_) => _screenFor(module.id)));
                      _refresh();
                    },
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ModuleTile extends StatelessWidget {
  final ModuleCatalogEntry module;
  final ModuleProgress? progress;
  final VoidCallback onTap;
  const _ModuleTile({required this.module, required this.progress, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final ratio = progress?.ratio ?? 0.0;
    final completed = progress?.completedLessons ?? 0;
    return InkWell(
      borderRadius: BorderRadius.circular(20),
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(18),
        decoration: cardDecoration(borderTop: module.color),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 54,
                  height: 54,
                  decoration: BoxDecoration(color: module.color.withOpacity(0.12), borderRadius: BorderRadius.circular(16)),
                  alignment: Alignment.center,
                  child: Text(module.emoji, style: const TextStyle(fontSize: 28)),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(module.title, style: const TextStyle(fontSize: 15.5, fontWeight: FontWeight.w800, color: AppColors.ink)),
                      const SizedBox(height: 4),
                      Text(module.subtitle, style: const TextStyle(fontSize: 12.5, color: AppColors.inkSoft, height: 1.35)),
                    ],
                  ),
                ),
                const Icon(Icons.chevron_right, color: AppColors.inkSoft),
              ],
            ),
            const SizedBox(height: 14),
            ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: LinearProgressIndicator(
                value: ratio,
                minHeight: 8,
                backgroundColor: AppColors.bg,
                valueColor: AlwaysStoppedAnimation(module.color),
              ),
            ),
            const SizedBox(height: 6),
            Text("$completed of ${module.totalLessons} lessons",
                style: const TextStyle(fontSize: 11.5, color: AppColors.inkSoft, fontWeight: FontWeight.w700)),
          ],
        ),
      ),
    );
  }
}
