import 'package:flutter/material.dart';
import '../../data/comprehension_content.dart';
import '../../theme/app_theme.dart';
import 'comprehension_passage_screen.dart';

/// Module 4 · Comprehension — home screen. Lists the six short reading
/// passages from the book, each opening its own screen with the passage
/// text followed by its five comprehension questions.
class ComprehensionHomeScreen extends StatelessWidget {
  const ComprehensionHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Container(
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
                        const Text("📚", style: TextStyle(fontSize: 24)),
                        const SizedBox(width: 8),
                        const Text("Module 4 · Comprehension",
                            style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w800)),
                      ],
                    ),
                    const SizedBox(height: 8),
                    const Padding(
                      padding: EdgeInsets.only(left: 44),
                      child: Text("Read short stories and answer questions — fully in Tamil too",
                          style: TextStyle(color: Colors.white70, fontSize: 12.5)),
                    ),
                  ],
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(18, 18, 18, 6),
              sliver: SliverToBoxAdapter(
                child: Text("Passages", style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w800, color: AppColors.inkSoft, letterSpacing: 0.5)),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(18, 0, 18, 30),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, i) {
                    final p = comprehensionPassages[i];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: _SectionTile(
                        emoji: p.emoji,
                        title: "${i + 1}. ${p.title}",
                        subtitle: p.tamilTitle.isNotEmpty ? p.tamilTitle : "${p.questions.length} questions",
                        onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => ComprehensionPassageScreen(passage: p))),
                      ),
                    );
                  },
                  childCount: comprehensionPassages.length,
                ),
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
  final VoidCallback onTap;
  const _SectionTile({required this.emoji, required this.title, required this.subtitle, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: cardDecoration(),
        child: Row(
          children: [
            Text(emoji, style: const TextStyle(fontSize: 26)),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: const TextStyle(fontSize: 14.5, fontWeight: FontWeight.w800)),
                  Text(subtitle, style: const TextStyle(fontSize: 12, color: AppColors.inkSoft)),
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
