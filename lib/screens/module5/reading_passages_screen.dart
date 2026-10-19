import 'package:flutter/material.dart';
import '../../data/composition_content.dart';
import '../../services/student_mic.dart';
import '../../services/teacher_tts.dart';
import '../../theme/app_theme.dart';
import '../../widgets/speak_and_practice_bar.dart';
import '../../widgets/synced_read_aloud.dart';
import '../../widgets/tts_speaker_button.dart';

/// "Improve Your Reading Skill" — all 5 passages shown in full, one
/// after another, since the book's own instruction is simply to read
/// them aloud (with the teacher's guidance on pronunciation) rather
/// than answer questions on them. Each passage now has a Listen/Say-it
/// bar for exactly that — hear the Teacher read it, then try reading it
/// aloud yourself and get a score — which is the single screen this
/// whole "read aloud" instruction was asking for.
class ReadingPassagesScreen extends StatefulWidget {
  const ReadingPassagesScreen({super.key});

  @override
  State<ReadingPassagesScreen> createState() => _ReadingPassagesScreenState();
}

class _ReadingPassagesScreenState extends State<ReadingPassagesScreen> {
  @override
  void dispose() {
    TeacherTts.instance.stop();
    StudentMic.instance.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: const EdgeInsets.fromLTRB(12, 16, 18, 18),
              decoration: const BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(24), bottomRight: Radius.circular(24)),
              ),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: const Icon(Icons.arrow_back, color: Colors.white),
                    style: IconButton.styleFrom(backgroundColor: Colors.white24, shape: const CircleBorder()),
                  ),
                  const SizedBox(width: 8),
                  const Expanded(
                    child: Text("Improve Your Reading Skill", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 16)),
                  ),
                  const Text("📖", style: TextStyle(fontSize: 26)),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(18),
                itemCount: readingPassages.length,
                itemBuilder: (context, i) {
                  final p = readingPassages[i];
                  return Container(
                    margin: const EdgeInsets.only(bottom: 16),
                    padding: const EdgeInsets.all(16),
                    decoration: cardDecoration(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(p.emoji, style: const TextStyle(fontSize: 22)),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text("${i + 1}. ${p.title}", style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w800)),
                            ),
                          ],
                        ),
                        if (p.byline.isNotEmpty)
                          Padding(
                            padding: const EdgeInsets.only(top: 2, left: 30),
                            child: Text(p.byline, style: const TextStyle(fontSize: 12, fontStyle: FontStyle.italic, color: AppColors.inkSoft)),
                          ),
                        if (p.tamilTitle.isNotEmpty)
                          Padding(
                            padding: const EdgeInsets.only(top: 2, left: 30),
                            child: Text(p.tamilTitle, style: const TextStyle(fontSize: 12.5, color: AppColors.inkSoft, fontWeight: FontWeight.w600)),
                          ),
                        const SizedBox(height: 10),
                        if (p.tamilPassage.isNotEmpty)
                          // Press play to hear the passage read aloud in
                          // English, with the Tamil meaning of whichever
                          // sentence is currently being spoken shown as a
                          // live caption right below it — like subtitles
                          // on a video, per the client's request.
                          SyncedReadAloud(english: p.passage, tamil: p.tamilPassage)
                        else
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(child: Text(p.passage, style: const TextStyle(fontSize: 13.5, height: 1.5))),
                              const SizedBox(width: 6),
                              TtsSpeakerButton(text: p.passage),
                            ],
                          ),
                        if (p.tamilPassage.isNotEmpty)
                          Padding(
                            padding: const EdgeInsets.only(top: 6),
                            child: Row(
                              children: [
                                const Icon(Icons.translate, size: 14, color: AppColors.inkSoft),
                                const SizedBox(width: 6),
                                const Expanded(
                                  child: Text("Listen to the full Tamil translation",
                                      style: TextStyle(fontSize: 11.5, color: AppColors.inkSoft)),
                                ),
                                TtsSpeakerButton(text: p.tamilPassage, tamil: true),
                              ],
                            ),
                          ),
                        const SizedBox(height: 12),
                        SpeakAndPracticeBar(text: p.passage),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
