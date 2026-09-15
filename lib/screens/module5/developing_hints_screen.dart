import 'package:flutter/material.dart';
import '../../data/composition_content.dart';
import '../../theme/app_theme.dart';

/// "Composition - B: Developing Hints" — the book's 5 hint outlines,
/// each with a "think first, then reveal" sample story, the same
/// reveal pattern used across the app for open-ended writing.
class DevelopingHintsScreen extends StatefulWidget {
  const DevelopingHintsScreen({super.key});

  @override
  State<DevelopingHintsScreen> createState() => _DevelopingHintsScreenState();
}

class _DevelopingHintsScreenState extends State<DevelopingHintsScreen> {
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
                    child: Text("Developing Hints", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 16)),
                  ),
                  const Text("📝", style: TextStyle(fontSize: 26)),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(18, 14, 18, 0),
              child: Text(
                "Develop each set of hints into a short story of your own — then check the sample below.",
                style: const TextStyle(fontSize: 12.5, color: AppColors.inkSoft, height: 1.4),
              ),
            ),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(18),
                itemCount: storyHints.length,
                itemBuilder: (context, i) {
                  final h = storyHints[i];
                  return Container(
                    margin: const EdgeInsets.only(bottom: 16),
                    padding: const EdgeInsets.all(16),
                    decoration: cardDecoration(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(h.emoji, style: const TextStyle(fontSize: 22)),
                            const SizedBox(width: 8),
                            Expanded(child: Text("${i + 1}. ${h.title}", style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w800))),
                          ],
                        ),
                        if (h.tamilTitle.isNotEmpty)
                          Padding(
                            padding: const EdgeInsets.only(top: 2, left: 30),
                            child: Text(h.tamilTitle, style: const TextStyle(fontSize: 12.5, color: AppColors.inkSoft, fontWeight: FontWeight.w600)),
                          ),
                        const SizedBox(height: 10),
                        Text(h.hint, style: const TextStyle(fontSize: 13.5, height: 1.5, fontStyle: FontStyle.italic)),
                        if (h.tamilHint.isNotEmpty) tamilMeaning(h.tamilHint, topGap: 6),
                        const SizedBox(height: 12),
                        if (_revealed.contains(i))
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(color: AppColors.successBg, borderRadius: BorderRadius.circular(12)),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(h.sampleStory, style: const TextStyle(fontSize: 13.5, height: 1.5)),
                                if (h.tamilSampleStory.isNotEmpty) tamilMeaning(h.tamilSampleStory, topGap: 8),
                              ],
                            ),
                          )
                        else
                          OutlinedButton(
                            onPressed: () => setState(() => _revealed.add(i)),
                            child: const Text("Show sample story"),
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
