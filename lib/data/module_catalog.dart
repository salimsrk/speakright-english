import 'package:flutter/material.dart';
import 'content.dart';
import 'vocab_content.dart';
import 'grammar_content.dart';
import 'comprehension_content.dart';

/// Static per-module metadata used by the Home/Lessons/Progress tabs —
/// one place that knows each module's display info and how many
/// "lessons" it has (in the sense LessonProgressStore / ProgressStore
/// track completion), computed from the real content lists rather than
/// hardcoded, so the counts can never drift out of sync with the book
/// content as it's edited.
class ModuleCatalogEntry {
  final String id;
  final String emoji;
  final String title;
  final String subtitle;
  final Color color;
  final int totalLessons;
  const ModuleCatalogEntry({
    required this.id,
    required this.emoji,
    required this.title,
    required this.subtitle,
    required this.color,
    required this.totalLessons,
  });
}

/// Module 2's lesson IDs, in the same order its home screen lists them —
/// used both to count totalLessons and to mark/check "viewed" state.
/// Keep this in sync with VocabHomeScreen's tile list.
List<String> module2LessonIds() => [
      for (int i = 0; i < allWordGroups.length; i++) "m2:group:$i",
      "m2:confusables",
      "m2:pronunciation",
      "m2:funwithwords",
    ];

/// Keep in sync with GrammarHomeScreen's tile list.
List<String> module3LessonIds() => [
      for (int i = 0; i < grammarTopics.length; i++) "m3:topic:$i",
    ];

/// Keep in sync with ComprehensionHomeScreen's tile list.
List<String> module4LessonIds() => [
      for (int i = 0; i < comprehensionPassages.length; i++) "m4:passage:$i",
    ];

/// Keep in sync with CompositionHomeScreen's three section tiles.
List<String> module5LessonIds() => const ["m5:reading", "m5:letters", "m5:hints"];

final List<ModuleCatalogEntry> moduleCatalog = [
  ModuleCatalogEntry(
    id: "module1",
    emoji: "💬",
    title: "Module 1 · Conversation",
    subtitle: "Greetings, everyday talk, reading passages — speak and get scored.",
    color: const Color(0xFFFF6B6B),
    totalLessons: module1Topics.length,
  ),
  ModuleCatalogEntry(
    id: "module2",
    emoji: "📖",
    title: "Module 2 · Vocabulary",
    subtitle: "Word lists, idioms, pronunciation rules, gender, sounds & fun word puzzles.",
    color: const Color(0xFF3B82F6),
    totalLessons: module2LessonIds().length,
  ),
  ModuleCatalogEntry(
    id: "module3",
    emoji: "📝",
    title: "Module 3 · Grammar",
    subtitle: "Sentences, parts of speech, tenses, voice, prepositions & more.",
    color: const Color(0xFF10B981),
    totalLessons: module3LessonIds().length,
  ),
  ModuleCatalogEntry(
    id: "module4",
    emoji: "📚",
    title: "Module 4 · Comprehension",
    subtitle: "Short stories to read, with questions to check your understanding.",
    color: const Color(0xFFF59E0B),
    totalLessons: module4LessonIds().length,
  ),
  ModuleCatalogEntry(
    id: "module5",
    emoji: "✍️",
    title: "Module 5 · Composition",
    subtitle: "Reading practice, official letters, and story writing.",
    color: const Color(0xFF8B5CF6),
    totalLessons: module5LessonIds().length,
  ),
];
