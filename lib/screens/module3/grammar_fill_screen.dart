import 'package:flutter/material.dart';
import '../../models/grammar.dart';
import '../../theme/app_theme.dart';

/// Reusable "think first, then reveal" screen for every Module 3 exercise
/// that isn't a two-way MCQ choice — noun pairs, verb agreement, voice
/// change, prepositions, articles, question tags, word formation, and the
/// worked-reference sets (adjective identification, noun clauses) where the
/// book already gives the answer. Modeled directly on Module 2's
/// JumbledWordsScreen, just swapping AnagramItem for GrammarFillItem.
class GrammarFillScreen extends StatefulWidget {
  final GrammarFillSet set;
  const GrammarFillScreen({super.key, required this.set});

  @override
  State<GrammarFillScreen> createState() => _GrammarFillScreenState();
}

class _GrammarFillScreenState extends State<GrammarFillScreen> {
  final Set<int> _revealed = {};

  @override
  Widget build(BuildContext context) {
    final set = widget.set;
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
                    child: Text(set.title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 16)),
                  ),
                  Text(set.emoji, style: const TextStyle(fontSize: 26)),
                ],
              ),
            ),
            if (set.instructions.isNotEmpty)
              Padding(
                padding: const EdgeInsets.fromLTRB(18, 14, 18, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(set.instructions, style: const TextStyle(fontSize: 13.5, color: AppColors.inkSoft, height: 1.4)),
                    if (set.tamilInstructions.isNotEmpty) tamilMeaning(set.tamilInstructions, topGap: 4),
                  ],
                ),
              ),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(18),
                itemCount: set.items.length,
                itemBuilder: (context, i) {
                  final item = set.items[i];
                  final revealed = _revealed.contains(i);
                  return Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    padding: const EdgeInsets.all(16),
                    decoration: cardDecoration(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("${i + 1}. ", style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w800, color: AppColors.primaryDark)),
                            Expanded(
                              child: Text(item.prompt, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600, height: 1.35)),
                            ),
                          ],
                        ),
                        if (item.tamilHint.isNotEmpty) tamilMeaning(item.tamilHint, topGap: 6),
                        const SizedBox(height: 10),
                        if (revealed)
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                            decoration: BoxDecoration(color: AppColors.successBg, borderRadius: BorderRadius.circular(10)),
                            child: Text(item.answer, style: const TextStyle(fontWeight: FontWeight.w800, color: AppColors.ink, height: 1.35)),
                          )
                        else
                          OutlinedButton(
                            onPressed: () => setState(() => _revealed.add(i)),
                            child: const Text("Show answer"),
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
