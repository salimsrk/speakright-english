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
//
// Tamil coverage: every passage has a full Tamil translation
// (`tamilPassage`), and every question and its model answer has its
// own Tamil translation (`tamilPrompt` / `tamilAnswer`) — not just a
// short gist — so a student can read and answer entirely in Tamil
// alongside the English.

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
  tamilPassage:
      "ஒரு காலத்தில் ஒரு வயதான பெண்மணி வாழ்ந்து வந்தாள். அவள் குருடியானாள். அவள் ஒரு "
      "மருத்துவரை அழைத்தாள். குணமானால் பெரிய கட்டணம் தருவதாகவும், மருத்துவர் தன் "
      "கடமையில் தோல்வியடைந்தால் எதுவும் தரமாட்டேன் எனவும் ஒப்புக்கொண்டாள். "
      "மருத்துவர் அவளுக்குச் சிகிச்சை அளித்தார். அவர் அவளுடைய தளபாடங்களின் மீது "
      "பேராசை கொண்டு, குணப்படுத்துவதைத் தாமதப்படுத்தினார். ஒவ்வொரு நாளும் அவர் சில "
      "தளபாடங்களைத் திருடிச் சென்றார். இறுதியில் அவளைக் குணப்படுத்தினார். பிறகு தன் "
      "கட்டணத்தைக் கேட்டார். ஆனால் தன் குணம் முழுமையாகவில்லை என்று கூறி அவள் "
      "கட்டணம் தர மறுத்தாள். அவள் மருத்துவர் மீது நீதிமன்றத்தில் வழக்குத் "
      "தொடுத்தாள். ஏன் கட்டணம் தர மறுக்கிறாய் என்று நீதிபதி பெண்மணியிடம் கேட்டார். "
      "தன் தளபாடங்கள் அனைத்தையும் காண முடியாததால், தன் பார்வை முழுமையாகக் "
      "குணமாகவில்லை என்று அவள் பதிலளித்தாள். நீதிபதி அவளுக்குச் சாதகமாகத் "
      "தீர்ப்பளித்தார்.",
  questions: const [
    ComprehensionQuestion(
      prompt: "a) What had happened to the old lady?",
      tamilPrompt: "வயதான பெண்மணிக்கு என்ன நடந்தது?",
      answer: "She had become blind.",
      tamilAnswer: "அவள் குருடியாகிவிட்டாள்.",
    ),
    ComprehensionQuestion(
      prompt: "b) Why did the doctor delay the treatment?",
      tamilPrompt: "மருத்துவர் ஏன் சிகிச்சையைத் தாமதப்படுத்தினார்?",
      answer: "He grew greedy for her furniture, so he kept delaying her cure while he took away a little of it every day.",
      tamilAnswer:
          "அவளுடைய தளபாடங்களின் மீது அவருக்குப் பேராசை வந்தது, எனவே ஒவ்வொரு நாளும் "
          "கொஞ்சம் கொஞ்சமாக அதை எடுத்துச் சென்று, குணப்படுத்துவதைத் தொடர்ந்து "
          "தாமதப்படுத்தினார்.",
    ),
    ComprehensionQuestion(
      prompt: "c) What did he do in her home?",
      tamilPrompt: "அவள் வீட்டில் அவர் என்ன செய்தார்?",
      answer: "Every day, he took away some of her furniture.",
      tamilAnswer: "ஒவ்வொரு நாளும், அவர் அவளுடைய சில தளபாடங்களை எடுத்துச் சென்றார்.",
    ),
    ComprehensionQuestion(
      prompt: "d) Why did the lady file the case on the doctor?",
      tamilPrompt: "பெண்மணி ஏன் மருத்துவர் மீது வழக்குத் தொடுத்தாள்?",
      answer: "Because once he finally cured her, he demanded his fees, but she refused to pay, saying her cure was not complete.",
      tamilAnswer:
          "இறுதியில் அவளைக் குணப்படுத்திய பிறகு அவர் கட்டணம் கேட்டார், ஆனால் தன் "
          "குணம் முழுமையாகவில்லை என்று கூறி அவள் கட்டணம் தர மறுத்தாள்.",
    ),
    ComprehensionQuestion(
      prompt: "e) Suggest a suitable title",
      tamilPrompt: "பொருத்தமான தலைப்பு ஒன்றை சொல்லுங்கள்",
      answer: "The Blind Lady and the Greedy Doctor",
      tamilAnswer: "குருடான பெண்மணியும் பேராசை கொண்ட மருத்துவரும்",
    ),
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
  tamilPassage:
      "ஒரு நரி நதியின் மறுகரையில் இருந்த நண்டுகளை சாப்பிட விரும்பியது. நதியை "
      "எப்படிக் கடப்பது என்று அது யோசித்தது. பிறகு அது ஒரு ஒட்டகத்தை அணுகி, "
      "மறுகரையில் நிறைய கரும்புத் தோட்டங்கள் இருப்பதாகக் கூறி அதை நம்பவைத்தது. "
      "ஒட்டகம் கரும்பு சுவைக்க ஆவலாகி, நரியிடமிருந்து பெற்ற தகவலுக்கு ஈடாக அதை "
      "நதியைக் கடக்க வைக்க ஒப்புக்கொண்டது. ஒட்டகம் நரியைத் தன் முதுகில் சுமந்து "
      "நதியைக் கடந்தது. மறுகரையில் நண்டுகளைச் சாப்பிட்ட பிறகு, நரி சத்தமாக "
      "ஊளையிடத் தொடங்கியது. நரி ஒட்டகத்திற்கு ஒரு தந்திரம் செய்ய விரும்பியது. "
      "ஊர்மக்கள் ஓடிவந்து ஒட்டகத்தைக் கரும்புத் தோட்டத்தில் கண்டனர். அவர்கள் அதைத் "
      "தடிகளால் அடித்தனர், ஒட்டகம் தன் உயிரைக் காப்பாற்ற நதியை நோக்கி ஓடியது. நரி "
      "அதன் முதுகில் குதித்தது. கடக்கும் போது, ஏன் இப்படி ஒரு தந்திரம் செய்தாய் "
      "என்று ஒட்டகம் நரியிடம் கேட்டது. நல்ல உணவு உண்ட பிறகு ஊளையிடுவது தன் "
      "வழக்கம் என்று நரி பதிலளித்தது. இதற்கு, நல்ல உணவு உண்ட பிறகு குளிப்பது தன் "
      "வழக்கம் என்று ஒட்டகம் பதிலளித்தது. பிறகு அது நதியில் புரண்டது. நரி "
      "கிட்டத்தட்ட மூழ்கிவிட்டது.",
  questions: const [
    ComprehensionQuestion(
      prompt: "1. Why did the jackal want to go to the other side of the river?",
      tamilPrompt: "நரி ஏன் நதியின் மறுகரைக்குச் செல்ல விரும்பியது?",
      answer: "Because it wanted to eat the crabs found there.",
      tamilAnswer: "அங்கே கிடைக்கும் நண்டுகளைச் சாப்பிட விரும்பியதால்.",
    ),
    ComprehensionQuestion(
      prompt: "2. What was the trick the jackal played on the camel?",
      tamilPrompt: "நரி ஒட்டகத்திற்கு என்ன தந்திரம் செய்தது?",
      answer: "After eating its fill, it started howling loudly, which drew the villagers, who then beat the camel thinking it was raiding their sugarcane field.",
      tamilAnswer:
          "வயிறு நிறைய சாப்பிட்ட பிறகு, அது சத்தமாக ஊளையிடத் தொடங்கியது; இது "
          "ஊர்மக்களை ஈர்த்தது, அவர்கள் ஒட்டகம் தங்கள் கரும்புத் தோட்டத்தை "
          "அழிக்கிறது என்று நினைத்து அதை அடித்தனர்.",
    ),
    ComprehensionQuestion(
      prompt: "3. What happened to the camel on account of the jackal's trick?",
      tamilPrompt: "நரியின் தந்திரத்தால் ஒட்டகத்திற்கு என்ன நேர்ந்தது?",
      answer: "The villagers beat it with sticks, and it had to rush back to the river to save itself.",
      tamilAnswer: "ஊர்மக்கள் அதைத் தடிகளால் அடித்தனர், தன்னைக் காப்பாற்ற அது நதியை நோக்கி ஓட வேண்டியதாயிற்று.",
    ),
    ComprehensionQuestion(
      prompt: "4. How did the camel take vengeance on the jackal?",
      tamilPrompt: "ஒட்டகம் நரியிடம் எப்படிப் பழிவாங்கியது?",
      answer: "While carrying the jackal back across the river, it rolled in the water — saying it was his own habit after a good meal — and nearly drowned the jackal.",
      tamilAnswer:
          "நரியை மீண்டும் நதியைக் கடத்திச் செல்லும்போது, நல்ல உணவுக்குப் பிறகு "
          "குளிப்பது தன் வழக்கம் எனக் கூறி, அது நீரில் புரண்டது — இதனால் நரி "
          "கிட்டத்தட்ட மூழ்கிவிட்டது.",
    ),
    ComprehensionQuestion(
      prompt: "5. Suggest a title.",
      tamilPrompt: "ஒரு தலைப்பு சொல்லுங்கள்.",
      answer: "The Jackal and the Camel",
      tamilAnswer: "நரியும் ஒட்டகமும்",
    ),
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
  tamilPassage:
      "ஒரு அரசனுக்கு ஒரு மகன் பிறந்தான். அவனுடைய தாய் பிரசவத்தின் போது "
      "இறந்துவிட்டாள். ஒரு குழந்தையுடன் இருந்த இளம் தாய் ஒருத்தி அவனுக்குச் "
      "செவிலியாக நியமிக்கப்பட்டாள். அவள் இரு குழந்தைகளையும் சேர்த்து வளர்த்தாள். "
      "அரசனின் எதிரிகள் அவனுடைய மகனைக் கொல்ல சதி செய்தனர். அவர்கள் காவலர்களுக்கு "
      "லஞ்சம் கொடுத்து அரண்மனைக்குள் நுழைந்தனர். ஆனால் செவிலித்தாய் சரியான "
      "நேரத்தில் எச்சரிக்கப்பட்டாள். அவள் விரைவாக குழந்தைகளின் ஆடைகளை மாற்றினாள். "
      "தன் சொந்தக் குழந்தையை இளவரசன் போல் உடுத்தி விட்டு, உண்மையான "
      "இளவரசனுடன் தப்பிச் சென்றாள். கொலைகாரர்கள் அறைக்குள் நுழைந்து விட்டுச் "
      "சென்ற குழந்தையைக் கொன்றுவிட்டனர். இதனால் இளவரசன் காப்பாற்றப்பட்டான். "
      "அரசன் அவளுக்குப் பல வெகுமதிகளை வழங்க முன்வந்தான். ஆனால் அவள் அவற்றை "
      "ஏற்க மறுத்து தற்கொலை செய்துகொண்டாள். அரசன் மிகவும் வருத்தமடைந்தான்; "
      "நம்பிக்கையான அந்த செவிலித்தாய்க்கு ஒரு அழகிய கல்லறை எழுப்பினான்.",
  questions: const [
    ComprehensionQuestion(
      prompt: "1. What had happened to the mother of the king's son?",
      tamilPrompt: "அரசனின் மகனின் தாய்க்கு என்ன நடந்தது?",
      answer: "She had died during childbirth.",
      tamilAnswer: "அவள் பிரசவத்தின்போது இறந்துவிட்டாள்.",
    ),
    ComprehensionQuestion(
      prompt: "2. Who was appointed to take care of the king's son?",
      tamilPrompt: "அரசனின் மகனைக் கவனிக்க யார் நியமிக்கப்பட்டார்?",
      answer: "A young mother who had a baby of her own was appointed as his nurse.",
      tamilAnswer: "சொந்தக் குழந்தை ஒன்றைக் கொண்டிருந்த ஒரு இளம் தாய் அவனுக்குச் செவிலியாக நியமிக்கப்பட்டாள்.",
    ),
    ComprehensionQuestion(
      prompt: "3. How did she save the son of the king?",
      tamilPrompt: "அரசனின் மகனை அவள் எப்படிக் காப்பாற்றினாள்?",
      answer: "When she learned of the murder plot, she swapped the children's clothes, dressing her own baby as the prince, and fled with the real prince — so the murderers killed her own child by mistake.",
      tamilAnswer:
          "கொலைச் சதியை அறிந்தவுடன், அவள் குழந்தைகளின் ஆடைகளை மாற்றி, தன் "
          "சொந்தக் குழந்தையை இளவரசன் போல் உடுத்தி, உண்மையான இளவரசனுடன் தப்பிச் "
          "சென்றாள் — இதனால் கொலைகாரர்கள் தவறுதலாக அவளுடைய சொந்தக் குழந்தையையே "
          "கொன்றனர்.",
    ),
    ComprehensionQuestion(
      prompt: "4. why did she refuse to accept the rewards?",
      tamilPrompt: "வெகுமதிகளை ஏற்க அவள் ஏன் மறுத்தாள்?",
      answer: "Her grief over losing her own child was far greater than any reward could make up for, so she refused them and took her own life.",
      tamilAnswer:
          "தன் சொந்தக் குழந்தையை இழந்த துயரம் எந்த வெகுமதியாலும் ஈடுசெய்ய "
          "முடியாததாக இருந்தது, எனவே அவள் அவற்றை மறுத்து தற்கொலை செய்துகொண்டாள்.",
    ),
    ComprehensionQuestion(
      prompt: "5. Suggest a title.",
      tamilPrompt: "ஒரு தலைப்பு சொல்லுங்கள்.",
      answer: "The Faithful Nurse",
      tamilAnswer: "நம்பிக்கையான செவிலித்தாய்",
    ),
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
  tamilPassage:
      "ஒரு காலத்தில் ஒரு கஞ்சன் வாழ்ந்து வந்தான். அவன் நூறு தங்கக் காசுகள் "
      "நிறைந்த ஒரு பணப்பையை இழந்தான். அவன் வருத்தமடைந்தான். அவன் ஊர் "
      "அறிவிப்பாளரிடம் சென்றான். இழந்த தங்கத்தைத் தெரிவிப்பவர்களுக்கு கஞ்சன் "
      "வெகுமதி அளிக்க வேண்டும் என்று அறிவிப்பாளர் கூறினார். கஞ்சன் அந்த "
      "முன்மொழிவை ஏற்றுக்கொண்டான், அறிவிப்பாளர் கஞ்சனின் இழப்பைப் "
      "பொதுமக்களுக்கு அறிவித்தார். சில நாட்களுக்குப் பிறகு, ஒரு விவசாயி "
      "கஞ்சனிடம் வந்து, சில நாட்களுக்கு முன்பு தான் எடுத்திருந்த பணப்பையைத் "
      "திருப்பிக் கொடுத்தான். கஞ்சன் தங்கத்தை எண்ணினான்; பணப்பைக்குள் 100 "
      "தங்கக் காசுகள் இருந்தன. அவன் விவசாயிக்கு நன்றி தெரிவித்தான். விவசாயி "
      "வெகுமதியைக் கேட்டான். ஆனால் பணப்பையில் 110 காசுகள் இருந்ததாகவும், "
      "விவசாயி ஏற்கனவே காணாமல் போன பத்து காசுகளையே தன் வெகுமதியாக "
      "எடுத்துக்கொண்டதாகவும் கஞ்சன் கூறினான். அவர்கள் சண்டையிட்டனர். விவசாயி "
      "நீதிபதியிடம் முறையிட்டான். நீதிபதி பணப்பை வழக்கைக் கேட்டார். பணப்பையில் "
      "100 காசுகள் மட்டுமே அடங்கும் என்பதை அவர் கண்டார். அந்தப் பணப்பை "
      "கஞ்சனுடையதாக இருக்க முடியாது என்று அவர் முடிவு செய்தார். அவர் "
      "பணப்பையை விவசாயிக்கே கொடுத்தார். இவ்வாறு, கஞ்சனின் பேராசையே அவனுக்கு "
      "நஷ்டமாகியது.",
  questions: const [
    ComprehensionQuestion(
      prompt: "1. Why did the miser become sad?",
      tamilPrompt: "கஞ்சன் ஏன் வருத்தமடைந்தான்?",
      answer: "Because he lost his purse containing a hundred gold coins.",
      tamilAnswer: "நூறு தங்கக் காசுகள் இருந்த தன் பணப்பையை இழந்ததால்.",
    ),
    ComprehensionQuestion(
      prompt: "2. What was the condition of the town crier?",
      tamilPrompt: "ஊர் அறிவிப்பாளரின் நிபந்தனை என்ன?",
      answer: "That the miser must offer a reward to whoever reported his lost gold.",
      tamilAnswer: "தன் இழந்த தங்கத்தைத் தெரிவிப்பவருக்கு கஞ்சன் வெகுமதி அளிக்க வேண்டும் என்பதே.",
    ),
    ComprehensionQuestion(
      prompt: "3. Why did the miser refuse to pay the reward for the farmer?",
      tamilPrompt: "விவசாயிக்கு வெகுமதி தர கஞ்சன் ஏன் மறுத்தான்?",
      answer: "He lied that the purse had originally held 110 pieces, claiming the farmer had already kept ten of them as his reward.",
      tamilAnswer:
          "பணப்பையில் முதலில் 110 காசுகள் இருந்ததாகவும், விவசாயி ஏற்கனவே பத்து "
          "காசுகளைத் தன் வெகுமதியாக வைத்துக்கொண்டதாகவும் பொய் சொன்னான்.",
    ),
    ComprehensionQuestion(
      prompt: "4. What had happened to the miser after the court judgment?",
      tamilPrompt: "நீதிமன்றத் தீர்ப்புக்குப் பிறகு கஞ்சனுக்கு என்ன நடந்தது?",
      answer: "Since the purse could hold only 100 pieces (not the 110 he claimed), the judge ruled it could not be his, and gave the whole purse to the farmer instead — so the miser's own greed cost him everything.",
      tamilAnswer:
          "பணப்பையில் 100 காசுகள் மட்டுமே அடங்கும் (அவன் சொன்ன 110 அல்ல) "
          "என்பதால், அது அவனுடையதாக இருக்க முடியாது என்று நீதிபதி தீர்ப்பளித்து, "
          "முழுப் பணப்பையையும் விவசாயிக்கே கொடுத்தார் — கஞ்சனின் பேராசையே "
          "அவனுக்கு எல்லாவற்றையும் இழக்க வைத்தது.",
    ),
    ComprehensionQuestion(
      prompt: "5. Suggest a title.",
      tamilPrompt: "ஒரு தலைப்பு சொல்லுங்கள்.",
      answer: "The Miser and the Honest Farmer",
      tamilAnswer: "கஞ்சனும் நேர்மையான விவசாயியும்",
    ),
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
  tamilPassage:
      "ஒரு காலத்தில் ஒரு அரசன் வாழ்ந்து வந்தான். தன் குடிமக்கள் அனைவரும் "
      "சோம்பேறிகளாக இருப்பதைக் கண்டு அவன் வருத்தமடைந்தான். அவர்களுக்கு ஒரு பாடம் "
      "கற்பிக்க முடிவு செய்தான். ஒரு இரவில் அவன் சாலையின் நடுவில் மிகப் பெரிய "
      "கல் ஒன்றை வைத்தான். மறுநாள், நகரத்தின் வணிகர் ஒருவர் அந்தக் கல்லைக் கண்டு, "
      "அதை சாலையிலிருந்து நீக்க எந்த முயற்சியும் செய்யாமல் அதைச் சுற்றிச் "
      "சென்றார். தன் வண்டியில் அந்தச் சாலையில் சென்ற ஒரு அதிகாரியும் அப்படியே "
      "செய்தார். குதிரையில் வந்த ஒரு இளம் வீரனும் அப்படியே செய்தான். அனைவரும் "
      "கல்லைச் சபித்து, அதை நீக்காததற்காக அரசாங்கத்தைக் குறை கூறினர். பிறகு "
      "அரசன் கல்லை அகற்றும்படி உத்தரவிட்டான். அதற்குக் கீழே \"கல்லை "
      "அகற்றுபவருக்கு\" என்று எழுதப்பட்ட ஒரு இரும்புப் பெட்டியை அவன் "
      "வைத்திருந்தான். பெட்டிக்குள் பணம் நிறைந்த ஒரு பணப்பை இருந்தது. வெகுமதியைப் "
      "பெறுவதற்கு தடையாக இருந்த தங்கள் சோம்பேறித்தனத்தை எண்ணி மக்கள் "
      "வெட்கப்பட்டனர்.",
  questions: const [
    ComprehensionQuestion(
      prompt: "1. Why did the king become sad?",
      tamilPrompt: "அரசன் ஏன் வருத்தமடைந்தான்?",
      answer: "Because he saw that all his subjects were lazy.",
      tamilAnswer: "தன் குடிமக்கள் அனைவரும் சோம்பேறிகளாக இருப்பதைக் கண்டதால்.",
    ),
    ComprehensionQuestion(
      prompt: "2. What was the plan of the king to teach his people?",
      tamilPrompt: "தன் மக்களுக்குப் பாடம் கற்பிக்க அரசனின் திட்டம் என்ன?",
      answer: "He placed a huge stone in the middle of the road overnight, to see whether anyone would bother to move it.",
      tamilAnswer:
          "யாராவது அதை நீக்க முயற்சிப்பார்களா என்று பார்க்க, இரவோடு இரவாக "
          "சாலையின் நடுவில் ஒரு பெரிய கல்லை வைத்தான்.",
    ),
    ComprehensionQuestion(
      prompt: "3. How many went round the stone without removing it?",
      tamilPrompt: "கல்லை நீக்காமல் எத்தனை பேர் அதைச் சுற்றிச் சென்றனர்?",
      answer: "At least three are named — a merchant, an officer, and a young soldier — and everyone else who passed just cursed the stone and blamed the government instead of moving it.",
      tamilAnswer:
          "குறைந்தது மூன்று பேர் குறிப்பிடப்பட்டுள்ளனர் — ஒரு வணிகர், ஒரு "
          "அதிகாரி, ஒரு இளம் வீரன் — மற்றும் வழியில் சென்ற அனைவரும் கல்லை "
          "நீக்காமல் அதைச் சபித்து அரசாங்கத்தைக் குறை கூறினர்.",
    ),
    ComprehensionQuestion(
      prompt: "4. What did the king keep inside under the stone?",
      tamilPrompt: "கல்லுக்குக் கீழே அரசன் என்ன வைத்திருந்தான்?",
      answer: "An iron box holding a purse full of money, marked for whoever moved the stone away.",
      tamilAnswer: "கல்லை நீக்குபவருக்கு எனக் குறிக்கப்பட்ட, பணம் நிறைந்த பணப்பையுடன் கூடிய ஒரு இரும்புப் பெட்டி.",
    ),
    ComprehensionQuestion(
      prompt: "5. Suggest a title",
      tamilPrompt: "ஒரு தலைப்பு சொல்லுங்கள்",
      answer: "The King's Lesson",
      tamilAnswer: "அரசனின் பாடம்",
    ),
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
  tamilPassage:
      "ஒரு ஓடையில் தண்ணீர் குடிக்க வந்த ஒரு எறும்பு, தண்ணீரில் விழுந்து வேகமான "
      "நீரோட்டத்தால் அடித்துச் செல்லப்பட்டது. அது மூழ்கும் பெரும் ஆபத்தில் "
      "இருந்தது. அருகிலுள்ள ஒரு மரத்தில் அமர்ந்திருந்த புறா ஒன்று, எறும்பின் "
      "ஆபத்தைக் கண்டு ஒரு இலையை தண்ணீரில் போட்டது. எறும்பு அதன் மீது ஏறி "
      "பாதுகாப்பாக கரை சேர்ந்தது. இதற்குப் பிறகு சிறிது நேரத்தில், புதர்களின் "
      "வழியாக ஊர்ந்து வந்த ஒரு வேட்டைக்காரன், தூங்கிக் கொண்டிருந்த புறாவைக் "
      "கண்டு, தன் துப்பாக்கியால் கவனமாக குறி வைத்தான். அவன் சுடப் போகும் "
      "நேரத்தில், அருகிலிருந்த எறும்பு ஊர்ந்து சென்று அவன் கணுக்காலில் கடுமையாகக் "
      "கடித்தது. வேட்டைக்காரனின் குறி தவறியது, துப்பாக்கியின் சத்தம் புறாவை "
      "அதன் தூக்கத்திலிருந்து எழுப்பியது. அது தன் ஆபத்தைக் கண்டு வேகமாகப் "
      "பறந்து பாதுகாப்பாகச் சென்றது. இவ்வாறு, நுரைத்த நீரோட்டத்தில் தன் "
      "உயிரைக் காப்பாற்றியதற்காக எறும்பு புறாவுக்குக் கடன் தீர்த்தது.",
  questions: const [
    ComprehensionQuestion(
      prompt: "1. Why did the ant come to the stream?",
      tamilPrompt: "எறும்பு ஏன் ஓடைக்கு வந்தது?",
      answer: "It came to drink water.",
      tamilAnswer: "அது தண்ணீர் குடிக்க வந்தது.",
    ),
    ComprehensionQuestion(
      prompt: "2. How did the ant rescue itself from danger?",
      tamilPrompt: "எறும்பு ஆபத்திலிருந்து தன்னை எப்படி காப்பாற்றிக் கொண்டது?",
      answer: "It climbed onto a leaf that the dove dropped into the water, and was carried to safety.",
      tamilAnswer: "புறா தண்ணீரில் போட்ட ஒரு இலையின் மீது அது ஏறி, பாதுகாப்பாகக் கரை சேர்ந்தது.",
    ),
    ComprehensionQuestion(
      prompt: "3. What had happened to the dove?",
      tamilPrompt: "புறாவிற்கு என்ன நேர்ந்தது?",
      answer: "A hunter crept up, saw the dove asleep, and took careful aim with his gun to shoot it.",
      tamilAnswer:
          "ஒரு வேட்டைக்காரன் மெதுவாக நெருங்கி, தூங்கிக் கொண்டிருந்த புறாவைக் "
          "கண்டு, அதைச் சுட தன் துப்பாக்கியால் கவனமாக குறி வைத்தான்.",
    ),
    ComprehensionQuestion(
      prompt: "4. How did the ant repay to the dove?",
      tamilPrompt: "எறும்பு புறாவுக்கு எப்படி கடன் தீர்த்தது?",
      answer: "It crawled forward and bit the hunter sharply on the ankle, spoiling his aim and waking the dove in time for her to fly away safely.",
      tamilAnswer:
          "அது முன்னோக்கி ஊர்ந்து சென்று வேட்டைக்காரனின் கணுக்காலைக் "
          "கடுமையாகக் கடித்தது, இதனால் அவன் குறி தவறியது, புறா சரியான "
          "நேரத்தில் விழித்து பாதுகாப்பாகப் பறந்து சென்றது.",
    ),
    ComprehensionQuestion(
      prompt: "5. Give a suitable a title.",
      tamilPrompt: "பொருத்தமான தலைப்பு ஒன்று சொல்லுங்கள்.",
      answer: "The Ant and the Dove",
      tamilAnswer: "எறும்பும் புறாவும்",
    ),
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
