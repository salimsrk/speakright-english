import 'package:flutter/material.dart';
import '../../data/vocab_content.dart';
import '../../models/vocab.dart';
import '../../services/teacher_tts.dart';
import '../../theme/app_theme.dart';

/// Shows the two pronunciation sections from the book: how many syllables
/// a word has, and which letters go silent (or change sound) in common
/// words. Each group gets one Tamil rule-note (there's no per-word
/// "meaning" to translate here — the point is pronunciation).
class PronunciationScreen extends StatelessWidget {
  const PronunciationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                padding: const EdgeInsets.fromLTRB(12, 16, 18, 0),
                decoration: const BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.only(bottomLeft: Radius.circular(24), bottomRight: Radius.circular(24)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        IconButton(
                          onPressed: () => Navigator.of(context).pop(),
                          icon: const Icon(Icons.arrow_back, color: Colors.white),
                          style: IconButton.styleFrom(backgroundColor: Colors.white24, shape: const CircleBorder()),
                        ),
                        const SizedBox(width: 8),
                        const Expanded(
                          child: Text("Pronunciation & Syllables",
                              style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 16)),
                        ),
                        const Text("🔤", style: TextStyle(fontSize: 26)),
                      ],
                    ),
                    const SizedBox(height: 12),
                    const TabBar(
                      indicatorColor: Colors.white,
                      labelColor: Colors.white,
                      unselectedLabelColor: Colors.white60,
                      tabs: [
                        Tab(text: "Syllables"),
                        Tab(text: "Silent Letters"),
                      ],
                    ),
                  ],
                ),
              ),
              Expanded(
                child: TabBarView(
                  children: [
                    _GroupList(groups: syllableGroups),
                    _GroupList(groups: silentLetterGroups),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _GroupList extends StatelessWidget {
  final List<PronunciationGroup> groups;
  const _GroupList({required this.groups});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(18),
      itemCount: groups.length,
      itemBuilder: (context, i) {
        final g = groups[i];
        return Container(
          margin: const EdgeInsets.only(bottom: 14),
          padding: const EdgeInsets.all(16),
          decoration: cardDecoration(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(g.title, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w800, color: AppColors.ink)),
                  ),
                  IconButton(
                    onPressed: () => TeacherTts.instance.speak(g.words.join(", ")),
                    icon: const Icon(Icons.volume_up, color: AppColors.primary),
                  ),
                ],
              ),
              Text(g.tamilTitle, style: const TextStyle(fontSize: 12.5, color: AppColors.inkSoft, fontWeight: FontWeight.w600)),
              if (g.rule.isNotEmpty) ...[
                const SizedBox(height: 8),
                Text(g.rule, style: const TextStyle(fontSize: 13, height: 1.4)),
              ],
              if (g.tamilRule.isNotEmpty) tamilMeaning(g.tamilRule, topGap: 6),
              const SizedBox(height: 10),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: g.words
                    .map((w) => Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                          decoration: BoxDecoration(color: AppColors.bg, borderRadius: BorderRadius.circular(10)),
                          child: Text(w, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
                        ))
                    .toList(),
              ),
            ],
          ),
        );
      },
    );
  }
}
