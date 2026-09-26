import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import '../theme/app_theme.dart';

/// A small "▶ Play back your voice" button shown next to a student's
/// speaking-practice result, once a recording of that attempt has been
/// successfully captured by StudentRecorder. Renders nothing at all when
/// [audioPath] is null (e.g. recording wasn't available on this device),
/// so it's always safe to drop into a screen unconditionally.
///
/// Fail-soft by design: if playback fails for any reason, it just resets
/// to the "play" state instead of surfacing an error — hearing your own
/// voice again is a nice-to-have, never something that should interrupt
/// the actual lesson.
class VoicePlaybackButton extends StatefulWidget {
  final String? audioPath;
  const VoicePlaybackButton({super.key, required this.audioPath});

  @override
  State<VoicePlaybackButton> createState() => _VoicePlaybackButtonState();
}

class _VoicePlaybackButtonState extends State<VoicePlaybackButton> {
  final AudioPlayer _player = AudioPlayer();
  bool _playing = false;

  @override
  void initState() {
    super.initState();
    _player.onPlayerComplete.listen((_) {
      if (mounted) setState(() => _playing = false);
    });
  }

  @override
  void didUpdateWidget(covariant VoicePlaybackButton oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.audioPath != widget.audioPath) {
      _player.stop();
      _playing = false;
    }
  }

  Future<void> _toggle() async {
    try {
      if (_playing) {
        await _player.stop();
        if (mounted) setState(() => _playing = false);
        return;
      }
      final path = widget.audioPath;
      if (path == null) return;
      setState(() => _playing = true);
      await _player.play(DeviceFileSource(path));
    } catch (e) {
      debugPrint("VoicePlaybackButton playback failed (non-fatal): $e");
      if (mounted) setState(() => _playing = false);
    }
  }

  @override
  void dispose() {
    _player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.audioPath == null) return const SizedBox.shrink();
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: SizedBox(
        width: double.infinity,
        child: OutlinedButton.icon(
          onPressed: _toggle,
          icon: Icon(_playing ? Icons.stop_circle_outlined : Icons.play_circle_outline),
          label: Text(_playing ? "Stop" : "▶ Play back your voice"),
          style: OutlinedButton.styleFrom(
            foregroundColor: AppColors.primaryDark,
            side: const BorderSide(color: AppColors.primary),
            padding: const EdgeInsets.symmetric(vertical: 12),
          ),
        ),
      ),
    );
  }
}
