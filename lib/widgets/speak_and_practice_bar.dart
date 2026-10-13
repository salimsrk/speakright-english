import 'package:flutter/material.dart';
import '../services/scoring.dart';
import '../services/student_mic.dart';
import '../services/teacher_tts.dart';
import '../theme/app_theme.dart';
import 'voice_replay_control.dart';

/// A small reusable "Say it" mic-practice control to drop under any block
/// of English text in the app: tap to speak it back and get an instant,
/// fully-offline score against that exact text — the same StudentMic +
/// scoring pipeline every lesson already uses.
///
/// The "Listen" side of this (hearing the Teacher read the text aloud,
/// with a real pause/resume) used to live in this same widget, but per
/// the client's explicit request it is now its own separate
/// TtsSpeakerButton — one placed inline right next to the English
/// sentence, and a second one placed inline right next to its Tamil
/// translation, instead of one shared button below the whole block. See
/// widgets/tts_speaker_button.dart.
///
/// Two things this bar adds beyond the first version:
/// - Tap the mic again while it's listening to stop early and get scored
///   on whatever was heard so far, instead of only the fixed timeout —
///   wired straight to StudentMic.cancel(), which resolves the in-flight
///   listen attempt early via its existing status-callback plumbing.
/// - After a result comes back, a "Record to hear yourself" control
///   appears (VoiceReplayControl) — the same, already-proven-on-device
///   pattern used in the Module 1 lesson screens. It deliberately records
///   a SEPARATE, sequential take rather than capturing audio during the
///   scored attempt itself: recording audio and live speech recognition
///   both need exclusive access to the microphone, and running them at
///   the same time was tested on a real device and reliably broke
///   recognition (see StudentRecorder's own header comment) — so
///   playback is only ever offered after scoring has fully finished.
class SpeakAndPracticeBar extends StatefulWidget {
  final String text;
  const SpeakAndPracticeBar({super.key, required this.text});

  @override
  State<SpeakAndPracticeBar> createState() => _SpeakAndPracticeBarState();
}

class _SpeakAndPracticeBarState extends State<SpeakAndPracticeBar> {
  bool _listening = false;
  String? _heard;
  String? _error;
  ScoreResult? _result;
  // Bumped on every successful attempt — passed to VoiceReplayControl as
  // its turnKey so any previous take's recording/playback state clears
  // when the student tries again.
  int _attempt = 0;

  Future<void> _tryMic() async {
    // Stop any Teacher/Tamil speech first — otherwise the recognizer can
    // end up "hearing" our own TTS playing through the speaker instead of
    // the student.
    await TeacherTts.instance.stop();
    setState(() {
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
        _attempt++;
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

  // Manual stop: tapping the mic button again while it's listening ends
  // that attempt right away and scores whatever was heard so far, instead
  // of only ever stopping at the fixed timeout. StudentMic.cancel() makes
  // the in-flight listenOnce() above resolve early (with the partial
  // transcript) via its existing onStatus callback — _tryMic then runs
  // its normal scoring path exactly as if the attempt had finished
  // naturally.
  void _stopMic() {
    StudentMic.instance.cancel();
  }

  // Deliberately NOT stopping StudentMic/TeacherTts in a dispose() here —
  // several of these bars are typically on screen at once (one per
  // grammar point / passage paragraph), and tearing down the shared
  // singleton engines when any ONE of them unmounts would cut off
  // listening/playback that another bar on the same screen just started.
  // The screen that hosts these bars stops both engines in its own
  // dispose() instead, same as every other screen using them.

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: double.infinity,
          child: OutlinedButton.icon(
            onPressed: _listening ? _stopMic : _tryMic,
            icon: Icon(_listening ? Icons.stop_circle : Icons.mic, size: 18, color: AppColors.primary),
            label: Text(_listening ? "Listening… (tap to stop)" : "Say it"),
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              visualDensity: VisualDensity.compact,
              foregroundColor: AppColors.primary,
              side: const BorderSide(color: AppColors.primary),
            ),
          ),
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
                  VoiceReplayControl(turnKey: _attempt),
                ],
              ),
            ),
          ),
      ],
    );
  }
}
