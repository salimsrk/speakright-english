import '../data/module_catalog.dart';
import 'progress_store.dart';
import 'lesson_progress_store.dart';

/// One module's progress, ready for display (a count + a ratio), combining
/// whichever underlying store actually tracks that module.
class ModuleProgress {
  final ModuleCatalogEntry module;
  final int completedLessons;
  const ModuleProgress({required this.module, required this.completedLessons});

  int get totalLessons => module.totalLessons;
  double get ratio => totalLessons == 0 ? 0.0 : completedLessons / totalLessons;
}

class AppProgressSnapshot {
  final List<ModuleProgress> modules;
  const AppProgressSnapshot(this.modules);

  int get totalLessons => modules.fold(0, (sum, m) => sum + m.totalLessons);
  int get completedLessons => modules.fold(0, (sum, m) => sum + m.completedLessons);
  double get overallRatio => totalLessons == 0 ? 0.0 : completedLessons / totalLessons;
}

/// Combines Module 1's existing score-based ProgressStore (a topic counts
/// once the student has actually practiced and been scored on it) with
/// LessonProgressStore for Modules 2-5 (a lesson counts once opened) into
/// one set of per-module and overall numbers for the Home/Lessons/Progress
/// tabs. Deliberately reads both existing stores as-is rather than
/// changing what either one means — this is purely a read-side rollup.
class AppProgress {
  /// Loads a fresh snapshot of progress across all 5 modules. Never
  /// throws — any individual store failing to read just reports 0 for
  /// that module rather than breaking the whole summary.
  static Future<AppProgressSnapshot> load() async {
    Map<String, TopicProgress> topicProgress = {};
    Set<String> viewedLessons = {};
    try {
      topicProgress = await ProgressStore.load();
    } catch (_) {
      // Fall back to empty — module1's count just reads as 0.
    }
    try {
      viewedLessons = await LessonProgressStore.load();
    } catch (_) {
      // Fall back to empty — modules 2-5 just read as 0.
    }

    final results = <ModuleProgress>[];
    for (final module in moduleCatalog) {
      int completed;
      switch (module.id) {
        case "module1":
          completed = topicProgress.values.where((p) => p.completed).length;
          break;
        case "module2":
          completed = module2LessonIds().where(viewedLessons.contains).length;
          break;
        case "module3":
          completed = module3LessonIds().where(viewedLessons.contains).length;
          break;
        case "module4":
          completed = module4LessonIds().where(viewedLessons.contains).length;
          break;
        case "module5":
          completed = module5LessonIds().where(viewedLessons.contains).length;
          break;
        default:
          completed = 0;
      }
      if (completed > module.totalLessons) completed = module.totalLessons;
      results.add(ModuleProgress(module: module, completedLessons: completed));
    }
    return AppProgressSnapshot(results);
  }
}
