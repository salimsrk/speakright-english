// Data models for Module 2 (Vocabulary). Kept separate from topic.dart
// (Module 1 · Conversation) since the shapes are different, but all of
// these reuse the shared `tamilMeaning()` helper in theme/app_theme.dart
// and the existing TeacherTts/StudentMic services, same as Module 1.

/// A generic "left ↔ right" word pair, reused for every table-shaped piece
/// of vocabulary content: difficult/easier words, idioms & meanings, the
/// 13 category word-lists, gender pairs, animal sounds, young-ones names,
/// and the matching-style puzzles (games, country↔currency,
/// animal↔association). `tamilB` carries the Tamil translation of
/// whichever side is the "meaning/answer" side.
class WordPair {
  final String a;
  final String b;
  final String tamilB;
  const WordPair(this.a, this.b, {this.tamilB = ""});
}

/// One vocabulary section/screen: a titled list of WordPairs with labels
/// for what the two columns mean (e.g. "Word" / "Meaning", or
/// "Masculine" / "Feminine").
class WordGroup {
  final String id;
  final String title;
  final String tamilTitle;
  final String leftLabel;
  final String rightLabel;
  final String emoji;
  final List<WordPair> pairs;
  const WordGroup({
    required this.id,
    required this.title,
    required this.tamilTitle,
    required this.leftLabel,
    required this.rightLabel,
    required this.emoji,
    required this.pairs,
  });
}

/// A pair of easily-confused ("troublesome") words with a short
/// explanation of the difference between them.
class ConfusablePair {
  final String wordA;
  final String wordB;
  final String explanation;
  final String tamilExplanation;
  const ConfusablePair(this.wordA, this.wordB, this.explanation, this.tamilExplanation);
}

/// A group of words that share a pronunciation feature — either "how many
/// syllables" or "this letter is silent/pronounced a certain way".
class PronunciationGroup {
  final String title;
  final String tamilTitle;
  final String rule;
  final String tamilRule;
  final List<String> words;
  const PronunciationGroup({
    required this.title,
    required this.tamilTitle,
    this.rule = "",
    this.tamilRule = "",
    required this.words,
  });
}

/// A multiple-choice question (used for the synonym and antonym drills).
class McqQuestion {
  final String prompt;
  final String tamilPrompt;
  final List<String> options;
  final int correctIndex;
  const McqQuestion({
    required this.prompt,
    required this.tamilPrompt,
    required this.options,
    required this.correctIndex,
  });
}

/// "Spot the odd word out" — four of the five words share something, one
/// doesn't.
class OddOneOut {
  final List<String> words;
  final int oddIndex;
  final String reason;
  final String tamilReason;
  const OddOneOut({
    required this.words,
    required this.oddIndex,
    required this.reason,
    required this.tamilReason,
  });
}

/// Jumbled/scrambled letters that unscramble to one word, with a clue.
class AnagramItem {
  final String scrambled;
  final String clue;
  final String tamilClue;
  final String answer;
  const AnagramItem({
    required this.scrambled,
    required this.clue,
    required this.tamilClue,
    required this.answer,
  });
}

/// One "connect the theme" item from the LEMONADE vocabulary test: a set
/// of clue words that all relate to one hidden answer.
class ThemeQuizItem {
  final List<String> clues;
  final String answer;
  final String tamilAnswer;
  const ThemeQuizItem({required this.clues, required this.answer, required this.tamilAnswer});
}

/// A stand-alone puzzle shown for reference (the missing-letters grid, the
/// 26-letter crossword, the bottle-contents riddle) — some of these have a
/// confirmed answer from the book, some don't.
class PuzzleReference {
  final String title;
  final String tamilTitle;
  final String description;
  final String tamilDescription;
  final String? solution;
  final String? tamilSolution;
  /// Optional bundled illustration (e.g. the bottle-puzzle picture),
  /// shown above the description when present.
  final String? imageAsset;
  const PuzzleReference({
    required this.title,
    required this.tamilTitle,
    required this.description,
    required this.tamilDescription,
    this.solution,
    this.tamilSolution,
    this.imageAsset,
  });
}
