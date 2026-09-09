import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

/// Per-topic progress, saved directly on the student's phone.
/// No account, no server, nothing ever leaves the device.
class TopicProgress {
  final int percent;
  final int stars;
  final bool completed;
  const TopicProgress({required this.percent, required this.stars, required this.completed});

  Map<String, dynamic> toJson() => {"percent": percent, "stars": stars, "completed": completed};
  factory TopicProgress.fromJson(Map<String, dynamic> json) => TopicProgress(
        percent: json["percent"] ?? 0,
        stars: json["stars"] ?? 0,
        completed: json["completed"] ?? false,
      );
}

class ProgressStore {
  static const _key = "speakright_progress_v1";

  static Future<Map<String, TopicProgress>> load() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_key);
    if (raw == null || raw.isEmpty) return {};
    try {
      final decoded = jsonDecode(raw) as Map<String, dynamic>;
      return decoded.map((k, v) => MapEntry(k, TopicProgress.fromJson(v as Map<String, dynamic>)));
    } catch (e) {
      return {};
    }
  }

  static Future<void> recordResult(String topicId, int percent, int stars) async {
    final current = await load();
    final prev = current[topicId];
    if (prev == null || stars >= prev.stars) {
      current[topicId] = TopicProgress(percent: percent, stars: stars, completed: true);
    } else {
      current[topicId] = TopicProgress(percent: prev.percent, stars: prev.stars, completed: true);
    }
    final prefs = await SharedPreferences.getInstance();
    final encoded = jsonEncode(current.map((k, v) => MapEntry(k, v.toJson())));
    await prefs.setString(_key, encoded);
  }
}
