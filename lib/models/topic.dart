import 'package:flutter/material.dart';

enum TopicType { dialogue, reading, freePractice }

class ConversationTurn {
  final bool isTeacher; // true = teacher line (played), false = student line (scored)
  final String line;
  // Tamil meaning of [line], shown under the English text so the student
  // can follow what's being said. Empty string = no translation supplied.
  final String tamil;
  const ConversationTurn({required this.isTeacher, required this.line, this.tamil = ""});
}

/// A single free-practice challenge prompt. [sample] is an optional
/// worked-example dialogue — straight from the course book — that the
/// student can listen to for guidance before attempting the challenge
/// themselves. It's empty for prompts that are descriptive/monologue
/// tasks (e.g. "describe your city") rather than a two-person dialogue.
class PracticePrompt {
  final String text;
  final String tamil; // Tamil meaning of [text].
  final List<ConversationTurn> sample;
  const PracticePrompt({required this.text, this.tamil = "", this.sample = const []});
}

class Topic {
  final String id;
  final String emoji;
  final Color color;
  final String title;
  final List<String> teacherIntro;
  // Tamil meaning for each line in [teacherIntro], same order/length.
  final List<String> teacherIntroTamil;
  final List<String> repeatLines;
  // Tamil meaning for each line in [repeatLines], same order/length.
  final List<String> repeatLinesTamil;
  final TopicType type;
  final List<ConversationTurn> conversation;
  final String passage;
  final String passageTamil;
  final List<PracticePrompt> prompts;

  const Topic({
    required this.id,
    required this.emoji,
    required this.color,
    required this.title,
    this.teacherIntro = const [],
    this.teacherIntroTamil = const [],
    this.repeatLines = const [],
    this.repeatLinesTamil = const [],
    this.type = TopicType.dialogue,
    this.conversation = const [],
    this.passage = "",
    this.passageTamil = "",
    this.prompts = const [],
  });

  /// Safe lookup — returns "" instead of throwing if the Tamil list is
  /// shorter than the English one (e.g. a line added without its pair).
  String teacherIntroTamilAt(int i) => i >= 0 && i < teacherIntroTamil.length ? teacherIntroTamil[i] : "";
  String repeatLineTamilAt(int i) => i >= 0 && i < repeatLinesTamil.length ? repeatLinesTamil[i] : "";
}
