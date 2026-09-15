import 'package:flutter/material.dart';
import '../../data/composition_content.dart';
import '../../theme/app_theme.dart';

/// "Improve Your Reading Skill" — all 5 passages shown in full, one
/// after another, since the book's own instruction is simply to read
/// them aloud (with the teacher's guidance on pronunciation) rather
/// than answer questions on them.
class ReadingPassagesScreen extends StatelessWidget {
  const ReadingPassagesScreen({super.key});

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
                    child: Text("Improve Your Reading Skill", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 16)),
                  ),
                  const Text("📖", style: TextStyle(fontSize: 26)),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(18),
                itemCount: readingPassages.length,
                itemBuilder: (context, i) {
                  final p = readingPassages[i];
                  return Container(
                    margin: const EdgeInsets.only(bottom: 16),
                    padding: const EdgeInsets.all(16),
                    decoration: cardDecoration(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(p.emoji, style: const TextStyle(fontSize: 22)),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text("${i + 1}. ${p.title}", style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w800)),
                            ),
                          ],
                        ),
                        if (p.byline.isNotEmpty)
                          Padding(
                            padding: const EdgeInsets.only(top: 2, left: 30),
                            child: Text(p.byline, style: const TextStyle(fontSize: 12, fontStyle: FontStyle.italic, color: AppColors.inkSoft)),
                          ),
                        if (p.tamilTitle.isNotEmpty)
                          Padding(
                            padding: const EdgeInsets.only(top: 2, left: 30),
                            child: Text(p.tamilTitle, style: const TextStyle(fontSize: 12.5, color: AppColors.inkSoft, fontWeight: FontWeight.w600)),
                          ),
                        const SizedBox(height: 10),
                        Text(p.passage, style: const TextStyle(fontSize: 13.5, height: 1.5)),
                        if (p.tamilSummary.isNotEmpty) tamilMeaning(p.tamilSummary, topGap: 10),
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
