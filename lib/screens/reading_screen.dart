import 'package:flutter/material.dart';
import '../models/topic.dart';
import '../services/teacher_tts.dart';
import '../services/student_mic.dart';
import '../services/student_recorder.dart';
import '../services/scoring.dart';
import '../theme/app_theme.dart';
import '../widgets/fun_fact_dialog.dart';
import '../widgets/voice_playback_button.dart';
import 'results_screen.dart';

class ReadingScreen extends StatefulWidget {
  final Topic topic;
  const ReadingScreen({super.key, required this.topic});
  @override
  State<ReadingScreen> createState() => _ReadingScreenState();
}

class _ReadingScreenState extends State<ReadingScreen> {
  bool _listening = false;
  ScoreResult? _result;
  String _heard = "";
  String? _error;
  // Path to a recording of the student's most recent take, for playback —
  // null whenever recording wasn't available on this device.
  String? _recordingPath;

  Future<void> _mic() async {
    setState(() {
      _listening = true;
      _error = null;
      _result = null;
      _recordingPath = null;
    });
    try {
      // Runs alongside the live transcription below purely so the take can
      // be played back afterwards — fail-soft, never blocks scoring.
      await StudentRecorder.instance.start();
      final transcript = await StudentMic.instance.listenOnce(timeout: const Duration(seconds: 20));
      final recordingPath = await StudentRecorder.instance.stop();
      if (transcript.isEmpty) {
        setState(() {
          _error = "Didn't catch that — tap the microphone and try again.";
          _listening = false;
        });
        return;
      }
      final score = scoreReading(widget.topic.passage, transcript);
      setState(() {
        _heard = transcript;
        _result = score;
        _recordingPath = recordingPath;
        _listening = false;
      });
    } catch (e) {
      await StudentRecorder.instance.cancel();
      setState(() {
        _error = e.toString().contains("mic-permission-denied")
            ? "Please allow microphone access to practice speaking."
            : "Speaking practice couldn't start. Please try again.";
        _listening = false;
      });
    }
  }

  @override
  void dispose() {
    TeacherTts.instance.stop();
    StudentRecorder.instance.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final t = widget.topic;
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
                        const Text("Read the passage aloud", style: TextStyle(color: Colors.white70, fontSize: 12.5)),
                      ],
                    ),
                  ),
                  Text(t.emoji, style: const TextStyle(fontSize: 26)),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(18),
              child: Container(
                padding: const EdgeInsets.all(18),
                decoration: cardDecoration(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(t.passage, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600, height: 1.7)),
                    tamilMeaning(t.passageTamil, topGap: 10),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () => TeacherTts.instance.speak(t.passage),
                      icon: const Icon(Icons.volume_up),
                      label: const Text("Hear Teacher read it"),
                      style: OutlinedButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 14)),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: FilledButton.icon(
                      onPressed: _listening ? null : _mic,
                      icon: const Icon(Icons.mic),
                      label: Text(_listening ? "Listening…" : "Now you read it"),
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
                      Text("${verdictLabel(_result!.verdict)} — ${_result!.percent}%",
                          style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 15)),
                      const SizedBox(height: 4),
                      Text('You said: "$_heard"',
                          style: const TextStyle(fontSize: 13.5, color: AppColors.inkSoft, fontStyle: FontStyle.italic)),
                      VoicePlaybackButton(audioPath: _recordingPath),
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
                    onPressed: () async {
                      // Reading practice is a single-passage topic, so this
                      // is its natural "topic complete" moment.
                      await showFunFact(context);
                      if (!context.mounted) return;
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (_) => ResultsScreen(topic: t, percent: _result!.percent)),
                      );
                    },
                    style: FilledButton.styleFrom(backgroundColor: AppColors.primary, padding: const EdgeInsets.symmetric(vertical: 16)),
                    child: const Text("See my results →", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
