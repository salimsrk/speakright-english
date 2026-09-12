import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import 'home_screen.dart';
import 'module2/vocab_home_screen.dart';

/// The very first screen the student sees: choose which Module to work
/// on. Module 1 (Conversation) is the original app; Module 2 (Vocabulary)
/// is the new one built from the course book's Module II content.
class ModuleSelectScreen extends StatelessWidget {
  const ModuleSelectScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                padding: const EdgeInsets.fromLTRB(24, 28, 24, 32),
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
                  children: const [
                    Row(
                      children: [
                        Text("🗣️", style: TextStyle(fontSize: 26)),
                        SizedBox(width: 8),
                        Text("SpeakRight",
                            style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.w800)),
                      ],
                    ),
                    SizedBox(height: 8),
                    Text("Learn to speak English with your Teacher — 100% offline",
                        style: TextStyle(color: Colors.white70, fontSize: 14)),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(18, 22, 18, 8),
                child: Text("Choose a Module", style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w800, color: AppColors.ink)),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18),
                child: _ModuleCard(
                  emoji: "💬",
                  title: "Module 1 · Conversation",
                  subtitle: "Greetings, everyday talk, reading passages — speak and get scored.",
                  color: const Color(0xFFFF6B6B),
                  onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => const HomeScreen())),
                ),
              ),
              const SizedBox(height: 14),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18),
                child: _ModuleCard(
                  emoji: "📖",
                  title: "Module 2 · Vocabulary",
                  subtitle: "Word lists, idioms, pronunciation rules, gender, sounds & fun word puzzles.",
                  color: const Color(0xFF3B82F6),
                  onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => const VocabHomeScreen())),
                ),
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}

class _ModuleCard extends StatelessWidget {
  final String emoji;
  final String title;
  final String subtitle;
  final Color color;
  final VoidCallback onTap;
  const _ModuleCard({
    required this.emoji,
    required this.title,
    required this.subtitle,
    required this.color,
    required this.onTap,
  });

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
                  Text(title, style: const TextStyle(fontSize: 15.5, fontWeight: FontWeight.w800, color: AppColors.ink)),
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
