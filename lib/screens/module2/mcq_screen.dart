import 'package:flutter/material.dart';
import '../../models/vocab.dart';
import '../../theme/app_theme.dart';

/// Reusable multiple-choice quiz screen — used for both the Synonym and
/// the Antonym drills. Tap an option to see if it's correct; tap "Next"
/// to move on.
class McqScreen extends StatefulWidget {
  final String title;
  final String emoji;
  final List<McqQuestion> questions;
  const McqScreen({super.key, required this.title, required this.emoji, required this.questions});

  @override
  State<McqScreen> createState() => _McqScreenState();
}

class _McqScreenState extends State<McqScreen> {
  int _i = 0;
  int? _picked;

  void _pick(int idx) {
    if (_picked != null) return;
    setState(() => _picked = idx);
  }

  void _next() {
    setState(() {
      _picked = null;
      _i = (_i + 1) % widget.questions.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    final q = widget.questions[_i];
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: const EdgeInsets.fromLTRB(12, 16, 18, 18),
              decoration: const BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(24), bottomRight: Radius.circular(24)),
              ),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: const Icon(Icons.arrow_back, color: Colors.white),
                    style: IconButton.styleFrom(backgroundColor: Colors.white24, shape: const CircleBorder()),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(widget.title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 16)),
                        Text("Question ${_i + 1} of ${widget.questions.length}",
                            style: const TextStyle(color: Colors.white70, fontSize: 12.5)),
                      ],
                    ),
                  ),
                  Text(widget.emoji, style: const TextStyle(fontSize: 26)),
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
                    Text(q.prompt, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w800)),
                    tamilMeaning(q.tamilPrompt, topGap: 6),
                  ],
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 18),
                itemCount: q.options.length,
                itemBuilder: (context, i) {
                  final isCorrect = i == q.correctIndex;
                  final isPicked = i == _picked;
                  Color? bg;
                  if (_picked != null) {
                    if (isCorrect) {
                      bg = AppColors.successBg;
                    } else if (isPicked) {
                      bg = AppColors.dangerBg;
                    }
                  }
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(14),
                      onTap: () => _pick(i),
                      child: Container(
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          color: bg ?? AppColors.surface,
                          borderRadius: BorderRadius.circular(14),
                          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.06), blurRadius: 10)],
                        ),
                        child: Row(
                          children: [
                            Expanded(child: Text(q.options[i], style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600))),
                            if (_picked != null && isCorrect) const Icon(Icons.check_circle, color: AppColors.success),
                            if (_picked != null && isPicked && !isCorrect) const Icon(Icons.cancel, color: Colors.redAccent),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(18),
              child: SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: _picked == null ? null : _next,
                  style: FilledButton.styleFrom(backgroundColor: AppColors.primaryDark, padding: const EdgeInsets.symmetric(vertical: 16)),
                  child: const Text("Next →", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
