import 'package:flutter/material.dart';
import '../data/content.dart';
import '../models/topic.dart';
import '../services/progress_store.dart';
import '../services/student_mic.dart';
import '../theme/app_theme.dart';
import 'teach_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Map<String, TopicProgress> _progress = {};
  bool _loaded = false;

  @override
  void initState() {
    super.initState();
    _refresh();
    // Pre-warm the offline voice-recognition model in the background as
    // soon as the app opens. It's a one-time ~40MB unzip-and-load the
    // first time — doing it now (while the student is just browsing
    // topics) means it's usually already done by the time they reach
    // "Your turn", instead of that slow first-time load happening right
    // when they're waiting to be heard.
    // ignore: unawaited_futures
    StudentMic.instance.init();
  }

  Future<void> _refresh() async {
    final p = await ProgressStore.load();
    if (!mounted) return;
    setState(() {
      _progress = p;
      _loaded = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    final topics = module1Topics;
    final totalStars = topics.fold<int>(0, (sum, t) => sum + (_progress[t.id]?.stars ?? 0));
    final maxStars = topics.length * 3;

    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(child: _Header(totalStars: totalStars, maxStars: maxStars)),
            SliverPadding(
              padding: const EdgeInsets.all(16),
              sliver: SliverGrid(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 14,
                  crossAxisSpacing: 14,
                  childAspectRatio: 0.92,
                ),
                delegate: SliverChildBuilderDelegate(
                  (context, i) => _TopicCard(
                    topic: topics[i],
                    index: i,
                    progress: _progress[topics[i].id],
                    onTap: () async {
                      await Navigator.of(context).push(
                        MaterialPageRoute(builder: (_) => TeachScreen(topic: topics[i])),
                      );
                      _refresh();
                    },
                  ),
                  childCount: topics.length,
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: Center(
                  child: Text("Module 1 · Conversation — ${topics.length} topics",
                      style: const TextStyle(color: AppColors.inkSoft, fontSize: 12.5)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  final int totalStars;
  final int maxStars;
  const _Header({required this.totalStars, required this.maxStars});

  @override
  Widget build(BuildContext context) {
    final ratio = maxStars == 0 ? 0.0 : totalStars / maxStars;
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 24),
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
            children: const [
              Text("🗣️", style: TextStyle(fontSize: 24)),
              SizedBox(width: 8),
              Text("SpeakRight",
                  style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.w800)),
            ],
          ),
          const SizedBox(height: 8),
          const Text("Learn to speak English with your Teacher — 100% offline",
              style: TextStyle(color: Colors.white70, fontSize: 14)),
          const SizedBox(height: 16),
          ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: LinearProgressIndicator(
              value: ratio,
              minHeight: 10,
              backgroundColor: Colors.white.withOpacity(0.3),
              valueColor: const AlwaysStoppedAnimation(Color(0xFFFFD166)),
            ),
          ),
          const SizedBox(height: 6),
          Text("$totalStars / $maxStars ⭐ earned",
              style: const TextStyle(color: Colors.white, fontSize: 12.5, fontWeight: FontWeight.w700)),
        ],
      ),
    );
  }
}

class _TopicCard extends StatelessWidget {
  final Topic topic;
  final int index;
  final TopicProgress? progress;
  final VoidCallback onTap;
  const _TopicCard({required this.topic, required this.index, required this.progress, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final stars = progress?.stars ?? 0;
    return InkWell(
      borderRadius: BorderRadius.circular(18),
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: cardDecoration(borderTop: topic.color),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(topic.emoji, style: const TextStyle(fontSize: 28)),
                const SizedBox(height: 8),
                Text("TOPIC ${index + 1}",
                    style: const TextStyle(
                        fontSize: 10.5, fontWeight: FontWeight.w800, color: AppColors.inkSoft, letterSpacing: 0.5)),
                const SizedBox(height: 2),
                Expanded(
                  child: Text(
                    topic.title,
                    style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700, height: 1.2),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Text(
                  "★★★".substring(0, stars) + "☆☆☆".substring(0, 3 - stars),
                  style: const TextStyle(color: AppColors.gold, fontSize: 14, letterSpacing: 2),
                ),
              ],
            ),
            if (progress?.completed == true)
              Positioned(
                top: 0,
                right: 0,
                child: Container(
                  width: 22,
                  height: 22,
                  decoration: const BoxDecoration(color: AppColors.success, shape: BoxShape.circle),
                  child: const Icon(Icons.check, color: Colors.white, size: 14),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
