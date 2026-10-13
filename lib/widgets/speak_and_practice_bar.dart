import 'package:flutter/material.dart';
import '../services/scoring.dart';
import '../services/student_mic.dart';
import '../services/teacher_tts.dart';
import '../theme/app_theme.dart';

/// A small reusable "speaker + mic" control to drop under any block of
/// English text in the app: tap "Listen" to hear the Teacher read it, tap
/// "Say it" to try saying it themselves and get an instant, fully-offline
/// score against that exact text — the same TeacherTts + StudentMic +
/// scoring pipeline every lesson already uses, just attached to
/// explanation/reference text instead of a dedicated lesson screen.
///
/// "Stop" rather than true pause/resume: the on-device TTS engine has no
/// way to report or resume from a mid-sentence position (the same
/// limitation already flagged — and designed around with the story-style
/// step bar — for the Module 1 lesson player), so tapping the button again
/// while it's speaking stops it rather than pausing it; starting again
/// always reads from the beginning.
class SpeakAndPracticeBar extends StatefulWidget {
  final String text;
  const SpeakAndPracticeBar({super.key, required this.text});

  @override
  State<SpeakAndPracticeBar> createState() => _SpeakAndPracticeBarState();
}

class _SpeakAndPracticeBarState extends State<SpeakAndPracticeBar> {
  bool _speaking = false;
  bool _listening = false;
  String? _heard;
  String? _error;
  ScoreResult? _result;

  Future<void> _togglePlay() async {
    if (_speaking) {
      await TeacherTts.instance.stop();
      if (!mounted) return;
      setState(() => _speaking = false);
      return;
    }
    setState(() => _speaking = true);
    await TeacherTts.instance.speak(widget.text);
    if (!mounted) return;
    setState(() => _speaking = false);
  }

  Future<void> _tryMic() async {
    await TeacherTts.instance.stop();
    setState(() {
      _speaking = false;
      _listening = true;
      _error = null;
      _result = null;
    });
    try {
      final transcript = await StudentMic.instance.listenOnce(timeout: const Duration(seconds: 10));
      if (!mounted) return;
      if (transcript.isEmpty) {
        setState(() {
          _error = "Didn't catch that — tap the mic and try again.";
          _listening = false;
        });
        return;
      }
      final score = scoreReading(widget.text, transcript);
      setState(() {
        _heard = transcript;
        _result = score;
        _listening = false;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _error = e.toString().contains("mic-permission-denied")
            ? "Please allow microphone access to try this."
            : "Couldn't start — please try again.";
        _listening = false;
      });
    }
  }

  // Deliberately NOT stopping TeacherTts/StudentMic in a dispose() here —
  // several of these bars are typically on screen at once (one per
  // grammar point / passage paragraph), and tearing down the shared
  // singleton engines when any ONE of them unmounts would cut off
  // playback that another bar on the same screen just started. The
  // screen that hosts these bars stops both engines in its own
  // dispose() instead, same as every other screen using them.

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            OutlinedButton.icon(
              onPressed: _listening ? null : _togglePlay,
              icon: Icon(_speaking ? Icons.stop : Icons.volume_up, size: 17),
              label: Text(_speaking ? "Stop" : "Listen"),
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 9),
                visualDensity: VisualDensity.compact,
              ),
            ),
            const SizedBox(width: 10),
            OutlinedButton.icon(
              onPressed: _speaking ? null : _tryMic,
              icon: Icon(_listening ? Icons.hearing : Icons.mic, size: 17, color: AppColors.primary),
              label: Text(_listening ? "Listening…" : "Say it"),
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 9),
                visualDensity: VisualDensity.compact,
                foregroundColor: AppColors.primary,
                side: const BorderSide(color: AppColors.primary),
              ),
            ),
          ],
        ),
        if (_error != null)
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Container(
              padding: const EdgeInsets.all(9),
              decoration: BoxDecoration(color: AppColors.warnBg, borderRadius: BorderRadius.circular(10)),
              child: Text(_error!, style: const TextStyle(fontSize: 12, color: Color(0xFF92400E))),
            ),
          ),
        if (_result != null)
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(color: feedbackColor(_result!.verdict), borderRadius: BorderRadius.circular(10)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("${verdictLabel(_result!.verdict)} — ${_result!.percent}%",
                      style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 13)),
                  const SizedBox(height: 2),
                  Text('You said: "$_heard"',
                      style: const TextStyle(fontSize: 11.5, color: AppColors.inkSoft, fontStyle: FontStyle.italic)),
                ],
              ),
            ),
          ),
      ],
    );
  }
}
