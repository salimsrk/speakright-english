import 'dart:async';
import 'package:flutter/material.dart';
import '../models/topic.dart';
import '../services/teacher_tts.dart';
import '../services/student_mic.dart';
import '../services/scoring.dart';
import '../theme/app_theme.dart';
import 'results_screen.dart';

class _Bubble {
  final bool isTeacher;
  final String text;
  final String tamil;
  _Bubble(this.isTeacher, this.text, [this.tamil = ""]);
}

class ConversationScreen extends StatefulWidget {
  final Topic topic;
  const ConversationScreen({super.key, required this.topic});
  @override
  State<ConversationScreen> createState() => _ConversationScreenState();
}

class _ConversationScreenState extends State<ConversationScreen> {
  int _i = 0;
  final List<_Bubble> _log = [];
  final List<int> _scores = [];
  bool _listening = false;
  bool _preparing = false;
  bool _micUnsupported = false;
  ScoreResult? _lastResult;
  String? _error;
  bool _awaitingContinue = false;
  // See the identical field in repeat_screen.dart: ticks once a second
  // while _preparing is true so the button can show a live elapsed-time
  // count instead of a static label that would look frozen during a
  // multi-minute first-time voice-model load.
  Timer? _prepTicker;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _step());
  }

  @override
  void dispose() {
    _prepTicker?.cancel();
    TeacherTts.instance.stop();
    super.dispose();
  }

  Future<void> _step() async {
    final conv = widget.topic.conversation;
    if (_i >= conv.length) {
      final avg = _scores.isEmpty ? 0 : (_scores.reduce((a, b) => a + b) / _scores.length).round();
      if (!mounted) return;
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => ResultsScreen(topic: widget.topic, percent: avg)),
      );
      return;
    }
    final turn = conv[_i];
    if (turn.isTeacher) {
      setState(() => _log.add(_Bubble(true, turn.line, turn.tamil)));
      await TeacherTts.instance.speak(turn.line);
      _i++;
      if (mounted) _step();
    } else {
      setState(() {
        _awaitingContinue = false;
        _lastResult = null;
        _error = null;
      });
    }
  }

  Future<void> _speakLine(String expected) async {
    // See the identical comment in repeat_screen.dart: the very first mic
    // use in a session may still need to finish loading the offline voice
    // model, so show a distinct "Preparing…" state instead of overloading
    // "Listening…" for both "still warming up" and "actually recording".
    final needsPrep = !StudentMic.instance.isReady;
    setState(() {
      _listening = true;
      _preparing = needsPrep;
      _error = null;
    });
    if (needsPrep) {
      _prepTicker?.cancel();
      _prepTicker = Timer.periodic(const Duration(seconds: 1), (_) {
        if (mounted) setState(() {});
      });
    }
    try {
      if (needsPrep) {
        final ok = await StudentMic.instance.init();
        _prepTicker?.cancel();
        if (!mounted) return;
        setState(() => _preparing = false);
        if (!ok) {
          setState(() {
            _error = "Voice engine couldn't start: ${StudentMic.instance.initError ?? 'unknown error'}";
            _listening = false;
          });
          return;
        }
      }
      final transcript = await StudentMic.instance.listenOnce();
      if (transcript.isEmpty) {
        setState(() {
          _error = "Didn't catch that. Tap the microphone and try again.";
          _listening = false;
        });
        return;
      }
      final score = scoreReading(expected, transcript);
      setState(() {
        _log.add(_Bubble(false, transcript));
        _scores.add(score.percent);
        _lastResult = score;
        _listening = false;
        _awaitingContinue = true;
      });
    } catch (e) {
      _prepTicker?.cancel();
      if (e.toString().contains("mic-permission-denied") || e.toString().contains("unavailable")) {
        setState(() {
          _micUnsupported = true;
          _log.add(_Bubble(false, expected));
          _scores.add(70);
          _listening = false;
          _awaitingContinue = true;
        });
      } else {
        // TEMPORARY: show the real underlying error instead of a generic
        // message, so we can see the exact native failure on this phone
        // (there is no way to pull device logs remotely) and fix the real
        // cause instead of guessing again.
        setState(() {
          _error = "Speaking practice couldn't start: ${e.toString()}";
          _listening = false;
          _preparing = false;
        });
      }
    }
  }

  void _continue() {
    _i++;
    _step();
  }

  @override
  Widget build(BuildContext context) {
    final t = widget.topic;
    final currentTurn = _i < t.conversation.length ? t.conversation[_i] : null;
    final showStudentControls = currentTurn != null && !currentTurn.isTeacher;

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
                        const Text("3 · Conversation practice", style: TextStyle(color: Colors.white70, fontSize: 12.5)),
                      ],
                    ),
                  ),
                  Text(t.emoji, style: const TextStyle(fontSize: 26)),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(18),
                itemCount: _log.length,
                itemBuilder: (context, i) {
                  final b = _log[i];
                  return Align(
                    alignment: b.isTeacher ? Alignment.centerLeft : Alignment.centerRight,
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 10),
                      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
                      constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.78),
                      decoration: BoxDecoration(
                        color: b.isTeacher ? Colors.white : AppColors.primary,
                        borderRadius: BorderRadius.only(
                          topLeft: const Radius.circular(16),
                          topRight: const Radius.circular(16),
                          bottomLeft: Radius.circular(b.isTeacher ? 4 : 16),
                          bottomRight: Radius.circular(b.isTeacher ? 16 : 4),
                        ),
                        boxShadow: b.isTeacher
                            ? [BoxShadow(color: Colors.black.withOpacity(0.06), blurRadius: 10)]
                            : null,
                      ),
                      child: Column(
                        crossAxisAlignment: b.isTeacher ? CrossAxisAlignment.start : CrossAxisAlignment.end,
                        children: [
                          Text(b.text,
                              style: TextStyle(
                                  color: b.isTeacher ? AppColors.ink : Colors.white,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 15)),
                          tamilMeaning(b.tamil, color: b.isTeacher ? AppColors.inkSoft : Colors.white70),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            if (showStudentControls)
              Padding(
                padding: const EdgeInsets.fromLTRB(18, 0, 18, 18),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: cardDecoration(),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          RichText(
                            text: TextSpan(
                              style: const TextStyle(color: AppColors.ink, fontSize: 14.5),
                              children: [
                                const TextSpan(text: "Your line: "),
                                TextSpan(text: currentTurn.line, style: const TextStyle(fontWeight: FontWeight.w800)),
                              ],
                            ),
                          ),
                          tamilMeaning(currentTurn.tamil),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    if (!_awaitingContinue)
                      FilledButton.icon(
                        onPressed: _listening ? null : () => _speakLine(currentTurn.line),
                        icon: const Icon(Icons.mic),
                        label: Text(_preparing
                            ? "Preparing… (${StudentMic.instance.loadingElapsed.inSeconds}s)"
                            : (_listening ? "Listening…" : "Speak your line")),
                        style: FilledButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                        ),
                      ),
                    if (_error != null)
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(color: AppColors.warnBg, borderRadius: BorderRadius.circular(12)),
                          child: Text(_error!, style: const TextStyle(fontSize: 13.5, color: Color(0xFF92400E))),
                        ),
                      ),
                    if (_lastResult != null && !_micUnsupported)
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(color: feedbackColor(_lastResult!.verdict), borderRadius: BorderRadius.circular(12)),
                          child: Text("${verdictLabel(_lastResult!.verdict)} — ${_lastResult!.percent}%",
                              style: const TextStyle(fontWeight: FontWeight.w800)),
                        ),
                      ),
                    if (_micUnsupported)
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(color: AppColors.warnBg, borderRadius: BorderRadius.circular(12)),
                          child: const Text("Speaking practice needs microphone access. Practice this line out loud, then continue.",
                              style: TextStyle(fontSize: 13.5, color: Color(0xFF92400E))),
                        ),
                      ),
                    if (_awaitingContinue)
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: FilledButton(
                          onPressed: _continue,
                          style: FilledButton.styleFrom(backgroundColor: AppColors.primaryDark, padding: const EdgeInsets.symmetric(vertical: 16)),
                          child: const Text("Continue →", style: TextStyle(fontWeight: FontWeight.w700)),
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
}
