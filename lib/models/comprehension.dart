// Data models for Module 4 (Comprehension). The book gives six short
// reading passages (simple narrative stories), each followed by five
// open-ended questions — "Why did...", "What had happened...", "Suggest
// a title" etc. The book itself gives no answer key for any of these
// (unlike, say, Module 3's Noun Clause exercise), so each question's
// `answer` below is a short model answer written from the passage, shown
// through the same think-first-then-reveal interaction already used for
// Module 3's fill exercises.
//
// Tamil coverage: every passage carries a full Tamil translation
// (`tamilPassage`, not just a gist), and every question and its model
// answer carry their own Tamil translation (`tamilPrompt`/`tamilAnswer`)
// so a student can follow the story and the questions/answers entirely
// in Tamil if English alone isn't enough, not just read an English wall
// of text with a short Tamil note on top.

class ComprehensionQuestion {
  final String prompt;
  final String tamilPrompt;
  final String answer;
  final String tamilAnswer;
  const ComprehensionQuestion({
    required this.prompt,
    this.tamilPrompt = "",
    required this.answer,
    this.tamilAnswer = "",
  });
}

/// One reading passage plus its five comprehension questions.
class ComprehensionPassage {
  final String id;
  final String title;
  final String tamilTitle;
  final String emoji;
  final String passage;
  final String tamilPassage;
  final List<ComprehensionQuestion> questions;
  const ComprehensionPassage({
    required this.id,
    required this.title,
    required this.tamilTitle,
    required this.emoji,
    required this.passage,
    required this.tamilPassage,
    required this.questions,
  });
}
