// Data models for Module 4 (Comprehension). The book gives six short
// reading passages (simple narrative stories), each followed by five
// open-ended questions — "Why did...", "What had happened...", "Suggest
// a title" etc. The book itself gives no answer key for any of these
// (unlike, say, Module 3's Noun Clause exercise), so each question's
// `answer` below is a short model answer written from the passage, shown
// through the same think-first-then-reveal interaction already used for
// Module 3's fill exercises.
//
// Tamil coverage: each passage gets a short Tamil summary (the gist of
// the story, not a line-by-line translation — same approach as Module
// 3's topic/point Tamil notes) rather than a Tamil translation of the
// full English passage or of all thirty answers, which would be a wall
// of text without helping a student who can already read the short
// story in English alongside a Tamil summary of what happens in it.

class ComprehensionQuestion {
  final String prompt;
  final String answer;
  const ComprehensionQuestion({required this.prompt, required this.answer});
}

/// One reading passage plus its five comprehension questions.
class ComprehensionPassage {
  final String id;
  final String title;
  final String tamilTitle;
  final String emoji;
  final String passage;
  final String tamilSummary;
  final List<ComprehensionQuestion> questions;
  const ComprehensionPassage({
    required this.id,
    required this.title,
    required this.tamilTitle,
    required this.emoji,
    required this.passage,
    required this.tamilSummary,
    required this.questions,
  });
}
