import 'dart:math';
import 'package:flutter/material.dart';
import '../../data/vocab_content.dart';
import '../../theme/app_theme.dart';
import '../../widgets/fun_fact_dialog.dart';

/// The "LEMONADE" vocabulary test — a set of clue words that all connect
/// to one hidden theme/answer (e.g. "Monitors, Motherboard, Software,
/// Floppy" → Computer). The student picks which answer they think fits
/// before finding out whether they're right, instead of the answer being
/// shown right away.
class ThemeQuizScreen extends StatefulWidget {
  const ThemeQuizScreen({super.key});

  @override
  State<ThemeQuizScreen> createState() => _ThemeQuizScreenState();
}

class _ThemeQuizScreenState extends State<ThemeQuizScreen> {
  int _i = 0;
  int? _picked;
  late final List<List<String>> _optionsPerQuestion;

  @override
  void initState() {
    super.initState();
    final allAnswers = lemonadeQuiz.map((q) => q.answer).toSet().toList();
    _optionsPerQuestion = lemonadeQuiz.map((q) {
      final opts = List<String>.from(allAnswers);
      opts.shuffle(Random(q.answer.hashCode));
      return opts;
    }).toList();
  }

  void _pick(int idx) {
    if (_picked != null) return;
    setState(() => _picked = idx);
  }

  Future<void> _next() async {
    // Wrapping back to the first item means the student just finished a
    // full pass through this quiz — a natural "exercise complete" point.
    final justFinishedAll = _i == lemonadeQuiz.length - 1;
    setState(() {
      _picked = null;
      _i = (_i + 1) % lemonadeQuiz.length;
    });
    if (justFinishedAll) await showFunFact(context);
  }

  @override
  Widget build(BuildContext context) {
    final item = lemonadeQuiz[_i];
    final options = _optionsPerQuestion[_i];
    final correctIndex = options.indexOf(item.answer);

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
                        const Text("LEMONADE — Connect the Theme",
                            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 16)),
                        Text("Item ${_i + 1} of ${lemonadeQuiz.length}", style: const TextStyle(color: Colors.white70, fontSize: 12.5)),
                      ],
                    ),
                  ),
                  const Text("🍋", style: TextStyle(fontSize: 26)),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(18, 14, 18, 0),
              child: Text(
                "What do these words have in common? (Example: Catch, run-out, Wicket, Pitch → Cricket)",
                style: const TextStyle(fontSize: 13, color: AppColors.inkSoft, height: 1.4),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(18, 12, 18, 0),
              child: Container(
                padding: const EdgeInsets.all(18),
                decoration: cardDecoration(),
                child: Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: item.clues
                      .map((w) => Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                            decoration: BoxDecoration(color: AppColors.bg, borderRadius: BorderRadius.circular(10)),
                            child: Text(w, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700)),
                          ))
                      .toList(),
                ),
              ),
            ),
            const SizedBox(height: 14),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 18),
                itemCount: options.length,
                itemBuilder: (context, i) {
                  final isCorrect = i == correctIndex;
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
                            Expanded(child: Text(options[i], style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600))),
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
            if (_picked != null)
              Padding(
                padding: const EdgeInsets.fromLTRB(18, 0, 18, 0),
                child: Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: _picked == correctIndex ? AppColors.successBg : AppColors.warnBg,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _picked == correctIndex ? "Correct!" : "Not quite — the correct answer is: ${item.answer}",
                        style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 14),
                      ),
                      tamilMeaning(item.tamilAnswer, topGap: 6),
                    ],
                  ),
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
