// Data models for Module 3 (Grammar). Kept separate from vocab.dart since
// grammar content is shaped differently: it's mostly short rule
// explanations followed by example sentences, plus a series of fill-in /
// choose-the-correct-form exercises, rather than word-pair tables.
//
// Note on Tamil coverage: every topic, and every kind/rule inside a topic,
// carries a Tamil heading and a short Tamil explanation — exactly like
// Module 2's PronunciationGroup (one Tamil rule note covering a whole word
// list, not a translation of every single example). Translating each of
// the many hundreds of individual example sentences below into Tamil
// would add translation noise without helping a student who already reads
// the short English examples aside a Tamil rule summary, so examples stay
// English-only, same as the book itself presents them.

import 'vocab.dart' show McqQuestion;

/// One short "rule card" inside a grammar topic — e.g. one kind of noun,
/// one kind of adjective, one tense, one voice-transformation group. Shown
/// as a heading + explanation + a bulleted list of example sentences.
class GrammarPoint {
  final String heading;
  final String tamilHeading;
  final String explanation;
  final String tamilExplanation;
  final List<String> examples;
  const GrammarPoint({
    required this.heading,
    this.tamilHeading = "",
    this.explanation = "",
    this.tamilExplanation = "",
    this.examples = const [],
  });
}

/// One full grammar topic's explanation screen — an intro plus a series of
/// GrammarPoints (the topic's "kinds"/rules). Exercises for the topic are
/// kept in their own separate lists (see grammar_content.dart) so each can
/// use whichever interaction (pick-then-reveal MCQ, or think-then-reveal
/// fill-in) actually fits that exercise.
class GrammarTopic {
  final String id;
  final String title;
  final String tamilTitle;
  final String emoji;
  final String intro;
  final String tamilIntro;
  final List<GrammarPoint> points;
  // Practice tied to this topic, shown as buttons at the bottom of its
  // explanation screen. Most topics have zero or one of these; a couple
  // (Noun) end up with just the fill set, others (Noun Number, Tenses) use
  // the MCQ instead. Kept optional/empty so plain explanation-only topics
  // (Parts of Speech, Sequence of Tenses, Adverb) need neither.
  final List<GrammarFillSet> fillSets;
  final McqPractice? mcq;
  const GrammarTopic({
    required this.id,
    required this.title,
    required this.tamilTitle,
    required this.emoji,
    this.intro = "",
    this.tamilIntro = "",
    this.points = const [],
    this.fillSets = const [],
    this.mcq,
  });
}

/// A multiple-choice practice drill tied to one topic (e.g. Noun Number's
/// 10-item singular/plural agreement quiz, Tenses' 32-item quiz). Reuses
/// Module 2's existing McqScreen + McqQuestion as-is.
class McqPractice {
  final String title;
  final String tamilTitle;
  final List<McqQuestion> questions;
  const McqPractice({required this.title, required this.tamilTitle, required this.questions});
}

/// A "think first, then reveal" exercise item with one free-form correct
/// answer — used for every Module 3 exercise that isn't a simple two-way
/// choice (word formation, verb agreement, voice change, prepositions,
/// articles, question tags, noun pairs). Reuses the exact interaction
/// Module 2 already established for jumbled words / puzzle references.
class GrammarFillItem {
  final String prompt;
  final String answer;
  final String tamilHint;
  const GrammarFillItem({required this.prompt, required this.answer, this.tamilHint = ""});
}

/// A named, emoji-tagged group of GrammarFillItems — one exercise, shown
/// on its own screen (e.g. "Noun Pairs", "Verb Agreement", "Prepositions").
class GrammarFillSet {
  final String id;
  final String title;
  final String tamilTitle;
  final String emoji;
  final String instructions;
  final String tamilInstructions;
  final List<GrammarFillItem> items;
  const GrammarFillSet({
    required this.id,
    required this.title,
    required this.tamilTitle,
    required this.emoji,
    this.instructions = "",
    this.tamilInstructions = "",
    required this.items,
  });
}
