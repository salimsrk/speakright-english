import 'package:flutter/material.dart';
import '../models/topic.dart';
import '../services/teacher_tts.dart';
import '../services/student_mic.dart';
import '../services/scoring.dart';
import '../theme/app_theme.dart';
import 'conversation_screen.dart';

class RepeatScreen extends StatefulWidget {
  final Topic topic;
  const RepeatScreen({super.key, required this.topic});
  @override
  State<RepeatScreen> createState() => _RepeatScreenState();
}

class _RepeatScreenState extends State<RepeatScreen> {
  int _i = 0;
  bool _listening = false;
  ScoreResult? _result;
  String _heard = "";
  String? _error;

  Future<void> _hear() => TeacherTts.instance.speak(widget.topic.repeatLines[_i]);

  Future<void> _mic() async {
    setState(() {
      _listening = true;
      _error = null;
      _result = null;
    });
    try {
      final transcript = await StudentMic.instance.listenOnce();
      if (transcript.isEmpty) {
        setState(() {
          _error = "Didn't catch that — tap the microphone and try again.";
          _listening = false;
        });
        return;
      }
      final score = scoreReading(widget.topic.repeatLines[_i], transcript);
      setState(() {
        _heard = transcript;
        _result = score;
        _listening = false;
      });
    } catch (e) {
      setState(() {
        _error = e.toString().contains("mic-permission-denied")
            ? "Please allow microphone access to practice speaking."
            : "Speaking practice couldn't start. Please try again.";
        _listening = false;
      });
    }
  }

  void _continue() {
    final lines = widget.topic.repeatLines;
    if (_i + 1 >= lines.length) {
      if (widget.topic.type == TopicType.dialogue) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => ConversationScreen(topic: widget.topic)),
        );
      } else {
        Navigator.of(context).pop();
      }
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
    final line = t.repeatLines[_i];

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
                        const Text("2 · Listen, then YOU repeat", style: TextStyle(color: Colors.white70, fontSize: 12.5)),
                      ],
                    ),
                  ),
                  Text(t.emoji, style: const TextStyle(fontSize: 26)),
                ],
              ),
            ),
            const SizedBox(height: 14),
            Center(
              child: Text("Line ${_i + 1} of ${t.repeatLines.length}",
                  style: const TextStyle(color: AppColors.inkSoft, fontWeight: FontWeight.w700, fontSize: 13)),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(18, 16, 18, 8),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const _Avatar(),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: cardDecoration(),
                      child: Text(line, style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w700)),
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
                      onPressed: _hear,
                      icon: const Icon(Icons.volume_up),
                      label: const Text("Hear it"),
                      style: OutlinedButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 14)),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: FilledButton.icon(
                      onPressed: _listening ? null : _mic,
                      icon: const Icon(Icons.mic),
                      label: Text(_listening ? "Listening…" : "Your turn"),
                      style: FilledButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
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
                      Text("${verdictLabel(_result!.verdict)} — ${_result!.percent}%",
                          style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 15)),
                      const SizedBox(height: 4),
                      Text('You said: "$_heard"',
                          style: const TextStyle(fontSize: 13.5, color: AppColors.inkSoft, fontStyle: FontStyle.italic)),
                    ],
                  ),
                ),
              ),
            const Spacer(),
            if (_result != null)
              Padding(
                padding: const EdgeInsets.fromLTRB(18, 0, 18, 24),
                child: SizedBox(
                  width: double.infinity,
                  child: FilledButton(
                    onPressed: _continue,
                    style: FilledButton.styleFrom(backgroundColor: AppColors.primary, padding: const EdgeInsets.symmetric(vertical: 16)),
                    child: const Text("Continue →", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _Avatar extends StatelessWidget {
  const _Avatar();
  @override
  Widget build(BuildContext context) => Container(
        width: 52,
        height: 52,
        decoration: BoxDecoration(color: Colors.white, shape: BoxShape.circle, boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.08), blurRadius: 12, offset: const Offset(0, 4)),
        ]),
        alignment: Alignment.center,
        child: const Text("🧑‍🏫", style: TextStyle(fontSize: 26)),
      );
}
