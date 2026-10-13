import 'package:flutter/material.dart';
import '../services/student_mic.dart';
import '../services/teacher_tts.dart';
import '../theme/app_theme.dart';

/// A small standalone speaker icon button for ONE specific piece of
/// text — English or Tamil — with a real pause/resume, meant to sit
/// right next to the text it reads (inline next to the English sentence,
/// or inline next to its Tamil translation underneath) rather than one
/// shared button below a whole block, per the client's explicit request
/// to split "Listen" into two separate buttons.
///
/// PAUSE/RESUME HONESTY NOTE: Android's on-device TTS has no official way
/// to resume an utterance from the middle. This approximates it using
/// flutter_tts's own word-boundary progress callback (see
/// TeacherTts.pause/resumeFrom) — pausing remembers the last word
/// boundary the engine reported, and resuming re-speaks from there. On
/// most modern phones (Google's TTS engine) this works and feels like a
/// genuine pause. On an older phone/engine that never reports word
/// boundaries, resume just starts over from the beginning instead —
/// never worse than the old Stop button, just not always a perfect
/// mid-sentence pause.
///
/// TAMIL NOTE: tamil:true only works if the phone has a Tamil voice
/// installed. If none is found, tapping shows a small inline "Tamil
/// voice not found on this phone" note instead of silently doing
/// nothing — same honesty pattern already used for the English voice
/// picker in Settings.
class TtsSpeakerButton extends StatefulWidget {
  final String text;
  final bool tamil;
  const TtsSpeakerButton({super.key, required this.text, this.tamil = false});

  @override
  State<TtsSpeakerButton> createState() => _TtsSpeakerButtonState();
}

class _TtsSpeakerButtonState extends State<TtsSpeakerButton> {
  bool _speaking = false;
  int _pauseOffset = 0;
  bool _unavailable = false;

  @override
  void didUpdateWidget(covariant TtsSpeakerButton oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.text != widget.text || oldWidget.tamil != widget.tamil) {
      _speaking = false;
      _pauseOffset = 0;
      _unavailable = false;
    }
  }

  Future<void> _playFromStart() async {
    // Stop the mic if it's mid-listen elsewhere on this screen — playing
    // Teacher audio through the speaker while the recognizer is listening
    // would otherwise have the recognizer "hear" our own TTS instead of
    // the student.
    StudentMic.instance.cancel();
    setState(() {
      _speaking = true;
      _pauseOffset = 0;
    });
    try {
      if (widget.tamil) {
        await TeacherTts.instance.speakTamil(widget.text);
      } else {
        await TeacherTts.instance.speak(widget.text);
      }
    } catch (_) {
      if (mounted && widget.tamil) setState(() => _unavailable = true);
    }
    if (!mounted) return;
    setState(() {
      _speaking = false;
      _pauseOffset = 0;
    });
  }

  Future<void> _pause() async {
    final offset = await TeacherTts.instance.pause();
    if (!mounted) return;
    setState(() {
      _speaking = false;
      _pauseOffset = offset;
    });
  }

  Future<void> _resume() async {
    StudentMic.instance.cancel();
    setState(() {
      _speaking = true;
    });
    try {
      await TeacherTts.instance.resumeFrom(widget.text, _pauseOffset, tamil: widget.tamil);
    } catch (_) {
      if (mounted && widget.tamil) setState(() => _unavailable = true);
    }
    if (!mounted) return;
    setState(() {
      _speaking = false;
      _pauseOffset = 0;
    });
  }

  void _tap() {
    if (_unavailable) return;
    if (_speaking) {
      _pause();
    } else if (_pauseOffset > 0) {
      _resume();
    } else {
      _playFromStart();
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_unavailable) {
      return Tooltip(
        message: "Tamil voice not found on this phone",
        child: Icon(Icons.volume_off, size: 20, color: AppColors.inkSoft.withOpacity(0.5)),
      );
    }
    final resuming = !_speaking && _pauseOffset > 0;
    return Tooltip(
      message: _speaking ? "Pause" : (resuming ? "Resume" : "Listen"),
      child: InkWell(
        onTap: _tap,
        borderRadius: BorderRadius.circular(20),
        child: Container(
          padding: const EdgeInsets.all(7),
          decoration: BoxDecoration(
            color: AppColors.primary.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(
            _speaking ? Icons.pause : (resuming ? Icons.play_arrow : Icons.volume_up),
            size: 18,
            color: AppColors.primary,
          ),
        ),
      ),
    );
  }
}
