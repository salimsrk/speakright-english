import 'package:flutter/material.dart';
import '../../models/vocab.dart';
import '../../theme/app_theme.dart';

/// Reusable "unscramble the letters" screen — used for both the Jumbled
/// Words puzzle and the "find the non-mammal" puzzle (reveal-the-answer
/// style, since these are meant to be worked out on paper/aloud first).
class JumbledWordsScreen extends StatefulWidget {
  final String title;
  final String emoji;
  final List<AnagramItem> items;
  final String? intro;
  final String? tamilIntro;
  const JumbledWordsScreen({
    super.key,
    required this.title,
    required this.emoji,
    required this.items,
    this.intro,
    this.tamilIntro,
  });

  @override
  State<JumbledWordsScreen> createState() => _JumbledWordsScreenState();
}

class _JumbledWordsScreenState extends State<JumbledWordsScreen> {
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
                  Expanded(
                    child: Text(widget.title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 16)),
                  ),
                  Text(widget.emoji, style: const TextStyle(fontSize: 26)),
                ],
              ),
            ),
            if (widget.intro != null)
              Padding(
                padding: const EdgeInsets.fromLTRB(18, 14, 18, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(widget.intro!, style: const TextStyle(fontSize: 13.5, color: AppColors.inkSoft, height: 1.4)),
                    if (widget.tamilIntro != null) tamilMeaning(widget.tamilIntro!, topGap: 4),
                  ],
                ),
              ),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(18),
                itemCount: widget.items.length,
                itemBuilder: (context, i) {
                  final item = widget.items[i];
                  final revealed = _revealed.contains(i);
                  return Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    padding: const EdgeInsets.all(16),
                    decoration: cardDecoration(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(item.scrambled.toUpperCase(),
                            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w800, letterSpacing: 3, color: AppColors.primaryDark)),
                        const SizedBox(height: 6),
                        Text("Clue: ${item.clue}", style: const TextStyle(fontSize: 13.5, color: AppColors.inkSoft)),
                        tamilMeaning(item.tamilClue, topGap: 4),
                        const SizedBox(height: 10),
                        if (revealed)
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                            decoration: BoxDecoration(color: AppColors.successBg, borderRadius: BorderRadius.circular(10)),
                            child: Text("Answer: ${item.answer}",
                                style: const TextStyle(fontWeight: FontWeight.w800, color: AppColors.ink)),
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
