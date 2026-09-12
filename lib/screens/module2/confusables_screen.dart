import 'package:flutter/material.dart';
import '../../data/vocab_content.dart';
import '../../services/teacher_tts.dart';
import '../../theme/app_theme.dart';

/// Easily-confused ("troublesome") word pairs, with a short explanation
/// of the difference between them.
class ConfusablesScreen extends StatelessWidget {
  const ConfusablesScreen({super.key});

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
                    child: Text("Confusable / Troublesome Words",
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 16)),
                  ),
                  const Text("🤔", style: TextStyle(fontSize: 26)),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(18),
                itemCount: confusables.length,
                itemBuilder: (context, i) {
                  final c = confusables[i];
                  return Container(
                    margin: const EdgeInsets.only(bottom: 14),
                    padding: const EdgeInsets.all(16),
                    decoration: cardDecoration(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text("${c.wordA}  vs.  ${c.wordB}",
                                  style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w800, color: AppColors.ink)),
                            ),
                            IconButton(
                              onPressed: () => TeacherTts.instance.speak("${c.wordA}. ${c.wordB}."),
                              icon: const Icon(Icons.volume_up, color: AppColors.primary),
                            ),
                          ],
                        ),
                        const SizedBox(height: 6),
                        Text(c.explanation, style: const TextStyle(fontSize: 13.5, height: 1.4, color: AppColors.inkSoft)),
                        tamilMeaning(c.tamilExplanation, topGap: 8),
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
