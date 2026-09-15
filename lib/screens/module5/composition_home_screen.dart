import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import 'reading_passages_screen.dart';
import 'model_letters_screen.dart';
import 'developing_hints_screen.dart';

/// Module 5 · Composition — home screen. Three sections from the book's
/// final chapters: passages to read aloud, model official letters, and
/// story-writing hints.
class CompositionHomeScreen extends StatelessWidget {
  const CompositionHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: const EdgeInsets.fromLTRB(12, 16, 18, 22),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [AppColors.primary, Color(0xFF8B7CF6)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(28), bottomRight: Radius.circular(28)),
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
                      const Text("✍️", style: TextStyle(fontSize: 24)),
                      const SizedBox(width: 8),
                      const Text("Module 5 · Composition",
                          style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w800)),
                    ],
                  ),
                  const SizedBox(height: 8),
                  const Padding(
                    padding: EdgeInsets.only(left: 44),
                    child: Text("Reading practice, official letters, and story writing",
                        style: TextStyle(color: Colors.white70, fontSize: 12.5)),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(18),
                children: [
                  _SectionTile(
                    emoji: "📖",
                    title: "Improve Your Reading Skill",
                    subtitle: "5 passages to read aloud, fully translated in Tamil too",
                    color: const Color(0xFF3B82F6),
                    onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => const ReadingPassagesScreen())),
                  ),
                  const SizedBox(height: 12),
                  _SectionTile(
                    emoji: "📄",
                    title: "Model Letters",
                    subtitle: "Format checklist + 2 sample official letters",
                    color: const Color(0xFF10B981),
                    onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => const ModelLettersScreen())),
                  ),
                  const SizedBox(height: 12),
                  _SectionTile(
                    emoji: "📝",
                    title: "Developing Hints",
                    subtitle: "5 hints to develop into stories, with a sample story each",
                    color: const Color(0xFFF59E0B),
                    onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => const DevelopingHintsScreen())),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SectionTile extends StatelessWidget {
  final String emoji;
  final String title;
  final String subtitle;
  final Color color;
  final VoidCallback onTap;
  const _SectionTile({required this.emoji, required this.title, required this.subtitle, required this.color, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(20),
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(18),
        decoration: cardDecoration(borderTop: color),
        child: Row(
          children: [
            Container(
              width: 54,
              height: 54,
              decoration: BoxDecoration(color: color.withOpacity(0.12), borderRadius: BorderRadius.circular(16)),
              alignment: Alignment.center,
              child: Text(emoji, style: const TextStyle(fontSize: 28)),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w800, color: AppColors.ink)),
                  const SizedBox(height: 4),
                  Text(subtitle, style: const TextStyle(fontSize: 12.5, color: AppColors.inkSoft, height: 1.35)),
                ],
              ),
            ),
            const Icon(Icons.chevron_right, color: AppColors.inkSoft),
          ],
        ),
      ),
    );
  }
}
