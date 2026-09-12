import 'package:flutter/material.dart';
import '../../models/vocab.dart';
import '../../services/teacher_tts.dart';
import '../../theme/app_theme.dart';

/// Generic list screen for any WordGroup — used for every table-shaped
/// vocabulary section (difficult/easier words, idioms, the 13 category
/// word-lists, gender, sounds, young-ones) as well as the matching-style
/// puzzles in "Fun with Words" (games, country/currency, animal
/// association), since they're all just left↔right word pairs.
class WordGroupScreen extends StatelessWidget {
  final WordGroup group;
  const WordGroupScreen({super.key, required this.group});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: const EdgeInsets.fromLTRB(12, 16, 18, 18),
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(24), bottomRight: Radius.circular(24)),
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
                        Text(group.title,
                            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 16)),
                        Text("${group.pairs.length} items", style: const TextStyle(color: Colors.white70, fontSize: 12.5)),
                      ],
                    ),
                  ),
                  Text(group.emoji, style: const TextStyle(fontSize: 26)),
                ],
              ),
            ),
            if (group.tamilTitle.isNotEmpty)
              Padding(
                padding: const EdgeInsets.fromLTRB(18, 12, 18, 0),
                child: Text(group.tamilTitle, style: const TextStyle(color: AppColors.inkSoft, fontSize: 13, fontWeight: FontWeight.w600)),
              ),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(18),
                itemCount: group.pairs.length,
                itemBuilder: (context, i) {
                  final p = group.pairs[i];
                  return Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    padding: const EdgeInsets.all(14),
                    decoration: cardDecoration(),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Text(p.a,
                                        style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w800, color: AppColors.ink)),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 4),
                              Text("→ ${p.b}", style: const TextStyle(fontSize: 13.5, color: AppColors.inkSoft, height: 1.35)),
                              tamilMeaning(p.tamilB, topGap: 6),
                            ],
                          ),
                        ),
                        IconButton(
                          onPressed: () => TeacherTts.instance.speak(p.a),
                          icon: const Icon(Icons.volume_up, color: AppColors.primary),
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
