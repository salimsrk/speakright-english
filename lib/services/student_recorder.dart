import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
import 'package:record/record.dart';

/// Records the student's own voice so they can play it back afterwards
/// (the client's request: "student pesuratha play back panni pakura
/// option"). `speech_to_text` (used by StudentMic) only ever gives us a
/// live, on-device TRANSCRIPT — it never exposes the recorded audio
/// itself, so there was previously no way to play a take back. This class
/// adds that, completely separately.
///
/// CRITICAL — READ BEFORE CALLING start() NEAR StudentMic:
/// The very first version of this feature called start()/stop() around
/// StudentMic.listenOnce(), so the same take could be both scored AND
/// played back. That was shipped and tested on a real device, and it
/// reliably broke speech recognition: every attempt came back "Didn't
/// catch that", 100% of the time. Root cause — recording audio (this
/// class's own AudioRecord session, via the `record` package) and
/// speech_to_text's live recognition both need exclusive access to the
/// microphone; when both are open at once, the OS lets only one of them
/// actually hear real audio, and it silently starved the recognizer
/// instead of throwing an error, which is why it looked like STT itself
/// had regressed. See widgets/voice_replay_control.dart for the fix: it
/// only ever opens a StudentRecorder session AFTER a StudentMic session
/// has fully finished, never during or overlapping with one. Do not
/// reintroduce concurrent start()/listenOnce() calls.
///
/// This is otherwise a strictly ADDITIVE, fail-soft layer. StudentMic's
/// own listen/retry logic has a long, hard-won history of native-hang
/// bugs (see that file's header comment), so this class must never be
/// allowed to throw or block. Every method below swallows its own errors
/// and returns a "nothing happened" result instead — on a device where
/// recording fails (permission denied, mic busy, unsupported codec, etc.)
/// the practical effect is simply that no playback is offered for that
/// take.
class StudentRecorder {
  StudentRecorder._();
  static final StudentRecorder instance = StudentRecorder._();

  final AudioRecorder _recorder = AudioRecorder();
  bool _recording = false;

  /// Starts recording the student's voice to a fresh temp file. Returns
  /// true only if recording actually started; false (never an exception)
  /// for any reason it couldn't, including permission being denied.
  Future<bool> start() async {
    try {
      if (_recording) {
        // Defensive cleanup in case a previous take was never stopped
        // (e.g. the caller hit an early-return path) — never let a stale
        // session block a new one.
        try {
          await _recorder.stop();
        } catch (_) {
          // ignore
        }
        _recording = false;
      }
      final hasPermission = await _recorder.hasPermission();
      if (!hasPermission) return false;
      final dir = await getTemporaryDirectory();
      final path = "${dir.path}/speakright_take_${DateTime.now().millisecondsSinceEpoch}.m4a";
      await _recorder.start(const RecordConfig(encoder: AudioEncoder.aacLc), path: path);
      _recording = true;
      return true;
    } catch (e) {
      debugPrint("StudentRecorder.start() failed (non-fatal — playback just won't be offered for this take): $e");
      _recording = false;
      return false;
    }
  }

  /// Stops recording and returns the saved file's path, or null if nothing
  /// usable was captured. Never throws.
  Future<String?> stop() async {
    if (!_recording) return null;
    try {
      final path = await _recorder.stop();
      _recording = false;
      if (path == null) return null;
      final file = File(path);
      if (!await file.exists()) return null;
      final size = await file.length();
      if (size <= 0) return null;
      return path;
    } catch (e) {
      debugPrint("StudentRecorder.stop() failed (non-fatal — playback just won't be offered for this take): $e");
      _recording = false;
      return null;
    }
  }

  /// Discards whatever is currently being recorded, without returning a
  /// path — used when a listen attempt errors out before there's anything
  /// worth keeping. Never throws.
  Future<void> cancel() async {
    if (!_recording) return;
    try {
      await _recorder.stop();
    } catch (_) {
      // ignore
    } finally {
      _recording = false;
    }
  }
}
