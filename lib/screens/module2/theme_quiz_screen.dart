import 'package:flutter/material.dart';
import '../../data/vocab_content.dart';
import '../../theme/app_theme.dart';

/// The "LEMONADE" vocabulary test — a set of clue words that all connect
/// to one hidden theme/answer (e.g. "Monitors, Motherboard, Software,
/// Floppy" → Computer).
class ThemeQuizScreen extends StatefulWidget {
  const ThemeQuizScreen({super.key});

  @override
  State<ThemeQuizScreen> createState() => _ThemeQuizScreenState();
}

class _ThemeQuizScreenState extends State<ThemeQuizScreen> {
  int _i = 0;
  bool _revealed = false;

  void _next() {
    setState(() {
      _revealed = false;
      _i = (_i + 1) % lemonadeQuiz.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    final item = lemonadeQuiz[_i];
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
              padding: const EdgeInsets.all(18),
              child: Text(
                "What do these words have in common? (Example: Catch, run-out, Wicket, Pitch → Cricket)",
                style: const TextStyle(fontSize: 13, color: AppColors.inkSoft, height: 1.4),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18),
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
            const Spacer(),
            if (_revealed)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18),
                child: Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(color: AppColors.successBg, borderRadius: BorderRadius.circular(14)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Answer: ${item.answer}", style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 16)),
                      tamilMeaning(item.tamilAnswer, topGap: 4),
                    ],
                  ),
                ),
              ),
            Padding(
              padding: const EdgeInsets.all(18),
              child: SizedBox(
                width: double.infinity,
                child: _revealed
                    ? FilledButton(
                        onPressed: _next,
                        style: FilledButton.styleFrom(backgroundColor: AppColors.primaryDark, padding: const EdgeInsets.symmetric(vertical: 16)),
                        child: const Text("Next →", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
                      )
                    : OutlinedButton(
                        onPressed: () => setState(() => _revealed = true),
                        style: OutlinedButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 16)),
                        child: const Text("Show answer", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
