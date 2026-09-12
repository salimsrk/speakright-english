import 'package:flutter/material.dart';
import '../../data/vocab_content.dart';
import '../../theme/app_theme.dart';
import 'jumbled_words_screen.dart';
import 'matching_quiz_screen.dart';
import 'mcq_screen.dart';
import 'odd_one_out_screen.dart';
import 'puzzle_reference_screen.dart';
import 'theme_quiz_screen.dart';

/// Hub screen for the book's "Fun with Words" section — links out to
/// every puzzle type: odd-one-out, jumbled words, synonym/antonym MCQs,
/// the three matching puzzles, the LEMONADE theme quiz, the non-mammal
/// anagram puzzle, and the picture-only reference puzzles.
class FunWithWordsScreen extends StatelessWidget {
  const FunWithWordsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final tiles = <_PuzzleTile>[
      _PuzzleTile(
        emoji: "🔎",
        title: "Spot the Odd Word Out",
        subtitle: "${oddOneOutQuestions.length} questions",
        builder: (_) => const OddOneOutScreen(),
      ),
      _PuzzleTile(
        emoji: "🔤",
        title: "Jumbled Words",
        subtitle: "${jumbledWords.length} words to unscramble",
        builder: (_) => JumbledWordsScreen(title: "Jumbled Words", emoji: "🔤", items: jumbledWords),
      ),
      _PuzzleTile(
        emoji: "🦁",
        title: "Find the Non-Mammal",
        subtitle: "Unscramble 5 animal names — one isn't a mammal",
        builder: (_) => JumbledWordsScreen(
          title: "Find the Non-Mammal",
          emoji: "🦁",
          items: nonMammalPuzzle,
          intro: "Rearrange the letters to find the animal name. Four are mammals — one is not.",
          tamilIntro: "எழுத்துக்களை மறுசீரமைத்து விலங்கின் பெயரைக் கண்டுபிடிக்கவும். நான்கு பாலூட்டிகள் — ஒன்று மட்டும் அல்ல.",
        ),
      ),
      _PuzzleTile(
        emoji: "✅",
        title: "Synonyms",
        subtitle: "${synonymQuestions.length} questions",
        builder: (_) => McqScreen(title: "Synonyms", emoji: "✅", questions: synonymQuestions),
      ),
      _PuzzleTile(
        emoji: "🔁",
        title: "Antonyms",
        subtitle: "${antonymQuestions.length} questions",
        builder: (_) => McqScreen(title: "Antonyms", emoji: "🔁", questions: antonymQuestions),
      ),
      _PuzzleTile(
        emoji: "🏏",
        title: "Word → Game(s)",
        subtitle: "${gamesMatching.pairs.length} items",
        builder: (_) => MatchingQuizScreen(title: "Word → Game(s)", emoji: "🏏", group: gamesMatching),
      ),
      _PuzzleTile(
        emoji: "💱",
        title: "Country ↔ Currency",
        subtitle: "${countryCurrencyMatching.pairs.length} items",
        builder: (_) => MatchingQuizScreen(title: "Country ↔ Currency", emoji: "💱", group: countryCurrencyMatching),
      ),
      _PuzzleTile(
        emoji: "🐘",
        title: "Group A ↔ Group B",
        subtitle: "${animalAssociationMatching.pairs.length} items",
        builder: (_) => MatchingQuizScreen(title: "Group A ↔ Group B", emoji: "🐘", group: animalAssociationMatching),
      ),
      _PuzzleTile(
        emoji: "🍋",
        title: "LEMONADE — Connect the Theme",
        subtitle: "${lemonadeQuiz.length} items",
        builder: (_) => const ThemeQuizScreen(),
      ),
      _PuzzleTile(
        emoji: "🧩",
        title: "More Puzzles",
        subtitle: "Missing letters, crossword, bottle riddle",
        builder: (_) => const PuzzleReferenceScreen(),
      ),
    ];

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
                    child: Text("Fun with Words", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 16)),
                  ),
                  const Text("🎲", style: TextStyle(fontSize: 26)),
                ],
              ),
            ),
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.all(18),
                itemCount: tiles.length,
                separatorBuilder: (_, __) => const SizedBox(height: 12),
                itemBuilder: (context, i) {
                  final t = tiles[i];
                  return InkWell(
                    borderRadius: BorderRadius.circular(16),
                    onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: t.builder)),
                    child: Container(
                      padding: const EdgeInsets.all(14),
                      decoration: cardDecoration(),
                      child: Row(
                        children: [
                          Text(t.emoji, style: const TextStyle(fontSize: 26)),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(t.title, style: const TextStyle(fontSize: 14.5, fontWeight: FontWeight.w800)),
                                Text(t.subtitle, style: const TextStyle(fontSize: 12, color: AppColors.inkSoft)),
                              ],
                            ),
                          ),
                          const Icon(Icons.chevron_right, color: AppColors.inkSoft),
                        ],
                      ),
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

class _PuzzleTile {
  final String emoji;
  final String title;
  final String subtitle;
  final WidgetBuilder builder;
  _PuzzleTile({required this.emoji, required this.title, required this.subtitle, required this.builder});
}
