import 'package:flutter/material.dart';
import '../../models/grammar.dart';
import '../../theme/app_theme.dart';
import '../module2/mcq_screen.dart';
import 'grammar_fill_screen.dart';

/// Explanation screen for one Module 3 grammar topic — an intro paragraph
/// followed by its GrammarPoint "rule cards" (heading, short explanation,
/// example sentences), then a Practice section at the bottom linking to
/// whatever exercise(s) belong to this topic, if any.
class GrammarTopicScreen extends StatelessWidget {
  final GrammarTopic topic;
  const GrammarTopicScreen({super.key, required this.topic});

  @override
  Widget build(BuildContext context) {
    final hasPractice = topic.fillSets.isNotEmpty || topic.mcq != null;
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
                        Text(topic.title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 16)),
                        Text(topic.tamilTitle, style: const TextStyle(color: Colors.white70, fontSize: 12.5)),
                      ],
                    ),
                  ),
                  Text(topic.emoji, style: const TextStyle(fontSize: 26)),
                ],
              ),
            ),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(18),
                children: [
                  if (topic.intro.isNotEmpty)
                    Container(
                      margin: const EdgeInsets.only(bottom: 14),
                      padding: const EdgeInsets.all(16),
                      decoration: cardDecoration(),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(topic.intro, style: const TextStyle(fontSize: 14, height: 1.45)),
                          if (topic.tamilIntro.isNotEmpty) tamilMeaning(topic.tamilIntro, topGap: 8),
                        ],
                      ),
                    ),
                  for (final p in topic.points)
                    Container(
                      margin: const EdgeInsets.only(bottom: 14),
                      padding: const EdgeInsets.all(16),
                      decoration: cardDecoration(),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(p.heading, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w800, color: AppColors.ink)),
                          if (p.tamilHeading.isNotEmpty)
                            Text(p.tamilHeading, style: const TextStyle(fontSize: 12.5, color: AppColors.inkSoft, fontWeight: FontWeight.w600)),
                          if (p.explanation.isNotEmpty) ...[
                            const SizedBox(height: 8),
                            Text(p.explanation, style: const TextStyle(fontSize: 13, height: 1.4)),
                          ],
                          if (p.tamilExplanation.isNotEmpty) tamilMeaning(p.tamilExplanation, topGap: 6),
                          if (p.examples.isNotEmpty) ...[
                            const SizedBox(height: 10),
                            ...p.examples.map(
                              (e) => Padding(
                                padding: const EdgeInsets.only(bottom: 6),
                                child: Text("•  $e", style: const TextStyle(fontSize: 13.5, height: 1.4)),
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                  if (hasPractice) ...[
                    const SizedBox(height: 4),
                    const Text("Practice", style: TextStyle(fontSize: 13, fontWeight: FontWeight.w800, color: AppColors.inkSoft, letterSpacing: 0.5)),
                    const SizedBox(height: 10),
                    for (final set in topic.fillSets)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: _PracticeTile(
                          emoji: set.emoji,
                          title: set.title,
                          subtitle: "${set.items.length} items",
                          onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => GrammarFillScreen(set: set))),
                        ),
                      ),
                    if (topic.mcq != null)
                      _PracticeTile(
                        emoji: topic.emoji,
                        title: topic.mcq!.title,
                        subtitle: "${topic.mcq!.questions.length} questions",
                        onTap: () => Navigator.of(context).push(MaterialPageRoute(
                          builder: (_) => McqScreen(title: topic.mcq!.title, emoji: topic.emoji, questions: topic.mcq!.questions),
                        )),
                      ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PracticeTile extends StatelessWidget {
  final String emoji;
  final String title;
  final String subtitle;
  final VoidCallback onTap;
  const _PracticeTile({required this.emoji, required this.title, required this.subtitle, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: cardDecoration(),
        child: Row(
          children: [
            Text(emoji, style: const TextStyle(fontSize: 24)),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w800)),
                  Text(subtitle, style: const TextStyle(fontSize: 12, color: AppColors.inkSoft)),
                ],
              ),
            ),
            const Icon(Icons.chevron_right, color: AppColors.inkSoft),
          ],
        ),
      ),
    );
  }
}
