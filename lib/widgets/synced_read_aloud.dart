import 'package:flutter/material.dart';
import '../services/student_mic.dart';
import '../services/teacher_tts.dart';
import '../theme/app_theme.dart';

/// One sentence of a passage, paired with its Tamil translation.
class BilingualSentence {
  final String english;
  final String tamil;
  const BilingualSentence({required this.english, required this.tamil});
}

/// Splits a passage's English and Tamil text into matching sentence pairs,
/// using the ". ! ?" sentence-ending punctuation both languages in this
/// app's content already use. Every reading passage's Tamil translation in
/// composition_content.dart was written sentence-by-sentence (not as one
/// free-flowing paragraph retranslation) — checked by hand against every
/// passage before relying on this — so splitting both texts the same way
/// and zipping the results lines them up correctly, with no need to
/// hand-author a separate sentence-pair data file.
///
/// If a passage's English/Tamil sentence counts DON'T match (e.g. future
/// content added without matching translation granularity), this safely
/// falls back to treating the whole passage as a single "sentence" — the
/// caption then just shows the whole Tamil block at once, same as before
/// this feature existed, rather than guessing a wrong pairing.
List<BilingualSentence> splitIntoSentencePairs(String english, String tamil) {
  final en = _splitSentences(english);
  final ta = _splitSentences(tamil);
  if (en.isEmpty || ta.isEmpty || en.length != ta.length) {
    return [BilingualSentence(english: english.trim(), tamil: tamil.trim())];
  }
  return [for (var i = 0; i < en.length; i++) BilingualSentence(english: en[i], tamil: ta[i])];
}

List<String> _splitSentences(String text) {
  final normalized = text.replaceAll('\n', ' ').trim();
  if (normalized.isEmpty) return [];
  final matches = RegExp(r'[^.!?]+[.!?]+').allMatches(normalized);
  final sentences = matches.map((m) => m.group(0)!.trim()).where((s) => s.isNotEmpty).toList();
  return sentences.isEmpty ? [normalized] : sentences;
}

/// Reads a passage aloud sentence-by-sentence in English, while showing a
/// single synced Tamil "caption" for whichever sentence is currently being
/// spoken — like subtitles on a video/song. Per the client's explicit
/// request ("Youtube songs or movies pakurapa keela caption varumla,
/// apdi"), this replaces reading the whole passage as one long utterance
/// with a static Tamil block shown separately: now the Tamil meaning
/// appears one sentence at a time, in sync with the audio, with the
/// currently-spoken English sentence highlighted in the passage above it.
///
/// Pausing/resuming works at the sentence boundary (not mid-sentence,
/// unlike TeacherTts.pause/resumeFrom used elsewhere) — simpler and more
/// robust here, since the whole point is to always land on a clean
/// sentence boundary for the caption to make sense.
class SyncedReadAloud extends StatefulWidget {
  final String english;
  final String tamil;
  const SyncedReadAloud({super.key, required this.english, required this.tamil});

  @override
  State<SyncedReadAloud> createState() => _SyncedReadAloudState();
}

class _SyncedReadAloudState extends State<SyncedReadAloud> {
  late List<BilingualSentence> _sentences;
  int _current = -1;
  bool _playing = false;
  bool _stopRequested = false;

  @override
  void initState() {
    super.initState();
    _sentences = splitIntoSentencePairs(widget.english, widget.tamil);
  }

  @override
  void didUpdateWidget(covariant SyncedReadAloud oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.english != widget.english || oldWidget.tamil != widget.tamil) {
      _stop();
      _sentences = splitIntoSentencePairs(widget.english, widget.tamil);
      _current = -1;
    }
  }

  @override
  void dispose() {
    _stopRequested = true;
    TeacherTts.instance.stop();
    super.dispose();
  }

  Future<void> _play() async {
    await StudentMic.instance.cancel();
    final startFrom = (_current < 0 || _current >= _sentences.length) ? 0 : _current;
    setState(() {
      _playing = true;
      _stopRequested = false;
    });
    for (var i = startFrom; i < _sentences.length; i++) {
      if (_stopRequested || !mounted) break;
      setState(() => _current = i);
      await TeacherTts.instance.speak(_sentences[i].english);
    }
    if (!mounted) return;
    setState(() {
      _playing = false;
      if (!_stopRequested) _current = -1; // reached the end of the passage
    });
  }

  void _stop() {
    _stopRequested = true;
    TeacherTts.instance.stop();
    if (mounted) setState(() => _playing = false);
  }

  void _toggle() => _playing ? _stop() : _play();

  @override
  Widget build(BuildContext context) {
    final currentTamil = (_current >= 0 && _current < _sentences.length) ? _sentences[_current].tamil : null;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: _buildHighlightedText()),
            const SizedBox(width: 8),
            InkWell(
              borderRadius: BorderRadius.circular(20),
              onTap: _toggle,
              child: Container(
                width: 36,
                height: 36,
                decoration: const BoxDecoration(color: AppColors.primary, shape: BoxShape.circle),
                alignment: Alignment.center,
                child: Icon(_playing ? Icons.pause : Icons.volume_up, color: Colors.white, size: 18),
              ),
            ),
          ],
        ),
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 200),
          child: currentTamil == null
              ? const SizedBox.shrink(key: ValueKey("empty"))
              : Container(
                  key: ValueKey(_current),
                  margin: const EdgeInsets.only(top: 10),
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: AppColors.primary.withOpacity(0.08),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: AppColors.primary.withOpacity(0.25)),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Icon(Icons.closed_caption, size: 16, color: AppColors.primaryDark),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          currentTamil,
                          style: const TextStyle(fontSize: 13.5, height: 1.4, color: AppColors.primaryDark, fontWeight: FontWeight.w700),
                        ),
                      ),
                    ],
                  ),
                ),
        ),
      ],
    );
  }

  Widget _buildHighlightedText() {
    if (_sentences.length <= 1) {
      return Text(widget.english, style: const TextStyle(fontSize: 13.5, height: 1.5, color: AppColors.ink));
    }
    return RichText(
      text: TextSpan(
        style: const TextStyle(fontSize: 13.5, height: 1.5, color: AppColors.ink),
        children: [
          for (var i = 0; i < _sentences.length; i++)
            TextSpan(
              text: "${_sentences[i].english} ",
              style: i == _current
                  ? const TextStyle(backgroundColor: AppColors.warnBg, fontWeight: FontWeight.w800, color: AppColors.ink)
                  : null,
            ),
        ],
      ),
    );
  }
}
