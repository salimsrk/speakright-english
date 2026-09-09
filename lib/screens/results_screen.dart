import 'package:flutter/material.dart';
import '../models/topic.dart';
import '../services/progress_store.dart';
import '../services/scoring.dart';
import '../theme/app_theme.dart';
import 'teach_screen.dart';

class ResultsScreen extends StatefulWidget {
  final Topic topic;
  final int percent;
  const ResultsScreen({super.key, required this.topic, required this.percent});
  @override
  State<ResultsScreen> createState() => _ResultsScreenState();
}

class _ResultsScreenState extends State<ResultsScreen> {
  @override
  void initState() {
    super.initState();
    final stars = starsForPercent(widget.percent);
    ProgressStore.recordResult(widget.topic.id, widget.percent, stars);
  }

  @override
  Widget build(BuildContext context) {
    final t = widget.topic;
    final percent = widget.percent;
    final stars = starsForPercent(percent);
    final message = percent >= 85
        ? "Excellent work! You sound great! 🌟"
        : percent >= 65
            ? "Good job! Keep practicing! 👍"
            : percent >= 40
                ? "Nice try! A little more practice will help. 💪"
                : "Keep practicing — you'll get there! 🔁";

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(t.emoji, style: const TextStyle(fontSize: 60)),
              const SizedBox(height: 10),
              Text(t.title, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700), textAlign: TextAlign.center),
              const SizedBox(height: 10),
              Text(
                "★★★".substring(0, stars) + "☆☆☆".substring(0, 3 - stars),
                style: const TextStyle(color: AppColors.gold, fontSize: 34, letterSpacing: 6),
              ),
              const SizedBox(height: 6),
              Text("$percent%", style: TextStyle(color: t.color, fontSize: 44, fontWeight: FontWeight.w900)),
              const SizedBox(height: 8),
              Text(message, style: const TextStyle(color: AppColors.inkSoft, fontWeight: FontWeight.w600), textAlign: TextAlign.center),
              const SizedBox(height: 30),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton.icon(
                  onPressed: () {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (_) => TeachScreen(topic: t)),
                    );
                  },
                  icon: const Icon(Icons.refresh),
                  label: const Text("Practice Again"),
                  style: OutlinedButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 16)),
                ),
              ),
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                child: FilledButton.icon(
                  onPressed: () => Navigator.of(context).popUntil((r) => r.isFirst),
                  icon: const Icon(Icons.home),
                  label: const Text("Back to Topics"),
                  style: FilledButton.styleFrom(backgroundColor: AppColors.primary, padding: const EdgeInsets.symmetric(vertical: 16)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
