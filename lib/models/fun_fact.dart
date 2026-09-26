/// A single bilingual "Did you know?" fact shown after a student finishes
/// an exercise or topic, so practice feels a little lighter and less
/// repetitive — matching the app's existing convention of pairing every
/// piece of English text with a Tamil translation.
class FunFact {
  final String emoji;
  final String fact;
  final String tamilFact;
  const FunFact({required this.emoji, required this.fact, required this.tamilFact});
}
