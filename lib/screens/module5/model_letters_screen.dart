import 'package:flutter/material.dart';
import '../../data/composition_content.dart';
import '../../services/student_mic.dart';
import '../../services/teacher_tts.dart';
import '../../theme/app_theme.dart';
import '../../widgets/speak_and_practice_bar.dart';
import '../../widgets/tts_speaker_button.dart';
import '../../widgets/synced_read_aloud.dart';

/// "Model Letters — Requisitions": the book's 8-point format checklist,
/// followed by its two model official letters — each with a Listen/
/// Say-it bar so a student can hear the whole letter read aloud and
/// practice reading it back.
class ModelLettersScreen extends StatefulWidget {
  const ModelLettersScreen({super.key});

  @override
  State<ModelLettersScreen> createState() => _ModelLettersScreenState();
}

class _ModelLettersScreenState extends State<ModelLettersScreen> {
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
                    child: Text("Model Letters", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 16)),
                  ),
                  const Text("📄", style: TextStyle(fontSize: 26)),
                ],
              ),
            ),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(18),
                children: [
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: cardDecoration(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("Requisitions", style: TextStyle(fontSize: 15, fontWeight: FontWeight.w800)),
                        const SizedBox(height: 8),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(child: Text(letterWritingIntro, style: const TextStyle(fontSize: 13.5, height: 1.45))),
                            const SizedBox(width: 6),
                            TtsSpeakerButton(text: letterWritingIntro),
                          ],
                        ),
                        if (letterWritingTamilIntro.isNotEmpty)
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(child: tamilMeaning(letterWritingTamilIntro, topGap: 8)),
                              const SizedBox(width: 6),
                              TtsSpeakerButton(text: letterWritingTamilIntro, tamil: true),
                            ],
                          ),
                        const SizedBox(height: 10),
                        SpeakAndPracticeBar(text: letterWritingIntro),
                        const SizedBox(height: 12),
                        for (int i = 0; i < letterWritingTips.length; i++)
                          Padding(
                            padding: const EdgeInsets.only(bottom: 8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("${i + 1}. ${letterWritingTips[i]}", style: const TextStyle(fontSize: 13.5, height: 1.4)),
                                if (i < letterWritingTamilTips.length && letterWritingTamilTips[i].isNotEmpty)
                                  Padding(
                                    padding: const EdgeInsets.only(top: 2, left: 4),
                                    child: Text(letterWritingTamilTips[i], style: const TextStyle(fontSize: 12, color: AppColors.inkSoft)),
                                  ),
                              ],
                            ),
                          ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 18),
                  const Text("Sample Letters", style: TextStyle(fontSize: 13, fontWeight: FontWeight.w800, color: AppColors.inkSoft, letterSpacing: 0.5)),
                  const SizedBox(height: 10),
                  for (final letter in modelLetters)
                    Container(
                      margin: const EdgeInsets.only(bottom: 16),
                      padding: const EdgeInsets.all(16),
                      decoration: cardDecoration(),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(letter.emoji, style: const TextStyle(fontSize: 20)),
                              const SizedBox(width: 8),
                              Expanded(child: Text(letter.title, style: const TextStyle(fontSize: 14.5, fontWeight: FontWeight.w800))),
                            ],
                          ),
                          if (letter.tamilTitle.isNotEmpty)
                            Padding(
                              padding: const EdgeInsets.only(top: 2, left: 28),
                              child: Text(letter.tamilTitle, style: const TextStyle(fontSize: 12, color: AppColors.inkSoft)),
                            ),
                          const Divider(height: 24),
                          Text(letter.dateLine, style: const TextStyle(fontSize: 12.5, color: AppColors.inkSoft)),
                          const SizedBox(height: 10),
                          const Text("From: (your address)", style: TextStyle(fontSize: 12.5, fontStyle: FontStyle.italic, color: AppColors.inkSoft)),
                          const SizedBox(height: 4),
                          const Text("To: (the concerned official's address)", style: TextStyle(fontSize: 12.5, fontStyle: FontStyle.italic, color: AppColors.inkSoft)),
                          const SizedBox(height: 12),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(child: Text(letter.subject, style: const TextStyle(fontSize: 13.5, fontWeight: FontWeight.w700))),
                              const SizedBox(width: 6),
                              TtsSpeakerButton(text: "${letter.subject}. ${letter.body.join(' ')}"),
                            ],
                          ),
                          if (letter.tamilSubject.isNotEmpty)
                            Padding(
                              padding: const EdgeInsets.only(top: 2),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(child: Text(letter.tamilSubject, style: const TextStyle(fontSize: 12, color: AppColors.inkSoft))),
                                  const SizedBox(width: 6),
                                  TtsSpeakerButton(
                                    text: "${letter.tamilSubject}. ${letter.tamilBody.join(' ')}",
                                    tamil: true,
                                  ),
                                ],
                              ),
                            ),
                          const SizedBox(height: 12),
                          if (letter.tamilBody.isNotEmpty)
                            SyncedReadAloud(english: letter.body.join(' '), tamil: letter.tamilBody.join(' '))
                          else
                            for (int i = 0; i < letter.body.length; i++)
                              Padding(
                                padding: const EdgeInsets.only(bottom: 10),
                                child: Text(letter.body[i], style: const TextStyle(fontSize: 13.5, height: 1.5)),
                              ),
                          const SizedBox(height: 4),
                          SpeakAndPracticeBar(text: "${letter.subject}. ${letter.body.join(' ')}"),
                        ],
                      ),
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
