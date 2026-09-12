import 'package:flutter/material.dart';
import '../../data/vocab_content.dart';
import '../../theme/app_theme.dart';

/// Reference screen for the three stand-alone puzzles from the book that
/// are pictures rather than plain text (missing-letters grid, the bottle
/// riddle, the 26-letter crossword). One has a confirmed solution; the
/// other two have no answer anywhere in the source book, and are shown
/// honestly as open puzzles rather than guessed.
class PuzzleReferenceScreen extends StatefulWidget {
  const PuzzleReferenceScreen({super.key});

  @override
  State<PuzzleReferenceScreen> createState() => _PuzzleReferenceScreenState();
}

class _PuzzleReferenceScreenState extends State<PuzzleReferenceScreen> {
  final Set<int> _revealed = {};

  @override
  Widget build(BuildContext context) {
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
                  const Expanded(
                    child: Text("More Puzzles", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 16)),
                  ),
                  const Text("🧩", style: TextStyle(fontSize: 26)),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(18),
                itemCount: puzzleReferences.length,
                itemBuilder: (context, i) {
                  final p = puzzleReferences[i];
                  final revealed = _revealed.contains(i);
                  return Container(
                    margin: const EdgeInsets.only(bottom: 14),
                    padding: const EdgeInsets.all(16),
                    decoration: cardDecoration(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(p.title, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w800, color: AppColors.ink)),
                        Text(p.tamilTitle, style: const TextStyle(fontSize: 12.5, color: AppColors.inkSoft, fontWeight: FontWeight.w600)),
                        const SizedBox(height: 8),
                        Text(p.description, style: const TextStyle(fontSize: 13.5, height: 1.4)),
                        tamilMeaning(p.tamilDescription, topGap: 6),
                        const SizedBox(height: 10),
                        if (revealed)
                          Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: p.solution != null ? AppColors.successBg : AppColors.warnBg,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(p.solution ?? "No confirmed answer for this one — the book's picture puzzle has no printed solution.",
                                    style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 13.5)),
                                if (p.tamilSolution != null) tamilMeaning(p.tamilSolution!, topGap: 6),
                              ],
                            ),
                          )
                        else
                          OutlinedButton(
                            onPressed: () => setState(() => _revealed.add(i)),
                            child: Text(p.solution != null ? "Show answer" : "Show note"),
                          ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
