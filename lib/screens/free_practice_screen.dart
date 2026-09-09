import 'package:flutter/material.dart';
import '../models/topic.dart';
import '../services/teacher_tts.dart';
import '../services/student_mic.dart';
import '../services/scoring.dart';
import '../theme/app_theme.dart';
import 'results_screen.dart';

class FreePracticeScreen extends StatefulWidget {
  final Topic topic;
  const FreePracticeScreen({super.key, required this.topic});
  @override
  State<FreePracticeScreen> createState() => _FreePracticeScreenState();
}

class _FreePracticeScreenState extends State<FreePracticeScreen> {
  int _i = 0;
  bool _listening = false;
  ScoreResult? _result;
  String _heard = "";
  String? _error;
  final List<int> _scores = [];

  Future<void> _mic() async {
    setState(() {
      _listening = true;
      _error = null;
      _result = null;
    });
    try {
      final transcript = await StudentMic.instance.listenOnce(timeout: const Duration(seconds: 20));
      if (transcript.isEmpty) {
        setState(() {
          _error = "Didn't catch that — try speaking again.";
          _listening = false;
        });
        return;
      }
      final score = scoreFreePractice(transcript);
      setState(() {
        _heard = transcript;
        _result = score;
        _scores.add(score.percent);
        _listening = false;
      });
    } catch (e) {
      setState(() {
        _error = "Needs microphone access. Practice speaking about this topic out loud anyway!";
        _listening = false;
      });
    }
  }

  void _next() {
    final prompts = widget.topic.prompts;
    if (_i + 1 >= prompts.length) {
      final avg = _scores.isEmpty ? 70 : (_scores.reduce((a, b) => a + b) / _scores.length).round();
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => ResultsScreen(topic: widget.topic, percent: avg)),
      );
    } else {
      setState(() {
        _i++;
        _result = null;
        _heard = "";
        _error = null;
      });
    }
  }

  @override
  void dispose() {
    TeacherTts.instance.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final t = widget.topic;
    final prompt = t.prompts[_i];
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: const EdgeInsets.fromLTRB(12, 16, 18, 18),
              decoration: BoxDecoration(
                color: t.color,
                borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(24), bottomRight: Radius.circular(24)),
              ),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () => Navigator.of(context).popUntil((r) => r.isFirst),
                    icon: const Icon(Icons.arrow_back, color: Colors.white),
                    style: IconButton.styleFrom(backgroundColor: Colors.white24, shape: const CircleBorder()),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(t.title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 16)),
                        const Text("Free speaking practice", style: TextStyle(color: Colors.white70, fontSize: 12.5)),
                      ],
                    ),
                  ),
                  Text(t.emoji, style: const TextStyle(fontSize: 26)),
                ],
              ),
            ),
            const SizedBox(height: 14),
            Center(
              child: Text("Challenge ${_i + 1} of ${t.prompts.length}",
                  style: const TextStyle(color: AppColors.inkSoft, fontWeight: FontWeight.w700, fontSize: 13)),
            ),
            Padding(
              padding: const EdgeInsets.all(18),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 52,
                    height: 52,
                    decoration: BoxDecoration(color: Colors.white, shape: BoxShape.circle, boxShadow: [
                      BoxShadow(color: Colors.black.withOpacity(0.08), blurRadius: 12, offset: const Offset(0, 4)),
                    ]),
                    alignment: Alignment.center,
                    child: const Text("🧑‍🏫", style: TextStyle(fontSize: 26)),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: cardDecoration(),
                      child: Text(prompt, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600, height: 1.4)),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () => TeacherTts.instance.speak(prompt),
                      icon: const Icon(Icons.volume_up),
                      label: const Text("Hear the topic"),
                      style: OutlinedButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 14)),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: FilledButton.icon(
                      onPressed: _listening ? null : _mic,
                      icon: const Icon(Icons.mic),
                      label: Text(_listening ? "Listening…" : "Speak about it"),
                      style: FilledButton.styleFrom(backgroundColor: AppColors.primary, padding: const EdgeInsets.symmetric(vertical: 14)),
                    ),
                  ),
                ],
              ),
            ),
            if (_error != null)
              Padding(
                padding: const EdgeInsets.fromLTRB(18, 14, 18, 0),
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(color: AppColors.warnBg, borderRadius: BorderRadius.circular(12)),
                  child: Text(_error!, style: const TextStyle(fontSize: 13.5, color: Color(0xFF92400E))),
                ),
              ),
            if (_result != null)
              Padding(
                padding: const EdgeInsets.fromLTRB(18, 14, 18, 0),
                child: Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(color: feedbackColor(_result!.verdict), borderRadius: BorderRadius.circular(14)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Nice speaking! ${_result!.percent}%", style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 15)),
                      const SizedBox(height: 4),
                      Text('You said: "$_heard"',
                          style: const TextStyle(fontSize: 13.5, color: AppColors.inkSoft, fontStyle: FontStyle.italic)),
                    ],
                  ),
                ),
              ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.fromLTRB(18, 0, 18, 24),
              child: SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: _next,
                  style: FilledButton.styleFrom(backgroundColor: AppColors.primaryDark, padding: const EdgeInsets.symmetric(vertical: 16)),
                  child: Text(_i + 1 >= t.prompts.length ? "Finish →" : "Next challenge →",
                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
