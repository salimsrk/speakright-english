import 'package:shared_preferences/shared_preferences.dart';

/// Tracks which Module 2-5 "lessons" (word-list sections, grammar topics,
/// comprehension passages, composition sections — one per tile on each
/// module's home screen) the student has opened at least once, saved
/// directly on the phone. No account, no server, nothing ever leaves the
/// device — same approach as ProgressStore (Module 1's existing per-topic
/// score tracking), which this deliberately does not replace or touch.
///
/// Module 1 already has real, score-based completion tracking (see
/// ProgressStore / results_screen.dart) — a topic only counts as done
/// once the student has actually practiced and been scored on it. Modules
/// 2-5 have no such scoring step (they're browsing/quiz screens, not
/// speaking-practice screens), so "viewed at least once" is the
/// meaningful, honest definition of "done" for them. See AppProgress for
/// how the two are combined into one set of module/overall numbers for
/// the Lessons and Progress tabs.
class LessonProgressStore {
  static const _key = "speakright_lessons_viewed_v1";

  /// Loads the full set of viewed lesson IDs. Never throws — a read
  /// failure (corrupt data, first run, etc.) just means an empty set.
  static Future<Set<String>> load() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final list = prefs.getStringList(_key);
      return list == null ? <String>{} : list.toSet();
    } catch (e) {
      return <String>{};
    }
  }

  /// Marks a single lesson ID as viewed. Fire-and-forget safe — callers
  /// don't need to await this from a tap handler.
  static Future<void> markViewed(String lessonId) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final current = prefs.getStringList(_key) ?? <String>[];
      if (!current.contains(lessonId)) {
        current.add(lessonId);
        await prefs.setStringList(_key, current);
      }
    } catch (e) {
      // Non-fatal — progress just won't be recorded for this lesson this
      // time; browsing the content itself is unaffected either way.
    }
  }
}
