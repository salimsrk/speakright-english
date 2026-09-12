import 'dart:math';
import 'package:flutter/material.dart';
import '../../models/vocab.dart';
import '../../theme/app_theme.dart';

/// Turns a matching-style WordGroup (word → game, country → currency,
/// Group A → Group B) into an interactive quiz: pick the answer you think
/// is right, then see whether you were correct — and the correct answer
/// if not — instead of the answer being shown right away.
class MatchingQuizScreen extends StatefulWidget {
  final String title;
  final String emoji;
  final WordGroup group;
  const MatchingQuizScreen({super.key, required this.title, required this.emoji, required this.group});

  @override
  State<MatchingQuizScreen> createState() => _MatchingQuizScreenState();
}

class _MatchingQuizScreenState extends State<MatchingQuizScreen> {
  int _i = 0;
  int? _picked;
  late final List<List<String>> _optionsPerQuestion;

  @override
  void initState() {
    super.initState();
    // Every possible answer in this group becomes an option for every
    // question — shuffled with a fixed (per-question) seed so the order
    // doesn't jump around when the widget rebuilds, but still differs
    // from the book's original left-to-right order.
    final allAnswers = widget.group.pairs.map((p) => p.b).toSet().toList();
    _optionsPerQuestion = widget.group.pairs.map((p) {
      final opts = List<String>.from(allAnswers);
      opts.shuffle(Random(p.a.hashCode));
      return opts;
    }).toList();
  }

  void _pick(int idx) {
    if (_picked != null) return;
    setState(() => _picked = idx);
  }

  void _next() {
    setState(() {
      _picked = null;
      _i = (_i + 1) % widget.group.pairs.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    final pair = widget.group.pairs[_i];
    final options = _optionsPerQuestion[_i];
    final correctIndex = options.indexOf(pair.b);

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
                        Text("Question ${_i + 1} of ${widget.group.pairs.length}",
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
                child: Text(pair.a, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w800)),
              ),
            ),
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
                        _picked == correctIndex ? "Correct!" : "Not quite — the correct answer is: ${pair.b}",
                        style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 14),
                      ),
                      tamilMeaning(pair.tamilB, topGap: 6),
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
