import 'package:flutter/material.dart';
import '../../data/vocab_content.dart';
import '../../theme/app_theme.dart';
import 'confusables_screen.dart';
import 'fun_with_words_screen.dart';
import 'pronunciation_screen.dart';
import 'word_group_screen.dart';

/// Module 2 · Vocabulary — home screen. Lists every word-list section
/// from the book plus the pronunciation, confusable-words, and
/// fun-with-words areas.
class VocabHomeScreen extends StatelessWidget {
  const VocabHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Container(
                padding: const EdgeInsets.fromLTRB(12, 16, 18, 22),
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [AppColors.primary, Color(0xFF8B7CF6)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.only(bottomLeft: Radius.circular(28), bottomRight: Radius.circular(28)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        IconButton(
                          onPressed: () => Navigator.of(context).pop(),
                          icon: const Icon(Icons.arrow_back, color: Colors.white),
                          style: IconButton.styleFrom(backgroundColor: Colors.white24, shape: const CircleBorder()),
                        ),
                        const SizedBox(width: 8),
                        const Text("📖", style: TextStyle(fontSize: 24)),
                        const SizedBox(width: 8),
                        const Text("Module 2 · Vocabulary",
                            style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w800)),
                      ],
                    ),
                    const SizedBox(height: 8),
                    const Padding(
                      padding: EdgeInsets.only(left: 44),
                      child: Text("Word lists, idioms, pronunciation & word puzzles — with Tamil meanings",
                          style: TextStyle(color: Colors.white70, fontSize: 12.5)),
                    ),
                  ],
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(18, 18, 18, 6),
              sliver: SliverToBoxAdapter(
                child: Text("Word Lists", style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w800, color: AppColors.inkSoft, letterSpacing: 0.5)),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, i) {
                    final g = allWordGroups[i];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: _SectionTile(
                        emoji: g.emoji,
                        title: g.title,
                        subtitle: "${g.pairs.length} items",
                        onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => WordGroupScreen(group: g))),
                      ),
                    );
                  },
                  childCount: allWordGroups.length,
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(18, 22, 18, 6),
              sliver: SliverToBoxAdapter(
                child: Text("More", style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w800, color: AppColors.inkSoft, letterSpacing: 0.5)),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(18, 0, 18, 30),
              sliver: SliverList(
                delegate: SliverChildListDelegate([
                  _SectionTile(
                    emoji: "🤔",
                    title: "Confusable / Troublesome Words",
                    subtitle: "${confusables.length} pairs",
                    onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => const ConfusablesScreen())),
                  ),
                  const SizedBox(height: 10),
                  _SectionTile(
                    emoji: "🔤",
                    title: "Pronunciation & Syllables",
                    subtitle: "Silent letters, syllable groups",
                    onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => const PronunciationScreen())),
                  ),
                  const SizedBox(height: 10),
                  _SectionTile(
                    emoji: "🎲",
                    title: "Fun with Words",
                    subtitle: "Puzzles, quizzes & matching games",
                    onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => const FunWithWordsScreen())),
                  ),
                ]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SectionTile extends StatelessWidget {
  final String emoji;
  final String title;
  final String subtitle;
  final VoidCallback onTap;
  const _SectionTile({required this.emoji, required this.title, required this.subtitle, required this.onTap});

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
            Text(emoji, style: const TextStyle(fontSize: 26)),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: const TextStyle(fontSize: 14.5, fontWeight: FontWeight.w800)),
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
