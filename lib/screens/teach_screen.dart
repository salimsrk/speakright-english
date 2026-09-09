import 'package:flutter/material.dart';
import '../models/topic.dart';
import '../services/teacher_tts.dart';
import '../theme/app_theme.dart';
import 'repeat_screen.dart';
import 'reading_screen.dart';
import 'free_practice_screen.dart';

class TeachScreen extends StatefulWidget {
  final Topic topic;
  const TeachScreen({super.key, required this.topic});
  @override
  State<TeachScreen> createState() => _TeachScreenState();
}

class _TeachScreenState extends State<TeachScreen> {
  int _index = -1;
  bool _finished = false;
  bool _playing = false;

  @override
  void dispose() {
    TeacherTts.instance.stop();
    super.dispose();
  }

  void _playFrom(int i) {
    if (i >= widget.topic.teacherIntro.length) {
      setState(() {
        _finished = true;
        _playing = false;
      });
      return;
    }
    setState(() {
      _index = i;
      _playing = true;
    });
    TeacherTts.instance.speak(widget.topic.teacherIntro[i], onComplete: () {
      if (mounted) _playFrom(i + 1);
    });
  }

  void _goNext() {
    TeacherTts.instance.stop();
    final t = widget.topic;
    Widget screen;
    switch (t.type) {
      case TopicType.reading:
        screen = ReadingScreen(topic: t);
        break;
      case TopicType.freePractice:
        screen = FreePracticeScreen(topic: t);
        break;
      case TopicType.dialogue:
        screen = RepeatScreen(topic: t);
        break;
    }
    Navigator.of(context).push(MaterialPageRoute(builder: (_) => screen));
  }

  @override
  Widget build(BuildContext context) {
    final t = widget.topic;
    final text = _index >= 0 && _index < t.teacherIntro.length
        ? t.teacherIntro[_index]
        : "Tap play to begin the lesson.";

    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _TopBar(topic: t, step: "1 · Listen to your Teacher"),
            const SizedBox(height: 22),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _avatar(),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: cardDecoration(),
                      child: Text(text, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600, height: 1.5)),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: Row(
                children: [
                  IconButton.filled(
                    onPressed: _index >= 0
                        ? () => TeacherTts.instance.speak(t.teacherIntro[_index])
                        : null,
                    icon: const Icon(Icons.replay),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: FilledButton.icon(
                      onPressed: _playing ? null : () => _playFrom(0),
                      icon: Icon(_finished ? Icons.replay : Icons.play_arrow),
                      label: Text(_finished ? "Play Again" : (_playing ? "Playing…" : "Play Lesson")),
                      style: FilledButton.styleFrom(
                        backgroundColor: t.color,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Spacer(),
            if (_finished)
              Padding(
                padding: const EdgeInsets.fromLTRB(18, 0, 18, 24),
                child: Column(
                  children: [
                    const Text("Great! Now it's your turn to speak.",
                        style: TextStyle(color: AppColors.inkSoft, fontWeight: FontWeight.w600)),
                    const SizedBox(height: 10),
                    SizedBox(
                      width: double.infinity,
                      child: FilledButton.icon(
                        onPressed: _goNext,
                        icon: const Icon(Icons.mic, size: 26),
                        label: Text(
                          t.type == TopicType.reading
                              ? "🎤  Now YOU read it"
                              : t.type == TopicType.freePractice
                                  ? "🎤  Start speaking challenges"
                                  : "🎤  Now YOU speak!",
                          style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w800),
                        ),
                        style: FilledButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _avatar() => Container(
        width: 56,
        height: 56,
        decoration: BoxDecoration(color: Colors.white, shape: BoxShape.circle, boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.08), blurRadius: 12, offset: const Offset(0, 4)),
        ]),
        alignment: Alignment.center,
        child: const Text("🧑‍🏫", style: TextStyle(fontSize: 30)),
      );
}

class _TopBar extends StatelessWidget {
  final Topic topic;
  final String step;
  const _TopBar({required this.topic, required this.step});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(12, 16, 18, 18),
      decoration: BoxDecoration(
        color: topic.color,
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
                Text(topic.title,
                    style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 16)),
                Text(step, style: const TextStyle(color: Colors.white70, fontSize: 12.5)),
              ],
            ),
          ),
          Text(topic.emoji, style: const TextStyle(fontSize: 26)),
        ],
      ),
    );
  }
}
