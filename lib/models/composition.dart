// Data models for Module 5 (Composition). The book's last section covers
// three different writing/reading skills: passages meant to be read
// aloud for fluency practice, model official letters with a format
// checklist, and short "hints" the student develops into a full story.
// None of these come with a book-given answer key (they're composition
// skills, not right/wrong exercises), so — same as Module 4 — anything
// beyond the book's own words (a sample story for a hint) is my own,
// written to model the skill, not a definitive answer.
//
// Tamil coverage: every passage has a full Tamil translation
// (`tamilPassage`), every model letter has a Tamil subject and Tamil
// body paragraphs, and every story hint has a Tamil translation of both
// its hint outline and its sample story — not just a Tamil title/gist —
// so a student can follow the actual content in Tamil, not only a short
// note about it.

/// A passage meant to be read aloud for fluency/pronunciation practice.
class ReadingPassage {
  final String title;
  final String tamilTitle;
  final String byline;
  final String emoji;
  final String passage;
  final String tamilPassage;
  const ReadingPassage({
    required this.title,
    this.tamilTitle = "",
    this.byline = "",
    required this.emoji,
    required this.passage,
    this.tamilPassage = "",
  });
}

/// A model official letter — subject line plus body paragraphs. The
/// book leaves "From" and "To" blank for the student to fill in their
/// own address and the addressee, so those aren't modelled here.
class ModelLetter {
  final String title;
  final String tamilTitle;
  final String emoji;
  final String dateLine;
  final String subject;
  final String tamilSubject;
  final List<String> body;
  final List<String> tamilBody;
  const ModelLetter({
    required this.title,
    this.tamilTitle = "",
    required this.emoji,
    required this.dateLine,
    required this.subject,
    this.tamilSubject = "",
    required this.body,
    this.tamilBody = const [],
  });
}

/// One "developing hints" prompt — the book's own hint outline, plus a
/// short sample story I've written from it (shown via reveal, same as
/// Module 4's model answers) to show one way of expanding it.
class StoryHint {
  final String title;
  final String tamilTitle;
  final String emoji;
  final String hint;
  final String tamilHint;
  final String sampleStory;
  final String tamilSampleStory;
  const StoryHint({
    required this.title,
    this.tamilTitle = "",
    required this.emoji,
    required this.hint,
    this.tamilHint = "",
    required this.sampleStory,
    this.tamilSampleStory = "",
  });
}
