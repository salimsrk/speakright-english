import 'package:flutter/material.dart';

enum TopicType { dialogue, reading, freePractice }

class ConversationTurn {
  final bool isTeacher; // true = teacher line (played), false = student line (scored)
  final String line;
  const ConversationTurn({required this.isTeacher, required this.line});
}

class Topic {
  final String id;
  final String emoji;
  final Color color;
  final String title;
  final List<String> teacherIntro;
  final List<String> repeatLines;
  final TopicType type;
  final List<ConversationTurn> conversation;
  final String passage;
  final List<String> prompts;

  const Topic({
    required this.id,
    required this.emoji,
    required this.color,
    required this.title,
    this.teacherIntro = const [],
    this.repeatLines = const [],
    this.type = TopicType.dialogue,
    this.conversation = const [],
    this.passage = "",
    this.prompts = const [],
  });
}
