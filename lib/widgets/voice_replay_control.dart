import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import '../services/student_recorder.dart';
import '../theme/app_theme.dart';

/// Lets the student record a short clip of themselves and play it back —
/// entirely separate from StudentMic's own live speech-recognition
/// session, never at the same time as it.
///
/// EARLIER VERSION OF THIS FEATURE started a StudentRecorder session
/// running alongside StudentMic.listenOnce() so the same take could be
/// both scored AND played back. That was tested on a real device and
/// reliably broke speech recognition — every attempt came back "Didn't
/// catch that", 100% of the time, even though it worked perfectly before
/// that change. Root cause: recording audio (`record` package, its own
/// AudioRecord session) and speech_to_text's live recognition both need
/// exclusive access to the microphone; only one of them actually gets to
/// hear real audio when both are open at once, and it silently starved
/// the recognizer instead of erroring, which is why it looked like STT
/// itself had broken.
///
/// The fix: never open both at the same time. This widget is only ever
/// shown AFTER a speaking turn has already finished scoring and
/// StudentMic's session is fully closed. The student taps to record a
/// few seconds of themselves (a quick repeat of the line they just
/// practiced, purely for playback — it is never scored), then taps to
/// play it back. Recording and speech recognition are always strictly
/// sequential, so they can never fight over the mic again.
class VoiceReplayControl extends StatefulWidget {
  // Any value that changes when the student moves to a new line/attempt
  // (e.g. an incrementing counter). When it changes, any previous
  // recording/playback state for the old attempt is dropped.
  final Object turnKey;
  const VoiceReplayControl({super.key, required this.turnKey});

  @override
  State<VoiceReplayControl> createState() => _VoiceReplayControlState();
}

class _VoiceReplayControlState extends State<VoiceReplayControl> {
  final AudioPlayer _player = AudioPlayer();
  String? _path;
  bool _recording = false;
  bool _playing = false;

  @override
  void initState() {
    super.initState();
    _player.onPlayerComplete.listen((_) {
      if (mounted) setState(() => _playing = false);
    });
  }

  @override
  void didUpdateWidget(covariant VoiceReplayControl oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.turnKey != widget.turnKey) {
      _player.stop();
      StudentRecorder.instance.cancel();
      _path = null;
      _recording = false;
      _playing = false;
    }
  }

  Future<void> _startRecording() async {
    setState(() => _recording = true);
    final started = await StudentRecorder.instance.start();
    if (!mounted) return;
    if (!started) {
      // Recording just isn't available on this device — fail silently,
      // no playback offered, everything else keeps working.
      setState(() => _recording = false);
    }
  }

  Future<void> _stopRecording() async {
    final path = await StudentRecorder.instance.stop();
    if (!mounted) return;
    setState(() {
      _recording = false;
      _path = path;
    });
  }

  Future<void> _togglePlay() async {
    try {
      if (_playing) {
        await _player.stop();
        if (mounted) setState(() => _playing = false);
        return;
      }
      final path = _path;
      if (path == null) return;
      setState(() => _playing = true);
      await _player.play(DeviceFileSource(path));
    } catch (e) {
      debugPrint("VoiceReplayControl playback failed (non-fatal): $e");
      if (mounted) setState(() => _playing = false);
    }
  }

  @override
  void dispose() {
    _player.dispose();
    if (_recording) StudentRecorder.instance.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_path != null) {
      return Padding(
        padding: const EdgeInsets.only(top: 10),
        child: Row(
          children: [
            Expanded(
              child: OutlinedButton.icon(
                onPressed: _togglePlay,
                icon: Icon(_playing ? Icons.stop_circle_outlined : Icons.play_circle_outline),
                label: Text(_playing ? "Stop" : "▶ Play back your voice"),
                style: OutlinedButton.styleFrom(
                  foregroundColor: AppColors.primaryDark,
                  side: const BorderSide(color: AppColors.primary),
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ),
              ),
            ),
            const SizedBox(width: 8),
            TextButton(
              onPressed: _startRecording,
              child: const Text("Re-record"),
            ),
          ],
        ),
      );
    }
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: SizedBox(
        width: double.infinity,
        child: OutlinedButton.icon(
          onPressed: _recording ? _stopRecording : _startRecording,
          icon: Icon(_recording ? Icons.stop_circle_outlined : Icons.fiber_manual_record),
          label: Text(_recording ? "Stop — tap when done" : "🎤 Record to hear yourself"),
          style: OutlinedButton.styleFrom(
            foregroundColor: _recording ? Colors.redAccent : AppColors.primaryDark,
            side: BorderSide(color: _recording ? Colors.redAccent : AppColors.primary),
            padding: const EdgeInsets.symmetric(vertical: 12),
          ),
        ),
      ),
    );
  }
}
