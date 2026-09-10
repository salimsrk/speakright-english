import 'package:flutter/material.dart';
import '../models/topic.dart';
import '../services/teacher_tts.dart';
import '../theme/app_theme.dart';
import 'repeat_screen.dart';
import 'reading_screen.dart';
import 'free_practice_screen.dart';

class _DemoBubble {
  final bool isTeacher;
  final String text;
  final String tamil;
  const _DemoBubble(this.isTeacher, this.text, [this.tamil = ""]);
}

class TeachScreen extends StatefulWidget {
  final Topic topic;
  const TeachScreen({super.key, required this.topic});
  @override
  State<TeachScreen> createState() => _TeachScreenState();
}

class _TeachScreenState extends State<TeachScreen> {
  // --- Lesson narration (the "Listen to your Teacher" card) ---
  int _index = -1;
  bool _finished = false;
  bool _playing = false;
  bool _paused = false;

  // --- Sample conversation demo (dialogue topics only) ---
  final List<_DemoBubble> _demoLog = [];
  int _demoIndex = 0;
  bool _demoPlaying = false;
  bool _demoPaused = false;
  bool _demoFinished = false;

  bool get _showDemo => widget.topic.type == TopicType.dialogue && widget.topic.conversation.isNotEmpty;

  @override
  void dispose() {
    TeacherTts.instance.stop();
    super.dispose();
  }

  // ---------------- Narration playback ----------------

  Future<void> _playFrom(int i) async {
    if (i >= widget.topic.teacherIntro.length) {
      if (!mounted) return;
      setState(() {
        _finished = true;
        _playing = false;
        _paused = false;
      });
      return;
    }
    setState(() {
      _index = i;
      _playing = true;
      _paused = false;
    });
    await TeacherTts.instance.speak(widget.topic.teacherIntro[i]);
    if (!mounted || _paused) return; // user hit Pause while this line was playing
    _playFrom(i + 1);
  }

  void _pauseNarration() {
    setState(() {
      _paused = true;
      _playing = false;
    });
    TeacherTts.instance.stop();
  }

  // ---------------- Sample conversation demo playback ----------------

  Future<void> _playDemoFrom(int i) async {
    final conv = widget.topic.conversation;
    if (i >= conv.length) {
      if (!mounted) return;
      setState(() {
        _demoFinished = true;
        _demoPlaying = false;
        _demoPaused = false;
      });
      return;
    }
    final turn = conv[i];
    setState(() {
      _demoIndex = i;
      _demoPlaying = true;
      _demoPaused = false;
      if (_demoLog.length <= i) _demoLog.add(_DemoBubble(turn.isTeacher, turn.line, turn.tamil));
    });
    await TeacherTts.instance.speak(turn.line, speaker: turn.isTeacher ? TtsSpeaker.teacher : TtsSpeaker.friend);
    if (!mounted || _demoPaused) return;
    _playDemoFrom(i + 1);
  }

  void _pauseDemo() {
    setState(() {
      _demoPaused = true;
      _demoPlaying = false;
    });
    TeacherTts.instance.stop();
  }

  void _restartDemo() {
    setState(() {
      _demoLog.clear();
      _demoFinished = false;
      _demoPaused = false;
    });
    _playDemoFrom(0);
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

    // Only one of the two players (lesson narration / conversation demo)
    // may talk at a time — they share the same on-device voice engine, so
    // letting both start at once would have them cut each other off.
    final String narrationLabel;
    final IconData narrationIcon;
    final VoidCallback? narrationAction;
    if (_playing) {
      narrationLabel = "Pause";
      narrationIcon = Icons.pause;
      narrationAction = _pauseNarration;
    } else if (_demoPlaying) {
      narrationLabel = _paused ? "Resume" : (_finished ? "Play Again" : "Play Lesson");
      narrationIcon = _paused ? Icons.play_arrow : (_finished ? Icons.replay : Icons.play_arrow);
      narrationAction = null;
    } else if (_paused) {
      narrationLabel = "Resume";
      narrationIcon = Icons.play_arrow;
      narrationAction = () => _playFrom(_index);
    } else if (_finished) {
      narrationLabel = "Play Again";
      narrationIcon = Icons.replay;
      narrationAction = () => _playFrom(0);
    } else {
      narrationLabel = "Play Lesson";
      narrationIcon = Icons.play_arrow;
      narrationAction = () => _playFrom(0);
    }

    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _TopBar(topic: t, step: "1 · Listen to your Teacher"),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.only(bottom: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 22),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 18),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _avatar("🧑‍🏫"),
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
                            onPressed: _index >= 0 && !_playing && !_demoPlaying
                                ? () => TeacherTts.instance.speak(t.teacherIntro[_index])
                                : null,
                            icon: const Icon(Icons.replay),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: FilledButton.icon(
                              onPressed: narrationAction,
                              icon: Icon(narrationIcon),
                              label: Text(narrationLabel),
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
                    if (_showDemo) ...[
                      const SizedBox(height: 26),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 18),
                        child: Row(
                          children: [
                            const Text("💬", style: TextStyle(fontSize: 18)),
                            const SizedBox(width: 8),
                            const Text("Sample Conversation",
                                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w800, color: AppColors.ink)),
                          ],
                        ),
                      ),
                      const SizedBox(height: 4),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 18),
                        child: Text("Listen to the Teacher and a Friend have this chat — two different voices.",
                            style: const TextStyle(fontSize: 12.5, color: AppColors.inkSoft)),
                      ),
                      const SizedBox(height: 12),
                      if (_demoLog.isNotEmpty)
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 18),
                          child: Column(
                            children: _demoLog.map((b) => _demoBubble(b)).toList(),
                          ),
                        ),
                      const SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 18),
                        child: OutlinedButton.icon(
                          onPressed: _demoPlaying
                              ? _pauseDemo
                              : _playing
                                  ? null
                                  : _demoPaused
                                      ? () => _playDemoFrom(_demoIndex)
                                      : _demoFinished
                                          ? _restartDemo
                                          : () => _playDemoFrom(0),
                          icon: Icon(_demoPlaying
                              ? Icons.pause
                              : _demoPaused
                                  ? Icons.play_arrow
                                  : _demoFinished
                                      ? Icons.replay
                                      : Icons.play_arrow),
                          label: Text(_demoPlaying
                              ? "Pause"
                              : _demoPaused
                                  ? "Resume"
                                  : _demoFinished
                                      ? "Play Again"
                                      : "Play Conversation"),
                          style: OutlinedButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 14)),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
            if (_finished)
              Padding(
                padding: const EdgeInsets.fromLTRB(18, 10, 18, 24),
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

  Widget _demoBubble(_DemoBubble b) {
    final t = widget.topic;
    return Align(
      alignment: b.isTeacher ? Alignment.centerLeft : Alignment.centerRight,
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
        constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.74),
        decoration: BoxDecoration(
          color: b.isTeacher ? Colors.white : t.color,
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(16),
            topRight: const Radius.circular(16),
            bottomLeft: Radius.circular(b.isTeacher ? 4 : 16),
            bottomRight: Radius.circular(b.isTeacher ? 16 : 4),
          ),
          boxShadow: b.isTeacher ? [BoxShadow(color: Colors.black.withOpacity(0.06), blurRadius: 10)] : null,
        ),
        child: Column(
          crossAxisAlignment: b.isTeacher ? CrossAxisAlignment.start : CrossAxisAlignment.end,
          children: [
            Text(b.isTeacher ? "🧑‍🏫 Teacher" : "🙂 Friend",
                style: TextStyle(
                    fontSize: 10.5,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 0.4,
                    color: b.isTeacher ? AppColors.inkSoft : Colors.white70)),
            const SizedBox(height: 3),
            Text(b.text,
                style: TextStyle(
                    color: b.isTeacher ? AppColors.ink : Colors.white, fontWeight: FontWeight.w600, fontSize: 15)),
            tamilMeaning(b.tamil, color: b.isTeacher ? AppColors.inkSoft : Colors.white70),
          ],
        ),
      ),
    );
  }

  Widget _avatar(String emoji) => Container(
        width: 56,
        height: 56,
        decoration: BoxDecoration(color: Colors.white, shape: BoxShape.circle, boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.08), blurRadius: 12, offset: const Offset(0, 4)),
        ]),
        alignment: Alignment.center,
        child: Text(emoji, style: const TextStyle(fontSize: 30)),
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
