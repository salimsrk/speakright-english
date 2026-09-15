import 'package:flutter/material.dart';
import '../../models/comprehension.dart';
import '../../theme/app_theme.dart';

/// Shows one Module 4 reading passage: the English story, a short Tamil
/// summary, then its five comprehension questions in a "think first,
/// then reveal the model answer" list — the same reveal-answer pattern
/// Module 3 uses, since the book itself gives no answer key for these.
class ComprehensionPassageScreen extends StatefulWidget {
  final ComprehensionPassage passage;
  const ComprehensionPassageScreen({super.key, required this.passage});

  @override
  State<ComprehensionPassageScreen> createState() => _ComprehensionPassageScreenState();
}

class _ComprehensionPassageScreenState extends State<ComprehensionPassageScreen> {
  final Set<int> _revealed = {};

  @override
  Widget build(BuildContext context) {
    final passage = widget.passage;
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
                        Text(passage.title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 16)),
                        Text(passage.tamilTitle, style: const TextStyle(color: Colors.white70, fontSize: 12.5)),
                      ],
                    ),
                  ),
                  Text(passage.emoji, style: const TextStyle(fontSize: 26)),
                ],
              ),
            ),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(18),
                children: [
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: cardDecoration(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(passage.passage, style: const TextStyle(fontSize: 14, height: 1.5)),
                        if (passage.tamilSummary.isNotEmpty) tamilMeaning(passage.tamilSummary, topGap: 10),
                      ],
                    ),
                  ),
                  const SizedBox(height: 18),
                  const Text("Questions", style: TextStyle(fontSize: 13, fontWeight: FontWeight.w800, color: AppColors.inkSoft, letterSpacing: 0.5)),
                  const SizedBox(height: 10),
                  for (int i = 0; i < passage.questions.length; i++)
                    Container(
                      margin: const EdgeInsets.only(bottom: 12),
                      padding: const EdgeInsets.all(14),
                      decoration: cardDecoration(),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(passage.questions[i].prompt, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, height: 1.4)),
                          const SizedBox(height: 10),
                          if (_revealed.contains(i))
                            Container(
                              width: double.infinity,
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(color: AppColors.successBg, borderRadius: BorderRadius.circular(12)),
                              child: Text(passage.questions[i].answer, style: const TextStyle(fontSize: 13.5, height: 1.4)),
                            )
                          else
                            OutlinedButton(
                              onPressed: () => setState(() => _revealed.add(i)),
                              child: const Text("Show model answer"),
                            ),
                        ],
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
