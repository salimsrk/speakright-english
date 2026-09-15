// Module 4 · Comprehension — content, transcribed and cross-checked
// directly against the course book's page images (book pages 65-68,
// "MODULE - IV COMPREHENSION"). The module cleanly ends at page 68 —
// page 69 begins "MODULE - V COMPOSITION - A", which is out of scope
// here.
//
// Book-error corrections made while transcribing (each is a single
// obvious print/typing slip, not a rewrite of the story):
//  - Passage 1: joined a sentence fragment ("She agreed to pay a large
//    fee if she got cured. But nothing if the doctor failed...") with a
//    comma instead of a full stop; fixed "The judge asks the lady" to
//    "asked" to match the passage's past-tense narration.
//  - Passage 2: "it was ready to carry the crabs across the river" ->
//    "carry the jackal across the river" (the very next sentence says
//    "The camel carried the jackal on its back", confirming "crabs" is
//    a mistaken repeat of the earlier word, not what the book means).
//  - Passage 3: the book prints "A young mother with a baby was chosen
//    at his birth. A young mother with a baby was chosen as his nurse."
//    — a duplicated near-repeat of the same sentence. Kept the second,
//    complete version only. Also "flew with the real prince" -> "fled
//    with the real prince" (she is escaping, not literally flying).
//  - Passage 4: the book's closing line reads "Thus, the farmer had
//    over reached himself" — but it is the miser who lied about the
//    purse's contents and lost it as a result (confirmed by the two
//    preceding sentences: the judge decides the purse "could not be
//    the miser's" because of the miser's own false claim, and gives it
//    away). Corrected to "the miser had overreached himself" to match
//    the story's own logic.
// All other wording follows the book exactly, including its habit of
// starting a sentence with "But" and other informal touches.

import '../models/comprehension.dart';

final ComprehensionPassage _oldLadyPassage = ComprehensionPassage(
  id: "old_lady_doctor",
  title: "The Blind Lady and the Doctor",
  tamilTitle: "குருடான பெண்மணியும் மருத்துவரும்",
  emoji: "👵",
  passage:
      "Once there lived an old lady. She became blind. She called a doctor. "
      "She agreed to pay a large fee if she got cured, but nothing if the "
      "doctor failed in his duty. The doctor attended on her. He became "
      "greedy after the lady's furniture, and delayed the cure. Everyday he "
      "took away some of the furniture. At last he cured her. Then he "
      "demanded his fees. But she refused to pay him, saying that her cure "
      "was not complete. She brought a court charge on the doctor. The judge "
      "asked the lady why she would not pay the doctor. She said that her "
      "sight was not properly restored, as she could not see all her "
      "furniture. The judge gave a verdict in her favour.",
  tamilSummary:
      "குருடான ஒரு வயதான பெண்மணி மருத்துவரிடம் சிகிச்சை பெறுகிறாள். பேராசை கொண்ட "
      "மருத்துவர் அவளுடைய தளபாடங்களுக்காக சிகிச்சையை தாமதப்படுத்துகிறார். குணமான "
      "பின் அவர் கட்டணம் கேட்கும்போது, தன் பார்வை முழுமையாக குணமாகவில்லை (தன் "
      "தளபாடங்கள் அனைத்தையும் காண முடியவில்லை) என புத்திசாலித்தனமாக சொல்லி, "
      "பெண்மணி நீதிமன்றத்தில் வெல்கிறாள்.",
  questions: const [
    ComprehensionQuestion(prompt: "a) What had happened to the old lady?", answer: "She had become blind."),
    ComprehensionQuestion(
      prompt: "b) Why did the doctor delay the treatment?",
      answer: "He grew greedy for her furniture, so he kept delaying her cure while he took away a little of it every day.",
    ),
    ComprehensionQuestion(prompt: "c) What did he do in her home?", answer: "Every day, he took away some of her furniture."),
    ComprehensionQuestion(
      prompt: "d) Why did the lady file the case on the doctor?",
      answer: "Because once he finally cured her, he demanded his fees, but she refused to pay, saying her cure was not complete.",
    ),
    ComprehensionQuestion(prompt: "e) Suggest a suitable title", answer: "The Blind Lady and the Greedy Doctor"),
  ],
);

final ComprehensionPassage _jackalCamelPassage = ComprehensionPassage(
  id: "jackal_camel",
  title: "The Jackal and the Camel",
  tamilTitle: "நரியும் ஒட்டகமும்",
  emoji: "🐪",
  passage:
      "A jackal wanted to eat crabs found on the other side of a river. It "
      "wondered how to get across the river. It then approached a camel and "
      "persuaded the camel that there were a lot of sugarcane fields on the "
      "other side of the river. The camel became very eager to taste the "
      "sugarcane and was ready to carry the jackal across the river in "
      "return for the information it got from the jackal. The camel carried "
      "the jackal on its back and crossed the river. After having had its "
      "meal of crabs on the other side of the river, the jackal started "
      "howling. The jackal wanted to play a trick on the camel. The "
      "villagers rushed out of the place and saw the camel in the sugarcane "
      "field. They beat it with sticks, and the camel rushed to the river "
      "to save its skin. The jackal jumped on its back. While crossing, the "
      "camel asked the jackal why he played such a trick on him. The jackal "
      "replied that it was his habit to howl after a good meal. For this, "
      "the camel replied that it was his habit to take a bath after a good "
      "meal. Then he rolled in the river. The jackal was nearly drowned.",
  tamilSummary:
      "நண்டுகளை சாப்பிட நதியைக் கடக்க வேண்டிய ஒரு நரி, கரும்புக்காக ஆசைப்படும் "
      "ஒட்டகத்தை ஏமாற்றி நதியைக் கடக்கிறது. சாப்பிட்ட பிறகு நரி சத்தமாக ஊளையிட்டு, "
      "அதனால் ஊர்மக்கள் ஒட்டகத்தையே அடிக்கின்றனர். திரும்பும் வழியில் ஒட்டகம் நதியில் "
      "புரண்டு, தன் மீது இருந்த நரியை பழிவாங்குகிறது.",
  questions: const [
    ComprehensionQuestion(
      prompt: "1. Why did the jackal want to go to the other side of the river?",
      answer: "Because it wanted to eat the crabs found there.",
    ),
    ComprehensionQuestion(
      prompt: "2. What was the trick the jackal played on the camel?",
      answer: "After eating its fill, it started howling loudly, which drew the villagers, who then beat the camel thinking it was raiding their sugarcane field.",
    ),
    ComprehensionQuestion(
      prompt: "3. What happened to the camel on account of the jackal's trick?",
      answer: "The villagers beat it with sticks, and it had to rush back to the river to save itself.",
    ),
    ComprehensionQuestion(
      prompt: "4. How did the camel take vengeance on the jackal?",
      answer: "While carrying the jackal back across the river, it rolled in the water — saying it was his own habit after a good meal — and nearly drowned the jackal.",
    ),
    ComprehensionQuestion(prompt: "5. Suggest a title.", answer: "The Jackal and the Camel"),
  ],
);

final ComprehensionPassage _faithfulNursePassage = ComprehensionPassage(
  id: "faithful_nurse",
  title: "The Faithful Nurse",
  tamilTitle: "நம்பிக்கையான செவிலித்தாய்",
  emoji: "👑",
  passage:
      "A son was born to a king. His mother died during his birth. A young "
      "mother with a baby was chosen as his nurse. She nursed both babies "
      "together. The enemies of the king plotted to kill his son. They "
      "bribed the guards and got into the palace. But the nurse was warned "
      "just in time. She quickly changed the dress of the children. She "
      "left her own child dressed as the prince and fled with the real "
      "prince. Murderers entered the room and killed the child left behind. "
      "Thereby the prince was saved. The king offered her a lot of rewards. "
      "But she refused to take them and killed herself. The king became "
      "very sad; he erected a splendid tomb for the faithful nurse.",
  tamilSummary:
      "அரசனின் மகனைக் காப்பாற்ற, செவிலித்தாய் தன் சொந்தக் குழந்தையை இளவரசன் போல் "
      "உடுத்தி, உண்மையான இளவரசனுடன் மறைந்து செல்கிறாள். கொலைகாரர்கள் அவளுடைய "
      "சொந்தக் குழந்தையையே கொன்றுவிடுகின்றனர். வெகுமதியை மறுத்து, தன் "
      "குழந்தையின் இழப்பைத் தாங்காமல் அவள் உயிர் துறக்கிறாள்.",
  questions: const [
    ComprehensionQuestion(prompt: "1. What had happened to the mother of the king's son?", answer: "She had died during childbirth."),
    ComprehensionQuestion(
      prompt: "2. Who was appointed to take care of the king's son?",
      answer: "A young mother who had a baby of her own was appointed as his nurse.",
    ),
    ComprehensionQuestion(
      prompt: "3. How did she save the son of the king?",
      answer: "When she learned of the murder plot, she swapped the children's clothes, dressing her own baby as the prince, and fled with the real prince — so the murderers killed her own child by mistake.",
    ),
    ComprehensionQuestion(
      prompt: "4. why did she refuse to accept the rewards?",
      answer: "Her grief over losing her own child was far greater than any reward could make up for, so she refused them and took her own life.",
    ),
    ComprehensionQuestion(prompt: "5. Suggest a title.", answer: "The Faithful Nurse"),
  ],
);

final ComprehensionPassage _miserPassage = ComprehensionPassage(
  id: "miser_farmer",
  title: "The Miser and the Farmer",
  tamilTitle: "கஞ்சனும் விவசாயியும்",
  emoji: "💰",
  passage:
      "Once there lived a miser. He lost a purse of a hundred pieces of "
      "gold. He became sad. He went to the town crier. The crier said that "
      "the miser must offer a reward for those who reported the lost gold "
      "to him. The miser accepted the proposal, and the crier announced the "
      "miser's loss to the public. A few days later, a farmer came to the "
      "miser and handed over the purse which he had picked up a few days "
      "before. The miser counted the gold; there were 100 pieces of gold "
      "inside the purse. He thanked the farmer. The farmer asked for the "
      "reward. But the miser said that there had been 110 pieces in the "
      "purse, and that the farmer had already taken his reward — the "
      "missing ten pieces. They quarrelled. The farmer appealed to the "
      "judge. The judge heard the case for the purse. He saw that the purse "
      "could hold only 100 pieces of gold. He decided that the purse could "
      "not be the miser's. He gave the purse to the farmer. Thus, the miser "
      "had overreached himself.",
  tamilSummary:
      "பேராசை கொண்ட ஒரு கஞ்சன் தனது பணப்பையை இழக்கிறான். நேர்மையான விவசாயி அதைத் "
      "திருப்பிக் கொடுத்தும், வெகுமதி கொடுக்காமல் இருக்க கஞ்சன் பணப்பையில் இருந்த "
      "தொகையைப் பற்றி பொய் சொல்கிறான். அவனது பொய் பொருந்தாததால், நீதிபதி முழுப் "
      "பணப்பையையும் விவசாயிக்கே கொடுத்துவிடுகிறார் — கஞ்சனின் பேராசையே அவனுக்கு "
      "நஷ்டமாகிறது.",
  questions: const [
    ComprehensionQuestion(prompt: "1. Why did the miser become sad?", answer: "Because he lost his purse containing a hundred gold coins."),
    ComprehensionQuestion(
      prompt: "2. What was the condition of the town crier?",
      answer: "That the miser must offer a reward to whoever reported his lost gold.",
    ),
    ComprehensionQuestion(
      prompt: "3. Why did the miser refuse to pay the reward for the farmer?",
      answer: "He lied that the purse had originally held 110 pieces, claiming the farmer had already kept ten of them as his reward.",
    ),
    ComprehensionQuestion(
      prompt: "4. What had happened to the miser after the court judgment?",
      answer: "Since the purse could hold only 100 pieces (not the 110 he claimed), the judge ruled it could not be his, and gave the whole purse to the farmer instead — so the miser's own greed cost him everything.",
    ),
    ComprehensionQuestion(prompt: "5. Suggest a title.", answer: "The Miser and the Honest Farmer"),
  ],
);

final ComprehensionPassage _kingStonePassage = ComprehensionPassage(
  id: "king_stone",
  title: "The King's Lesson",
  tamilTitle: "அரசனின் பாடம்",
  emoji: "🪨",
  passage:
      "Once there lived a king. He became sad on seeing all his subjects "
      "lazy. He decided to teach them a lesson. One night he put a very big "
      "stone in the middle of the road. Next day, a merchant of the city "
      "saw the stone and went around it without making any effort to "
      "remove it from the road. An officer who drove on the road in his "
      "carriage did the same. A young soldier came riding and did the same. "
      "All cursed the stone and blamed the government for not removing it. "
      "Then the king ordered the stone to be removed. He had kept an iron "
      "box under it, marked \"for the man who moves away the stone.\" There "
      "was a purse full of money inside the box. The people were ashamed of "
      "the laziness that had stood in their way of getting the reward.",
  tamilSummary:
      "தனது குடிமக்கள் சோம்பேறிகளாக இருப்பதைக் கண்ட ஒரு அரசன், சாலையில் ஒரு பெரிய "
      "கல்லை வைத்து அவர்களைச் சோதிக்கிறான். பலரும் அதை நீக்காமல் சுற்றிச் "
      "செல்கின்றனர். கல்லுக்குக் கீழே பரிசுத் தொகை வைக்கப்பட்டிருந்ததை அறிந்து, "
      "தங்கள் சோம்பேறித்தனத்தால் இழந்ததை எண்ணி மக்கள் வெட்கப்படுகின்றனர்.",
  questions: const [
    ComprehensionQuestion(prompt: "1. Why did the king become sad?", answer: "Because he saw that all his subjects were lazy."),
    ComprehensionQuestion(
      prompt: "2. What was the plan of the king to teach his people?",
      answer: "He placed a huge stone in the middle of the road overnight, to see whether anyone would bother to move it.",
    ),
    ComprehensionQuestion(
      prompt: "3. How many went round the stone without removing it?",
      answer: "At least three are named — a merchant, an officer, and a young soldier — and everyone else who passed just cursed the stone and blamed the government instead of moving it.",
    ),
    ComprehensionQuestion(
      prompt: "4. What did the king keep inside under the stone?",
      answer: "An iron box holding a purse full of money, marked for whoever moved the stone away.",
    ),
    ComprehensionQuestion(prompt: "5. Suggest a title", answer: "The King's Lesson"),
  ],
);

final ComprehensionPassage _antDovePassage = ComprehensionPassage(
  id: "ant_dove",
  title: "The Ant and the Dove",
  tamilTitle: "எறும்பும் புறாவும்",
  emoji: "🐜",
  passage:
      "Once an ant, who had come to drink at a stream, fell into the water "
      "and was carried away by the swift current. She was in great danger "
      "of drowning. A dove, perched on a nearby tree, saw the ant's danger "
      "and dropped a leaf into the water. The ant climbed on to this and "
      "was carried to safety. Some time after this, a hunter creeping "
      "through the bushes saw the dove asleep and took careful aim with "
      "his gun. He was about to fire when the ant, who was nearby, crawled "
      "forward and bit him sharply on the ankle. The hunter missed his aim, "
      "and the loud noise of the gun awakened the dove from her sleep. She "
      "saw her danger and flew swiftly away to safety. Thus the ant repaid "
      "the dove for having saved its life in the foaming current of the "
      "stream.",
  tamilSummary:
      "நீரோட்டத்தில் சிக்கிய எறும்பை ஒரு புறா இலையைப் போட்டு காப்பாற்றுகிறது. "
      "பின்னர் வேட்டைக்காரன் புறாவைச் சுட முயலும்போது, எறும்பு அவனைக் கடித்து "
      "காப்பாற்றி நன்றி செலுத்துகிறது.",
  questions: const [
    ComprehensionQuestion(prompt: "1. Why did the ant come to the stream?", answer: "It came to drink water."),
    ComprehensionQuestion(
      prompt: "2. How did the ant rescue itself from danger?",
      answer: "It climbed onto a leaf that the dove dropped into the water, and was carried to safety.",
    ),
    ComprehensionQuestion(
      prompt: "3. What had happened to the dove?",
      answer: "A hunter crept up, saw the dove asleep, and took careful aim with his gun to shoot it.",
    ),
    ComprehensionQuestion(
      prompt: "4. How did the ant repay to the dove?",
      answer: "It crawled forward and bit the hunter sharply on the ankle, spoiling his aim and waking the dove in time for her to fly away safely.",
    ),
    ComprehensionQuestion(prompt: "5. Give a suitable a title.", answer: "The Ant and the Dove"),
  ],
);

// ============================================================
// All Module 4 passages, in book order
// ============================================================
final List<ComprehensionPassage> comprehensionPassages = [
  _oldLadyPassage,
  _jackalCamelPassage,
  _faithfulNursePassage,
  _miserPassage,
  _kingStonePassage,
  _antDovePassage,
];
