// Module 3 (Grammar) content — transcribed and cross-checked directly
// against the course book's pages 36-64 ("MODUEL - III GRAMMAR", a typo in
// the book's own header). Every rule, example sentence and exercise item
// below was verified against the actual scanned page images (not just OCR
// text), the same standard used for Module 1 and Module 2.
//
// A handful of small, deliberate fixes were made to obvious book/print
// errors so students never see a typo presented as correct English:
//   - Sentence-ordering exercise item 2's printed answer "The postman
//     beings us letters." -> corrected to "brings".
//   - Noun Pairs exercise item 4 was printed as the garbled "Dooton and
//     ____", which doesn't pair sensibly with the leftover word-bank word
//     "nouns". Flagged to the user, who chose to replace it with a
//     sensible pair instead of showing the garbled text; replaced with
//     "Pronouns and ____" -> "nouns".
//   - Word Formation table rows 26/27/45/46 had print/typesetting slips
//     ("Diporable", "Pretensions" in the Adjective column, "Altraction" /
//     "Altract", and a Noun/Adjective mix-up on "Automatic"/"Automotive")
//     — corrected to the standard word-family spellings (Deplorable,
//     Pretentious, Attraction/Attract, Automation/Automatic).
//
// Tamil coverage follows the same plan used for Module 2's
// PronunciationGroup: every topic and every point/kind inside it carries a
// short Tamil heading (and, for the more important rules, a short Tamil
// explanation). The many example sentences themselves stay English-only —
// translating every one of them would add noise without helping a student
// who already has a Tamil rule summary alongside the English examples,
// same as the book itself only ever presents English examples. Exercise
// items get a short Tamil hint where it genuinely helps (the smaller,
// sentence-level drills); the big 51-row Word Formation table is a pure
// English word-family exercise, so a generic Tamil instruction covers it
// instead of 51 near-identical hints, and the two "worked reference" sets
// (Adjective identification, Noun Clauses) already show their answers
// straight from the book, so they skip per-item hints too.

import '../models/grammar.dart';
import '../models/vocab.dart' show McqQuestion;

// ============================================================
// Word Formation — 51-row Noun/Verb/Adjective/Adverb table
// ============================================================
// _wfGiven[i] = [noun, verb, adjective] exactly as printed in the book,
// with "" marking a cell the book leaves blank for the student to fill.
// The Adverb column is blank for every single row in the book, so it is
// not stored here — every row's Adverb is always something to fill in.
// _wfFill[i] = [noun, verb, adjective, adverb] — the correct word for
// each blank cell (index left "" in _wfGiven when that column was given).
const List<List<String>> _wfGiven = [
  ["Advice", "", "Advisable"], // 1
  ["Near", "Near", "Nearby"], // 2
  ["Exclusion", "", "Exclusive"], // 3
  ["Equality", "Equalize", ""], // 4
  ["Excellence", "", "Excellent"], // 5
  ["Exception", "", "Exceptionable"], // 6
  ["Fool", "Fool", "Foolish"], // 7
  ["Remark", "Remark", "Remarkable"], // 8
  ["Progress", "Progress", "Progressive"], // 9
  ["Prosperity", "Prosper", "Prosperous"], // 10
  ["Inclusion", "", "Inclusive"], // 11
  ["Cheer", "Cheer", "Cheerful"], // 12
  ["Particularity", "Particularize", "Particular"], // 13
  ["Regularity", "", "Regular"], // 14
  ["Difference", "Differentiate", "Different"], // 15
  ["Effect", "Effect", "Effective"], // 16
  ["Bind", "Bind", "Binding"], // 17
  ["Blessedness", "Bless", "Blessed"], // 18
  ["Pleasure", "Please", "Pleasant"], // 19
  ["Suggestion", "Suggest", ""], // 20
  ["Explication", "Explicate", "Explicable"], // 21
  ["Strength", "", "Strong"], // 22
  ["Weakness", "Weaken", "Weak"], // 23
  ["Clarity", "Clear", "Clear"], // 24
  ["Preference", "Prefer", ""], // 25
  ["Deplorability", "", "Deplorable"], // 26
  ["Pretension", "", "Pretentious"], // 27
  ["Falsity", "", "False"], // 28
  ["Formalism", "", "Formal"], // 29
  ["Forgetfulness", "", "Forgetful"], // 30
  ["Presence", "", "Present"], // 31
  ["Absence", "", "Absent"], // 32
  ["Vision", "", "Visual"], // 33
  ["Vitality", "", "Vital"], // 34
  ["Volunteer", "Volunteer", "Voluntary"], // 35
  ["Fashion", "Fashion", "Fashionable"], // 36
  ["Criticism", "Criticize", "Critical"], // 37
  ["Competition", "", "Competitive"], // 38
  ["Comfort", "", "Comfortable"], // 39
  ["Commendation", "", "Commendable"], // 40
  ["Commerce", "", "Commercial"], // 41
  ["Boldness", "Embolden", "Bold"], // 42
  ["Symbol", "", "Symbolic"], // 43
  ["Attention", "Attend", ""], // 44
  ["Attraction", "Attract", ""], // 45
  ["Automation", "Automate", "Automatic"], // 46
  ["Calculation", "", "Calculated"], // 47
  ["Director", "", "Direct"], // 48
  ["Admission", "", "Admissible"], // 49
  ["Allowance", "", "Allowable"], // 50
  ["Nature", "", "Natural"], // 51
];

const List<List<String>> _wfFill = [
  ["", "Advise", "", "Advisably"],
  ["", "", "", "Nearly"],
  ["", "Exclude", "", "Exclusively"],
  ["", "", "Equal", "Equally"],
  ["", "Excel", "", "Excellently"],
  ["", "Except", "", "Exceptionably"],
  ["", "", "", "Foolishly"],
  ["", "", "", "Remarkably"],
  ["", "", "", "Progressively"],
  ["", "", "", "Prosperously"],
  ["", "Include", "", "Inclusively"],
  ["", "", "", "Cheerfully"],
  ["", "", "", "Particularly"],
  ["", "Regulate", "", "Regularly"],
  ["", "", "", "Differently"],
  ["", "", "", "Effectively"],
  ["", "", "", "Bindingly"],
  ["", "", "", "Blessedly"],
  ["", "", "", "Pleasantly"],
  ["", "", "Suggestive", "Suggestively"],
  ["", "", "", "Explicably"],
  ["", "Strengthen", "", "Strongly"],
  ["", "", "", "Weakly"],
  ["", "", "", "Clearly"],
  ["", "", "Preferable", "Preferably"],
  ["", "Deplore", "", "Deplorably"],
  ["", "Pretend", "", "Pretentiously"],
  ["", "Falsify", "", "Falsely"],
  ["", "Formalize", "", "Formally"],
  ["", "Forget", "", "Forgetfully"],
  ["", "Present", "", "Presently"],
  ["", "Absent", "", "Absently"],
  ["", "Visualize", "", "Visually"],
  ["", "Vitalize", "", "Vitally"],
  ["", "", "", "Voluntarily"],
  ["", "", "", "Fashionably"],
  ["", "", "", "Critically"],
  ["", "Compete", "", "Competitively"],
  ["", "Comfort", "", "Comfortably"],
  ["", "Commend", "", "Commendably"],
  ["", "Commercialize", "", "Commercially"],
  ["", "", "", "Boldly"],
  ["", "Symbolize", "", "Symbolically"],
  ["", "", "Attentive", "Attentively"],
  ["", "", "Attractive", "Attractively"],
  ["", "", "", "Automatically"],
  ["", "Calculate", "", "Calculatedly"],
  ["", "Direct", "", "Directly"],
  ["", "Admit", "", "Admissibly"],
  ["", "Allow", "", "Allowably"],
  ["", "Naturalize", "", "Naturally"],
];

List<GrammarFillItem> _buildWordFormationItems() {
  const labels = ["Noun", "Verb", "Adjective"];
  final items = <GrammarFillItem>[];
  for (var i = 0; i < _wfGiven.length; i++) {
    final g = _wfGiven[i];
    final f = _wfFill[i];
    final cells = <String>[];
    for (var j = 0; j < 3; j++) {
      cells.add("${labels[j]}: ${g[j].isEmpty ? '______' : g[j]}");
    }
    cells.add("Adverb: ______");
    final answerParts = <String>[];
    for (var j = 0; j < 3; j++) {
      if (g[j].isEmpty) answerParts.add("${labels[j]}: ${f[j]}");
    }
    answerParts.add("Adverb: ${f[3]}");
    items.add(GrammarFillItem(prompt: cells.join("\n"), answer: answerParts.join("\n")));
  }
  return items;
}

// ============================================================
// Topic 1 — Sentence
// ============================================================
final GrammarTopic _sentenceTopic = GrammarTopic(
  id: "sentence",
  title: "Sentence",
  tamilTitle: "வாக்கியம்",
  emoji: "📝",
  intro: "A sentence is a group of words that conveys a complete meaning, with a subject and a verb.",
  tamilIntro: "பொருள் முழுமையாகத் தரும் சொற்றொடரே வாக்கியம். இதில் ஒரு subject-உம் ஒரு verb-உம் இருக்கும்.",
  points: const [
    GrammarPoint(
      heading: "Assertive sentence (Statement)",
      tamilHeading: "செய்தி வாக்கியம்",
      explanation: "Gives information about something. Can be affirmative or negative.", tamilExplanation: "ஏதாவது ஒன்றைப் பற்றி தகவல் தரும். உறுதிமொழியாகவோ (affirmative) அல்லது மறுப்பாகவோ (negative) இருக்கலாம்.",
      examples: ["Science is an interesting subject. (Affirmative)", "I did not meet my friends yesterday. (Negative)"],
    ),
    GrammarPoint(
      heading: "Interrogative sentence (Question)",
      tamilHeading: "வினா வாக்கியம்",
      explanation: "Raises a question to get information. Ends with a question mark.", tamilExplanation: "தகவல் பெற வினா எழுப்பும் வாக்கியம். வினாக்குறியுடன் (?) முடியும்.",
      examples: ["Do you study your lessons daily?", "Didn't they pay their taxes on time?", "Is your father buying a new car?"],
    ),
    GrammarPoint(
      heading: "Imperative sentence",
      tamilHeading: "ஏவல் வாக்கியம்",
      explanation: "Gives orders, makes requests, or gives advice.", tamilExplanation: "கட்டளை இடும், கோரிக்கை வைக்கும், அல்லது அறிவுரை தரும் வாக்கியம்.",
      examples: ["Bring me a glass of water. (Order)", "Shoot down the enemies. (Command)", "Please, lend me your camera. (Request)", "Don't waste your precious time. (Advice)"],
    ),
    GrammarPoint(
      heading: "Exclamatory sentence",
      tamilHeading: "வியப்புக்குறி வாக்கியம்",
      explanation: "Expresses some strong or sudden feeling.", tamilExplanation: "ஒரு பலமான அல்லது திடீர் உணர்ச்சியை வெளிப்படுத்தும்.",
      examples: ["What a beauty!", "How happily they are living!"],
    ),
    GrammarPoint(
      heading: "Optative sentence",
      tamilHeading: "வேண்டுகோள்/விருப்ப வாக்கியம்",
      explanation: "Expresses a wish, probability or supposition.", tamilExplanation: "ஒரு விருப்பம், சாத்தியக்கூறு அல்லது ஊகத்தை வெளிப்படுத்தும்.",
      examples: ["May God help you.", "I wish they would be with me."],
    ),
  ],
  fillSets: [
    GrammarFillSet(
      id: "sentence_disorder",
      title: "Disorder → Order",
      tamilTitle: "வரிசைப்படுத்துங்கள்",
      emoji: "🔀",
      instructions: "These words are in the wrong order. Rearrange them into a correct sentence.",
      tamilInstructions: "இந்த வார்த்தைகள் தவறான வரிசையில் உள்ளன. சரியான வாக்கியமாக மாற்றுங்கள்.",
      items: const [
        GrammarFillItem(prompt: "Wings fly, with their birds.", answer: "Birds fly with their wings.", tamilHint: "பறவைகள் தன் இறக்கைகளால் பறக்கும்."),
        GrammarFillItem(prompt: "The brings, us, letters, postman.", answer: "The postman brings us letters.", tamilHint: "தபால்காரர் நமக்கு கடிதங்கள் கொண்டுவருகிறார்."),
        GrammarFillItem(prompt: "Cup, milk drink this of.", answer: "Drink this cup of milk.", tamilHint: "இந்த கப் பாலைக் குடி."),
      ],
    ),
  ],
);

// ============================================================
// Topic 2 — Parts of Speech (overview only)
// ============================================================
final GrammarTopic _partsOfSpeechTopic = GrammarTopic(
  id: "parts_of_speech",
  title: "Parts of Speech",
  tamilTitle: "சொல் வகைகள்",
  emoji: "🧩",
  intro:
      "In a sentence, words are labeled according to their function — this is called Parts of Speech. "
      "They are eight in number: Noun, Pronoun, Adjective, Verb, Adverb, Preposition, Conjunction and Interjection.",
  tamilIntro: "வாக்கியத்தில் ஒவ்வொரு சொல்லும் அதன் வேலைக்கு ஏற்ப பெயரிடப்படும். மொத்தம் எட்டு வகைகள் உள்ளன: பெயர்ச்சொல், பிரதிபெயர்ச்சொல், பெயரடை, வினைச்சொல், வினையுரிச்சொல், முன்னிடைச்சொல், இணைப்புச்சொல், உணர்ச்சிச்சொல்.",
);

// ============================================================
// Topic 3 — Noun
// ============================================================
final GrammarTopic _nounTopic = GrammarTopic(
  id: "noun",
  title: "Noun",
  tamilTitle: "பெயர்ச்சொல்",
  emoji: "🏷️",
  intro: "A word which tells the name of a person, place or thing is called a noun. There are five kinds of nouns.",
  tamilIntro: "ஒரு நபர், இடம் அல்லது பொருளின் பெயரைக் குறிக்கும் சொல் பெயர்ச்சொல். ஐந்து வகைகள் உண்டு.",
  points: const [
    GrammarPoint(heading: "Proper Noun", tamilHeading: "சிறப்புப் பெயர்ச்சொல்", explanation: "Names of a specific person, place or thing.", tamilExplanation: "ஒரு குறிப்பிட்ட நபர், இடம் அல்லது பொருளின் பெயர்.", examples: ["Raman, Tamilnadu, Cauvery"]),
    GrammarPoint(heading: "Common Noun", tamilHeading: "பொதுப் பெயர்ச்சொல்", explanation: "Names given in common to every person or thing of the same class or kind.", tamilExplanation: "ஒரே இனத்தைச் சேர்ந்த அனைத்து நபர்/பொருட்களுக்கும் பொதுவாகத் தரப்படும் பெயர்.", examples: ["Student, Girl, Boy, Class"]),
    GrammarPoint(heading: "Collective Noun", tamilHeading: "தொகுதிப் பெயர்ச்சொல்", explanation: "A collection of persons or things taken together and spoken of as a whole.", tamilExplanation: "நபர்கள் அல்லது பொருட்களின் ஒரு தொகுப்பை, ஒரே அலகாகக் குறிக்கும் பெயர்.", examples: ["Army, flock, class, team, fleet, jury, family, nation, committee"]),
    GrammarPoint(heading: "Material Noun", tamilHeading: "பொருள் பெயர்ச்சொல்", explanation: "A noun that stands for matter or substance.", tamilExplanation: "ஒரு பொருள் அல்லது தாதுவைக் குறிக்கும் பெயர்ச்சொல்.", examples: ["Cotton, wood, gold, iron"]),
    GrammarPoint(heading: "Abstract Noun", tamilHeading: "பண்புப் பெயர்ச்சொல்", explanation: "Denotes a thing which we cannot see or touch.", tamilExplanation: "பார்க்கவோ தொடவோ முடியாத ஒரு கருத்தைக் குறிக்கும்.", examples: ["Truth, hope, honesty, health, courage, pain, joy, sleep, bravery, sickness"]),
  ],
  fillSets: const [
    GrammarFillSet(
      id: "noun_pairs",
      title: "Complete the Pairs",
      tamilTitle: "ஜோடிகளை நிறைவு செய்யுங்கள்",
      emoji: "🔗",
      instructions:
          "Complete each pair using a word from this list: Pupils, gentleman, enemies, saucers, villages, geography, wives, feet, answer, vegetable, fork, nouns.",
      tamilInstructions: "கொடுக்கப்பட்ட வார்த்தை பட்டியலிலிருந்து ஜோடியை நிறைவு செய்யுங்கள்.",
      items: [
        GrammarFillItem(prompt: "Ladies and ____", answer: "gentleman", tamilHint: "பெண்கள் மற்றும் ஆண்"),
        GrammarFillItem(prompt: "History and ____", answer: "geography", tamilHint: "வரலாறு மற்றும் புவியியல்"),
        GrammarFillItem(prompt: "Hands and ____", answer: "feet", tamilHint: "கைகள் மற்றும் கால்கள்"),
        GrammarFillItem(
          prompt: "Pronouns and ____",
          answer: "nouns",
          tamilHint: "பிரதிபெயர்ச்சொல் மற்றும் பெயர்ச்சொல் (இந்த இனத்தில் புத்தகத்தில் அச்சு தெளிவற்றிருந்ததால், பொருத்தமான ஜோடியாக மாற்றப்பட்டுள்ளது)",
        ),
        GrammarFillItem(prompt: "Fruit and ____", answer: "vegetable", tamilHint: "பழம் மற்றும் காய்கறி"),
        GrammarFillItem(prompt: "Friends and ____", answer: "enemies", tamilHint: "நண்பர்கள் மற்றும் எதிரிகள்"),
        GrammarFillItem(prompt: "Cup and ____", answer: "saucers", tamilHint: "கப் மற்றும் சாசர்"),
        GrammarFillItem(prompt: "Teachers and ____", answer: "pupils", tamilHint: "ஆசிரியர்கள் மற்றும் மாணவர்கள்"),
        GrammarFillItem(prompt: "Question and ____", answer: "answer", tamilHint: "கேள்வி மற்றும் பதில்"),
        GrammarFillItem(prompt: "Town and ____", answer: "villages", tamilHint: "நகரம் மற்றும் கிராமங்கள்"),
        GrammarFillItem(prompt: "Husbands and ____", answer: "wives", tamilHint: "கணவர்கள் மற்றும் மனைவிகள்"),
        GrammarFillItem(prompt: "Knives and ____", answer: "fork", tamilHint: "கத்தி மற்றும் முள்கரண்டி"),
      ],
    ),
  ],
);

// ============================================================
// Topic 4 — Noun Number
// ============================================================
const List<List<String>> _irregularPlurals = [
  ["Bee", "Bees"], ["Rose", "Roses"], ["Gas", "Gases"], ["Fox", "Foxes"],
  ["Army", "Armies"], ["Company", "Companies"], ["Boy", "Boys"], ["Ray", "Rays"],
  ["Calf", "Calves"], ["Wolf", "Wolves"], ["Chief", "Chiefs"], ["Proof", "Proofs"],
  ["Buffalo", "Buffaloes"], ["Hero", "Heroes"], ["Foot", "Feet"], ["Man", "Men"],
  ["Mouse", "Mice"], ["Son-in-law", "Sons-in-law"], ["Washer-man", "Washer-men"],
  ["Shop", "Shops"], ["Table", "Tables"], ["Box", "Boxes"], ["Bunch", "Bunches"],
  ["Copy", "Copies"], ["Duty", "Duties"], ["Monkey", "Monkeys"], ["Way", "Ways"],
  ["Leaf", "Leaves"], ["Thief", "Thieves"], ["Gulf", "Gulfs"], ["Hoof", "Hoofs"],
  ["Echo", "Echoes"], ["Mosquito", "Mosquitoes"], ["Goose", "Geese"], ["Woman", "Women"],
  ["Tooth", "Teeth"], ["Step-son", "Step-sons"], ["Passer-by", "Passers-by"],
];

final GrammarTopic _nounNumberTopic = GrammarTopic(
  id: "noun_number",
  title: "Noun Number",
  tamilTitle: "ஒருமை - பன்மை",
  emoji: "🔢",
  intro:
      "A noun standing for only one person or thing is Singular number. A noun standing for more than one is Plural number.",
  tamilIntro: "ஒரு பொருளைக் குறிப்பிட்டால் ஒருமை (Singular); ஒன்றுக்கு மேற்பட்டதைக் குறிப்பிட்டால் பன்மை (Plural).",
  points: [
    GrammarPoint(
      heading: "Irregular plurals",
      tamilHeading: "விதிவிலக்கான பன்மைகள்",
      explanation: "38 common singular-plural pairs to learn by heart.", tamilExplanation: "மனப்பாடம் செய்ய வேண்டிய 38 பொதுவான ஒருமை-பன்மை ஜோடிகள்.",
      examples: _irregularPlurals.map((p) => "${p[0]} → ${p[1]}").toList(),
    ),
    const GrammarPoint(
      heading: "Uncountable nouns — always singular",
      tamilHeading: "எண்ண முடியாத பெயர்ச்சொற்கள்",
      explanation: "These are rarely, if ever, used in the plural.", tamilExplanation: "இவை பன்மையில் அரிதாகவே பயன்படுத்தப்படும் (பெரும்பாலும் இல்லவே இல்லை).",
      examples: ["Gold, Dust, Smoke, Furniture, Dirt, Sugar and Milk — never used in plural forms."],
    ),
    const GrammarPoint(
      heading: "Same form for singular and plural",
      tamilHeading: "ஒருமையும் பன்மையும் ஒரே வடிவம்",
      examples: [
        "Sheep: There is a sheep in the field. / These sheep have no wool on them.",
        "Deer: This deer has beautiful horns. / These deer have beautiful horns.",
        "Dozen: I bought a dozen of mangoes. / She gave us five dozen apples.",
        "Fish: The fish is swimming in the pond. / Fish swim in the water.",
        "Score: He gave me a score of pencils. / He lived for four score years.",
      ],
    ),
    const GrammarPoint(
      heading: "Always singular",
      tamilHeading: "எப்போதும் ஒருமை",
      examples: ["Furniture, news, scenery, innings, mathematics, physics"],
    ),
    const GrammarPoint(
      heading: "Always plural",
      tamilHeading: "எப்போதும் பன்மை",
      examples: ["Alms, Cattle, People, Scissors, Trousers, Spectacles, Riches, Clothes, Poultry, Vermin, Gentry"],
    ),
    const GrammarPoint(
      heading: "Wrong → Right",
      tamilHeading: "தவறு → சரி",
      explanation: "Common mistakes with uncountable nouns.", tamilExplanation: "எண்ண முடியாத பெயர்ச்சொற்களுடன் நிகழும் பொதுவான தவறுகள்.",
      examples: [
        "He did many mischiefs. → He did many acts of mischief.",
        "He gave us many advices. → He gave us many pieces of advice.",
        "Excuse me for the troubles. → Excuse me for the trouble.",
        "He gave me many advices. → He advised me a lot.",
        "He gave me many abuses. → He showered abuses on me.",
        "His house is built of stones. → His house is built of stone.",
        "Your informations are wrong. → Your information is wrong.",
        "He had a bag of rices. → He had a bag of rice.",
        "He was fond of bad companies. → He was fond of bad company.",
      ],
    ),
    const GrammarPoint(
      heading: "We should always say",
      tamilHeading: "எப்போதும் இப்படிச் சொல்ல வேண்டும்",
      examples: [
        "The members of his family have come.",
        "There is no room in this compartment.",
        "Always help the poor, the needy.",
        "The blotting paper is mine.",
        "We had a good game of hockey.",
        "He gave me a ten-rupee note.",
        "He is a five year old child.",
        "There is a three foot rule.",
        "We have purchased a piece of ground on Salai road.",
      ],
    ),
    const GrammarPoint(
      heading: "Fish and hair",
      tamilHeading: "Fish, hair — சிறப்பு விதி",
      explanation: "Singular when used collectively (as a whole group/mass); otherwise always plural.", tamilExplanation: "ஒரு தொகுதியாகக் (குழுவாக/மொத்தமாக) குறிக்கும்போது ஒருமை; இல்லையெனில் எப்போதும் பன்மை.",
      examples: [
        "There is a plenty of fish here. (collective)",
        "There were some red and white fishes caught. (different kinds)",
        "Mary has a golden hair. (collective)",
        "He has few white hairs in his beard. (individual strands)",
      ],
    ),
  ],
  mcq: McqPractice(
    title: "Singular or Plural?",
    tamilTitle: "ஒருமையா பன்மையா?",
    questions: const [
      McqQuestion(prompt: "My scissors ___ not very sharp.", tamilPrompt: "scissors எப்போதும் பன்மை", options: ["is", "are"], correctIndex: 1),
      McqQuestion(prompt: "Mathematics ___ a difficult subject.", tamilPrompt: "Mathematics எப்போதும் ஒருமை", options: ["is", "are"], correctIndex: 0),
      McqQuestion(prompt: "The hunter shot there ___.", tamilPrompt: "deer — ஒருமையும் பன்மையும் ஒரே வடிவம்", options: ["deer", "deers"], correctIndex: 0),
      McqQuestion(prompt: "The ___ of the Himalayas is very fine.", tamilPrompt: "scenery எப்போதும் ஒருமை", options: ["scenery", "sceneries"], correctIndex: 0),
      McqQuestion(prompt: "The room is full of ___.", tamilPrompt: "furniture எப்போதும் ஒருமை", options: ["furnitures", "furniture"], correctIndex: 1),
      McqQuestion(prompt: "Her ___ is brown.", tamilPrompt: "தலைமுடி முழுவதையும் ஒரு தொகுதியாகக் கருதும்போது ஒருமை", options: ["hair", "hairs"], correctIndex: 0),
      McqQuestion(prompt: "The ___ are grazing in the field.", tamilPrompt: "cattle எப்போதும் பன்மை", options: ["cattle", "cattles"], correctIndex: 0),
      McqQuestion(prompt: "___ were given to the poor.", tamilPrompt: "Alms எப்போதும் பன்மை", options: ["Alm", "Alms"], correctIndex: 1),
      McqQuestion(prompt: "Fifty ___ are grazing in the field.", tamilPrompt: "sheep — ஒருமையும் பன்மையும் ஒரே வடிவம்", options: ["Sheep", "sheeps"], correctIndex: 0),
      McqQuestion(prompt: "He gave her five ___.", tamilPrompt: "எண்ணுக்குப் பின் hundred மாறாது", options: ["hundred", "Hundreds"], correctIndex: 0),
    ],
  ),
);

// ============================================================
// Topic 5 — Pronoun
// ============================================================
final GrammarTopic _pronounTopic = GrammarTopic(
  id: "pronoun",
  title: "Pronoun",
  tamilTitle: "பிரதிபெயர்ச்சொல்",
  emoji: "👤",
  intro: "A pronoun is a word used instead of a noun.",
  tamilIntro: "பெயர்ச்சொல்லுக்குப் பதிலாகப் பயன்படுத்தப்படும் சொல் பிரதிபெயர்ச்சொல்.",
  points: const [
    GrammarPoint(
      heading: "Personal Pronouns",
      tamilHeading: "தன்மை பிரதிபெயர்",
      examples: ["First person: I (singular), We (plural)", "Second person: You (singular), Your (plural)", "Third person: He, She, It (singular), They (plural)"],
    ),
    GrammarPoint(
      heading: "Reflexive Pronoun",
      tamilHeading: "தன்வினைப் பிரதிபெயர்",
      explanation: "Also called Emphasizing Pronouns.", tamilExplanation: "இதை Emphasizing Pronouns என்றும் அழைப்பர்.",
      examples: ["Myself, yourself, himself, herself"],
    ),
    GrammarPoint(heading: "Demonstrative Pronoun", tamilHeading: "சுட்டுப் பிரதிபெயர்", examples: ["this, that, there, those, such"]),
    GrammarPoint(heading: "Indefinite Pronoun", tamilHeading: "காலவரையறையற்ற பிரதிபெயர்", examples: ["all, some, many, few, none, other"]),
    GrammarPoint(heading: "Distributive Pronoun", tamilHeading: "பங்கீட்டு பிரதிபெயர்", examples: ["who, what, which, whom, whose"]),
    GrammarPoint(
      heading: "Relative Pronoun",
      tamilHeading: "தொடர்புப் பிரதிபெயர்",
      explanation: "who, which, whose, whom — joins two sentences about the same person/thing.", tamilExplanation: "who, which, whose, whom — ஒரே நபர்/பொருளைப் பற்றிய இரு வாக்கியங்களை இணைக்கும்.",
      examples: [
        "This is a man. He stole my purse. → This is a man who stole my purse.",
        "This is a boy. His nature is good. → This is a boy whose nature is good.",
        "This is a pen. Jim likes most. → This is a pen which Jim likes most.",
        "This is a house. Jack built it. → This is a house that Jack built.",
        "This is a boy. The teacher praised him. → This is a boy whom the teacher praised.",
      ],
    ),
  ],
);

// ============================================================
// Topic 6 — Adjective
// ============================================================
final GrammarTopic _adjectiveTopic = GrammarTopic(
  id: "adjective",
  title: "Adjective",
  tamilTitle: "பெயரடை",
  emoji: "🎨",
  intro: "An adjective is a word used to add to the meaning of a noun. There are six kinds of adjectives.",
  tamilIntro: "பெயர்ச்சொல்லின் பொருளை மேலும் விவரிக்கும் சொல் பெயரடை. ஆறு வகைகள் உண்டு.",
  points: const [
    GrammarPoint(
      heading: "Adjective of Quantity",
      tamilHeading: "அளவுப் பெயரடை",
      explanation: 'Answers the question "How much?"', tamilExplanation: '"எவ்வளவு?" (How much?) என்ற வினாவிற்கு பதிலளிக்கும்.',
      examples: ["He had much money.", "There is little food in the house.", "He wants some money.", "He did not eat any bread.", "He had sufficient bread.", "He ate the whole cake."],
    ),
    GrammarPoint(
      heading: "Adjective of Number",
      tamilHeading: "எண்ணுப் பெயரடை",
      explanation: 'Answers the question "How many?"', tamilExplanation: '"எத்தனை?" (How many?) என்ற வினாவிற்கு பதிலளிக்கும்.',
      examples: ["All men are mortal.", "Many women were not there.", "Several men came to see the line.", "He had five rupees in his pocket.", "Some men are rich.", "The first boy won the prize.", "Most men are lazy."],
    ),
    GrammarPoint(
      heading: "Distributive Adjective",
      tamilHeading: "பங்கீட்டுப் பெயரடை",
      explanation: "Refers to each one of a number.", tamilExplanation: "ஒரு தொகுதியில் உள்ள ஒவ்வொன்றையும் தனித்தனியே குறிக்கும்.",
      examples: ["Each woman carried a basket.", "Every word of it is true.", "Either pen will do.", "Neither boy is likely to pass."],
    ),
    GrammarPoint(
      heading: "Demonstrative Adjective",
      tamilHeading: "சுட்டுப் பெயரடை",
      explanation: 'Answers the question "Which?"', tamilExplanation: '"எது?" (Which?) என்ற வினாவிற்கு பதிலளிக்கும்.',
      examples: ["This house is mine.", "That house is yours.", "I like these flowers.", "I want those apples.", "I hate such men.", "She lives on yonder hill."],
    ),
    GrammarPoint(
      heading: "Interrogative Adjective",
      tamilHeading: "வினாப் பெயரடை",
      explanation: "Asks questions.", tamilExplanation: "வினா கேட்கப் பயன்படும்.",
      examples: ["What colour is your skin?", "Which house is yours?", "Whose book is this?"],
    ),
    GrammarPoint(
      heading: "Adjective of Quality",
      tamilHeading: "பண்புப் பெயரடை",
      explanation: 'Answers the question "What kind?"', tamilExplanation: '"எத்தகைய?" (What kind?) என்ற வினாவிற்கு பதிலளிக்கும்.',
      examples: ["Babur was a brave king.", "It was a cloudy day.", "He was an honest man.", "Calcutta is a big city.", "The rose is a beautiful flower."],
    ),
  ],
  fillSets: const [
    GrammarFillSet(
      id: "adjective_identify",
      title: "Identify the Adjectives",
      tamilTitle: "பெயரடையை அடையாளம் காணுங்கள்",
      emoji: "🔍",
      instructions: "The book already gives the answer for each — tap to check yourself, then reveal to confirm.",
      tamilInstructions: "இவற்றுக்கான பதில் புத்தகத்திலேயே கொடுக்கப்பட்டுள்ளது — நீங்களே யோசித்துப் பாருங்கள், பின் பதிலைப் பாருங்கள்.",
      items: [
        GrammarFillItem(prompt: "a. I know a funny little man.", answer: "Funny: Adjective of quality.\nLittle: Adjective of quantity.", tamilHint: "funny, little — இரண்டு பெயரடைகள் (பண்பு, அளவு)."),
        GrammarFillItem(prompt: "b. He is a man of few words.", answer: "Few: Adjective of quality.", tamilHint: "few — பண்புப் பெயரடை."),
        GrammarFillItem(prompt: "c. I have told this many time before.", answer: "Many: Adjective of number.", tamilHint: "many — எண்ணுப் பெயரடை."),
        GrammarFillItem(prompt: "d. An empty vessel makes much noise.", answer: "Empty: Adjective of quality.\nMuch: Adjective of quantity.", tamilHint: "empty, much — இரண்டு பெயரடைகள் (பண்பு, அளவு)."),
        GrammarFillItem(prompt: "e. Some dream of much reality.", answer: "Adjective of quality.", tamilHint: "much — பண்புப் பெயரடை."),
        GrammarFillItem(prompt: "f. There are several sheep in yonder valley.", answer: "Several: Adjective of Number.\nYonder: Demonstrative Adjective.", tamilHint: "several, yonder — எண்ணுப் பெயரடை மற்றும் சுட்டுப் பெயரடை."),
      ],
    ),
  ],
);

// ============================================================
// Topic 7 — Word Formation (standalone exercise topic)
// ============================================================
final GrammarTopic _wordFormationTopic = GrammarTopic(
  id: "word_formation",
  title: "Word Formation",
  tamilTitle: "சொல் வடிவங்கள்",
  emoji: "🔧",
  intro:
      "The same idea can be a Noun, a Verb, an Adjective or an Adverb depending on its ending — "
      "e.g. Beautification (noun), Beautify (verb), Beautiful (adjective), Beautifully (adverb). "
      "Fill in the blanks with the correct form of each word family.",
  tamilIntro: "ஒரே கருத்து பெயர்ச்சொல், வினைச்சொல், பெயரடை, வினையுரிச்சொல் என நான்கு வடிவங்களில் இருக்கும். வேற்று வார்த்தையை நினைத்துப் பாருங்கள்.",
  fillSets: [
    GrammarFillSet(
      id: "word_formation",
      title: "Noun · Verb · Adjective · Adverb",
      tamilTitle: "பெயர்ச்சொல் · வினைச்சொல் · பெயரடை · வினையுரிச்சொல்",
      emoji: "🔧",
      instructions: "Fill in every blank cell with the correct form of the word family. The Adverb column is always blank.",
      tamilInstructions: "ஒவ்வொரு காலியிடத்தையும் சரியான வடிவத்துடன் நிரப்புங்கள். Adverb column எப்போதும் காலியாக இருக்கும்.",
      items: _buildWordFormationItems(),
    ),
  ],
);

// ============================================================
// Topic 8 — Verb
// ============================================================
final GrammarTopic _verbTopic = GrammarTopic(
  id: "verb",
  title: "Verb",
  tamilTitle: "வினைச்சொல்",
  emoji: "🏃",
  intro: "A verb is a word which denotes an action. It tells us something about the subject. There are three kinds of verbs.",
  tamilIntro: "ஒரு செயலைக் குறிக்கும் சொல் வினைச்சொல். மூன்று வகைகள் உண்டு.",
  points: const [
    GrammarPoint(
      heading: "Transitive verb",
      tamilHeading: "செயப்படுபொருள் குன்றா வினை",
      explanation: "Requires an object after it to complete its sense.", tamilExplanation: "பொருள் முழுமையடைய, வினைச்சொல்லுக்குப் பின் ஒரு object தேவை.",
      examples: ["I eat an apple.", "He sees a picture.", "He makes good toys."],
    ),
    GrammarPoint(
      heading: "Intransitive verb",
      tamilHeading: "செயப்படுபொருள் குன்றிய வினை",
      explanation: "Does not need an object to complete its sense.", tamilExplanation: "பொருள் முழுமையடைய object தேவையில்லை.",
      examples: ["The man died.", "The girl slept.", "The sun shines.", "Birds fly in the air.", "He writes legibly."],
    ),
    GrammarPoint(
      heading: "Verb of incomplete predication",
      tamilHeading: "முழுமையடையா வினை",
      explanation: "Verbs that do not have complete sense but require some word(s) after them.", tamilExplanation: "தானாகவே முழு பொருள் தராத வினைச்சொற்கள் — பின்னால் வேறு சொற்கள் தேவைப்படும்.",
      examples: ["A dog is an animal.", "She looks pretty.", "They are fair in their dealings.", "A thief always lives in fear.", "She became sad.", "He seems tired."],
    ),
    GrammarPoint(
      heading: "Note",
      tamilHeading: "குறிப்பு",
      explanation: "Present Participle, Gerund, Past Participle and Infinitive are all parts of the verb.", tamilExplanation: "Present Participle, Gerund, Past Participle, Infinitive ஆகிய அனைத்தும் வினைச்சொல்லின் பகுதிகளே.",
    ),
  ],
);

// ============================================================
// Topic 9 — Verb Agreement
// ============================================================
final GrammarTopic _verbAgreementTopic = GrammarTopic(
  id: "verb_agreement",
  title: "Verb Agreement",
  tamilTitle: "வினை - எழுவாய் இசைவு",
  emoji: "✅",
  intro: "AGREEMENT OF VERB WITH THE SUBJECT — the verb must agree with its subject in number.",
  tamilIntro: "வினைச்சொல் எழுவாயின் எண்ணிற்கு (ஒருமை/பன்மை) ஏற்ப மாற வேண்டும்.",
  points: const [
    GrammarPoint(
      heading: "Rule examples",
      tamilHeading: "விதி எடுத்துக்காட்டுகள்",
      examples: [
        "Two and two makes four.",
        "Sheila with all her sisters is here.",
        "Every first class ticket costs a hundred rupees.",
        "Hundred rupees is a meagre salary.",
        "Either he or Anit is to blame.",
        "Either Ram or you are to blame.",
        "Either girls or Rama is to be present.",
        "Either Rama or all girls are to be present.",
        "The man with three cars is my neighbour.",
        "Each of you has a reward.",
        "None of you is likely to pass.",
        "Neither of you is right.",
        "No news is good news.",
        "Mathematics is a difficult subject.",
        "The Arabian Nights is an interesting story.",
        "The United States has a big army.",
        "The committee has decided this.",
        "The jury has given their verdict.",
      ],
    ),
  ],
  fillSets: [
    GrammarFillSet(
      id: "verb_agreement",
      title: "Correct the Verb",
      tamilTitle: "வினைச்சொல்லை சரிசெய்யுங்கள்",
      emoji: "✏️",
      instructions: "Correct each sentence so the verb agrees with the subject.",
      tamilInstructions: "வினைச்சொல் எழுவாயுடன் இசையும்படி வாக்கியத்தை சரிசெய்யுங்கள்.",
      items: [
        GrammarFillItem(prompt: "The cost of all these articles have risen.", answer: "The cost of all these articles has risen.", tamilHint: "எழுவாய் 'cost' — ஒருமை"),
        GrammarFillItem(prompt: "The general as well as his staff were there.", answer: "The general as well as his staff was there.", tamilHint: "'as well as' பின் முதல் எழுவாயைப் பின்பற்று"),
        GrammarFillItem(prompt: "Which one of these purses are yours?", answer: "Which one of these purses is yours?", tamilHint: "'one' — ஒருமை"),
        GrammarFillItem(prompt: "Throwing stones are forbidden.", answer: "Throwing stones is forbidden.", tamilHint: "Gerund phrase — ஒருமை"),
        GrammarFillItem(prompt: "Bread and butter is his main food.", answer: "Bread and butter is his main food. (already correct — one dish)", tamilHint: "ஒரே உணவு எனக் கருதப்படுகிறது"),
        GrammarFillItem(prompt: "Neither of them have returned.", answer: "Neither of them has returned.", tamilHint: "'Neither' — ஒருமை"),
        GrammarFillItem(prompt: "The scholar and the poet is dead.", answer: "The scholar and the poet are dead. (two people — article repeated)", tamilHint: "'the' இரண்டு முறை — இரண்டு பேர்"),
        GrammarFillItem(prompt: "The scholar and poet are dead.", answer: "The scholar and poet is dead. (one person — article not repeated)", tamilHint: "'the' ஒரு முறை — ஒரே நபர்"),
        GrammarFillItem(prompt: "Every one of them are present.", answer: "Every one of them is present.", tamilHint: "'Every one' — ஒருமை"),
        GrammarFillItem(prompt: "Neither of the questions appear difficult.", answer: "Neither of the questions appears difficult.", tamilHint: "'Neither' — ஒருமை"),
        GrammarFillItem(prompt: "A thousand kilometers are a great distance.", answer: "A thousand kilometers is a great distance.", tamilHint: "தூரம் ஒரு அளவு — ஒருமை"),
        GrammarFillItem(prompt: "Paul as well as Tom are guilty.", answer: "Paul as well as Tom is guilty.", tamilHint: "'as well as' பின் முதல் எழுவாயைப் பின்பற்று"),
        GrammarFillItem(prompt: "He with his friends are arrested.", answer: "He with his friends is arrested.", tamilHint: "'with' பின் முதல் எழுவாயைப் பின்பற்று"),
        GrammarFillItem(prompt: "Patience as well as perseverance are necessary for success.", answer: "Patience as well as perseverance is necessary for success.", tamilHint: "'as well as' பின் முதல் எழுவாயைப் பின்பற்று"),
        GrammarFillItem(prompt: "The horse and carriage are at the door.", answer: "The horse and carriage is at the door. (one rig/unit)", tamilHint: "ஒரே வண்டியாகக் கருதப்படுகிறது"),
        GrammarFillItem(prompt: "My friend and benefactor have come.", answer: "My friend and benefactor has come. (same person)", tamilHint: "ஒரே நபர்"),
        GrammarFillItem(prompt: "Either the boy or his parents has done this.", answer: "Either the boy or his parents have done this.", tamilHint: "'either...or' — அருகிலுள்ள எழுவாயைப் பின்பற்று"),
        GrammarFillItem(prompt: "Neither Tom nor his friends has come.", answer: "Neither Tom nor his friends have come.", tamilHint: "'neither...nor' — அருகிலுள்ள எழுவாயைப் பின்பற்று"),
        GrammarFillItem(prompt: "One of the boys were punished.", answer: "One of the boys was punished.", tamilHint: "'One' — ஒருமை"),
      ],
    ),
  ],
);

// ============================================================
// Topic 10 — Tenses
// ============================================================
final GrammarTopic _tensesTopic = GrammarTopic(
  id: "tenses",
  title: "Tenses",
  tamilTitle: "காலம்",
  emoji: "⏰",
  intro: "Tense indicates the time of the action or event: Present, Past or Future. Each has four forms — Simple, Continuous, Perfect and Perfect Continuous.",
  tamilIntro: "காலம் என்பது ஒரு செயல் நடந்த நேரத்தைக் குறிக்கும் — நிகழ்காலம், இறந்தகாலம், எதிர்காலம். ஒவ்வொன்றுக்கும் நான்கு வடிவங்கள் உண்டு.",
  points: const [
    GrammarPoint(heading: "1. Simple Present", tamilHeading: "எளிய நிகழ்காலம்", explanation: "An action happening right now, a habit, or a general truth.", tamilExplanation: "இப்போது நடக்கும் ஒரு செயல், ஒரு பழக்கம், அல்லது ஒரு பொதுவான உண்மை.", examples: ["See, how it rains!", "Cows give milk.", "I regularly get up by 5 a.m.", "We play tennis every day.", "The sun rises in the east."]),
    GrammarPoint(heading: "2. Present Continuous", tamilHeading: "தொடர் நிகழ்காலம்", explanation: "An action going on at the time of speaking.", tamilExplanation: "பேசும் நேரத்தில் நடந்துகொண்டிருக்கும் செயல்.", examples: ["The leaves are falling to the ground.", "The girls are dancing and singing now."]),
    GrammarPoint(heading: "3. Present Perfect", tamilHeading: "முடிந்த நிகழ்காலம்", explanation: "An action just over in the recent past, with reference to the time of speaking.", tamilExplanation: "பேசும் நேரத்தைக் குறிப்பிட்டு, சற்று முன்பே முடிந்த செயல்.", examples: ["The sun has just set.", "The train has just arrived.", "He has grown tall.", "I have lived in Chennai for 5 years. (still living there)"]),
    GrammarPoint(heading: "4. Present Perfect Continuous", tamilHeading: "தொடர் முடிந்த நிகழ்காலம்", explanation: "An action that began in the past and continues up to the present.", tamilExplanation: "கடந்த காலத்தில் தொடங்கி இப்போதும் தொடரும் செயல்.", examples: ["I have been working for two hours.", "I have been ill for three days."]),
    GrammarPoint(heading: "5. Simple Past", tamilHeading: "எளிய இறந்தகாலம்", explanation: "An action that took place in the past.", tamilExplanation: "கடந்த காலத்தில் நடந்த ஒரு செயல்.", examples: ["I saw an elephant yesterday.", "My friend died last year.", "They left the houses a week ago."]),
    GrammarPoint(heading: "6. Past Continuous", tamilHeading: "தொடர் இறந்தகாலம்", explanation: "An action begun and continuing in the past.", tamilExplanation: "கடந்த காலத்தில் தொடங்கி அப்போது தொடர்ந்து நடந்த செயல்.", examples: ["We were playing when you came.", "She was singing when I saw her."]),
    GrammarPoint(heading: "7. Past Perfect", tamilHeading: "முடிந்த இறந்தகாலம்", explanation: "An action completed before another action started.", tamilExplanation: "மற்றொரு செயல் தொடங்குவதற்கு முன் முடிந்துவிட்ட செயல்.", examples: ["The train had left before I arrived.", "I had finished my work before you came.", "The rain had stopped before you arrived."]),
    GrammarPoint(heading: "8. Past Perfect Continuous", tamilHeading: "தொடர் முடிந்த இறந்தகாலம்", explanation: "Two past actions — the earlier one had been continuing for some time when the later one took place.", tamilExplanation: "கடந்த காலத்தில் நடந்த இரு செயல்கள் — முந்தைய செயல் சிறிது நேரம் தொடர்ந்துகொண்டிருக்கும்போது பிந்தைய செயல் நடந்தது.", examples: ["He had been watching TV when I visited him yesterday."]),
    GrammarPoint(heading: "9. Simple Future", tamilHeading: "எளிய எதிர்காலம்", explanation: "A future action or event.", tamilExplanation: "எதிர்காலத்தில் நடக்கவிருக்கும் ஒரு செயல் அல்லது நிகழ்வு.", examples: ["I shall go to Chennai tomorrow.", "He will come here next Sunday."]),
    GrammarPoint(heading: "10. Future Continuous", tamilHeading: "தொடர் எதிர்காலம்", explanation: "An action continuing at some point in the future.", tamilExplanation: "எதிர்காலத்தில் ஒரு குறிப்பிட்ட நேரத்தில் தொடர்ந்து நடக்கும் செயல்.", examples: ["We shall be singing a song.", "The girls will be playing football."]),
    GrammarPoint(heading: "11. Future Perfect", tamilHeading: "முடிந்த எதிர்காலம்", explanation: "An action that will be completed before another future action.", tamilExplanation: "எதிர்காலத்தில் மற்றொரு செயலுக்கு முன் முடிந்திருக்கும் செயல்.", examples: ["I shall have written my letter before he comes.", "You will have heard this news already."]),
    GrammarPoint(heading: "12. Future Perfect Continuous", tamilHeading: "தொடர் முடிந்த எதிர்காலம்", explanation: "An action, finished or unfinished, that will be in progress for some time.", tamilExplanation: "முடிந்ததோ முடியாததோ, சிறிது காலம் தொடர்ந்திருக்கும் ஒரு செயல்.", examples: ["We shall have been playing three hours when you visit here.", "They will have been making preparation for the marriage for two months."]),
  ],
  mcq: McqPractice(
    title: "Choose the Right Tense",
    tamilTitle: "சரியான காலத்தைத் தேர்ந்தெடுங்கள்",
    questions: const [
      McqQuestion(prompt: "He ___ to Delhi yesterday.", tamilPrompt: "'yesterday' — இறந்தகாலம்", options: ["went", "has gone"], correctIndex: 0),
      McqQuestion(prompt: "I ___ working for 2 hours.", tamilPrompt: "'for 2 hours' — தொடர் முடிந்த நிகழ்காலம்", options: ["am", "have been"], correctIndex: 1),
      McqQuestion(prompt: "We shall serve you if you ___.", tamilPrompt: "'if' clause-இல் எளிய நிகழ்காலம்", options: ["come", "will come"], correctIndex: 0),
      McqQuestion(prompt: "They had left home before he ___.", tamilPrompt: "பிந்தைய செயலுக்கு எளிய இறந்தகாலம்", options: ["came", "had come"], correctIndex: 0),
      McqQuestion(prompt: "He ___ me a story just now.", tamilPrompt: "'just now' — எளிய இறந்தகாலம்", options: ["has told", "told"], correctIndex: 1),
      McqQuestion(prompt: "The train ___ an hour ago.", tamilPrompt: "'an hour ago' — எளிய இறந்தகாலம்", options: ["left", "has left"], correctIndex: 0),
      McqQuestion(prompt: "I felt that I ___ resign my post.", tamilPrompt: "காலவரிசை விதி — past main clause", options: ["shall", "should"], correctIndex: 1),
      McqQuestion(prompt: "Had I known you were coming, I ___.", tamilPrompt: "Third conditional", options: ["would stay", "would have stayed"], correctIndex: 1),
      McqQuestion(prompt: "I had gone to school when you ___ to see me.", tamilPrompt: "எளிய இறந்தகாலம்", options: ["came", "had came"], correctIndex: 0),
      McqQuestion(prompt: "Will the Headmaster ___ us?", tamilPrompt: "modal-க்குப் பின் அடிச்சொல் வடிவம்", options: ["allows", "allow"], correctIndex: 1),
      McqQuestion(prompt: "I ___ here for a month.", tamilPrompt: "'for a month' — தொடர் முடிந்த நிகழ்காலம்", options: ["am living", "have been living"], correctIndex: 1),
      McqQuestion(prompt: "It ___ all night.", tamilPrompt: "தொடர் நடவடிக்கை — தொடர் முடிந்த நிகழ்காலம்", options: ["is raining", "have been raining"], correctIndex: 1),
      McqQuestion(prompt: "He ___ us last month.", tamilPrompt: "'last month' — எளிய இறந்தகாலம்", options: ["had visited", "visited"], correctIndex: 1),
      McqQuestion(prompt: "He ___ last year.", tamilPrompt: "'last year' — எளிய இறந்தகாலம்", options: ["failed", "has failed"], correctIndex: 0),
      McqQuestion(prompt: "The train had left before they ___ the station.", tamilPrompt: "எளிய இறந்தகாலம்", options: ["reached", "had reached"], correctIndex: 0),
      McqQuestion(prompt: "I shall have finished my work before he ___.", tamilPrompt: "'before' time clause — எளிய நிகழ்காலம்", options: ["comes", "has come"], correctIndex: 0),
      McqQuestion(prompt: "I had finished my work before Tom ___ to see me.", tamilPrompt: "எளிய இறந்தகாலம்", options: ["came", "had come"], correctIndex: 0),
      McqQuestion(prompt: "We ___ the letter yet.", tamilPrompt: "'yet' — முடிந்த நிகழ்காலம்", options: ["did not write", "haven't written"], correctIndex: 1),
      McqQuestion(prompt: "The train had left before they ___ the station.", tamilPrompt: "எளிய இறந்தகாலம்", options: ["reached", "had reached"], correctIndex: 0),
      McqQuestion(prompt: "Columbus ___ America.", tamilPrompt: "வரலாற்று உண்மை — எளிய இறந்தகாலம்", options: ["had discovered", "discovered"], correctIndex: 1),
      McqQuestion(prompt: "She ___ just now.", tamilPrompt: "'just now' — முடிந்த நிகழ்காலம்", options: ["has arrived", "arrives"], correctIndex: 0),
      McqQuestion(prompt: "She ___ out half an hour ago.", tamilPrompt: "'ago' — எளிய இறந்தகாலம்", options: ["was", "had gone"], correctIndex: 0),
      McqQuestion(prompt: "I ___ at the station for her since 10 o'clock.", tamilPrompt: "'since' — தொடர் முடிந்த நிகழ்காலம்", options: ["was waiting", "have been waiting"], correctIndex: 1),
      McqQuestion(prompt: "She ___ born in 1980.", tamilPrompt: "எளிய இறந்தகாலம்", options: ["was", "had been"], correctIndex: 0),
      McqQuestion(prompt: "He ___ from fever since last week.", tamilPrompt: "'since' — தொடர் முடிந்த நிகழ்காலம்", options: ["has been suffering", "has suffered"], correctIndex: 0),
      McqQuestion(prompt: "He had visited many towns before ___.", tamilPrompt: "பிந்தைய செயலுக்கு எளிய இறந்தகாலம்", options: ["he was returning home", "he returned home"], correctIndex: 1),
      McqQuestion(prompt: "You will have reached home before ___.", tamilPrompt: "'before' time clause — எளிய நிகழ்காலம்", options: ["the rain set in", "the rain sets in"], correctIndex: 1),
      McqQuestion(prompt: "Three years have passed since his father ___.", tamilPrompt: "'since' + குறிப்பிட்ட நிகழ்வு — எளிய இறந்தகாலம்", options: ["died", "has died"], correctIndex: 0),
      McqQuestion(prompt: "I had been reading this book for two weeks before she ___.", tamilPrompt: "பிந்தைய செயலுக்கு எளிய இறந்தகாலம்", options: ["arrived", "had arrived"], correctIndex: 0),
      McqQuestion(prompt: "The rain had stopped when we ___.", tamilPrompt: "எளிய இறந்தகாலம்", options: ["came out", "would come out"], correctIndex: 0),
      McqQuestion(prompt: "I shall rest after ___.", tamilPrompt: "'after' time clause — முடிந்த நிகழ்காலம்", options: ["I have finished my work", "I will finish my work"], correctIndex: 0),
      McqQuestion(prompt: "I shall get a job before the week ___.", tamilPrompt: "'before' time clause — எளிய நிகழ்காலம்", options: ["ends", "had ended"], correctIndex: 0),
    ],
  ),
);

// ============================================================
// Topic 11 — Sequence of Tenses
// ============================================================
final GrammarTopic _sequenceOfTensesTopic = GrammarTopic(
  id: "sequence_of_tenses",
  title: "Sequence of Tenses",
  tamilTitle: "கால வரிசை விதி",
  emoji: "🔁",
  intro: "The tense of the verb in the subordinate clause must follow the tense of the verb in the main clause, according to these rules.",
  tamilIntro: "முதன்மைத் தொடரின் காலத்திற்கு ஏற்ப துணைத் தொடரின் காலமும் மாற வேண்டும்.",
  points: const [
    GrammarPoint(
      heading: "Rule 1",
      tamilHeading: "விதி 1",
      explanation: "A past tense in the main clause is followed by a past tense in the subordinate clause.", tamilExplanation: "முதன்மைத் தொடரில் இறந்தகாலம் இருந்தால், துணைத் தொடரிலும் இறந்தகாலமே பயன்படும்.",
      examples: ["She replied that she had no money with her.", "They found that he was dishonest."],
    ),
    GrammarPoint(
      heading: "Exception — universal truth",
      tamilHeading: "விதிவிலக்கு — உலகளாவிய உண்மை",
      explanation: "When the subordinate clause expresses a universal truth, it stays in the present tense even if the main clause is in the past.", tamilExplanation: "துணைத் தொடர் ஒரு உலகளாவிய உண்மையைக் குறித்தால், முதன்மைத் தொடர் இறந்தகாலத்தில் இருந்தாலும் அது நிகழ்காலத்திலேயே இருக்கும்.",
      examples: ["He said that all men are mortal.", "She said that God is love.", "He taught us that honesty is the best policy."],
    ),
    GrammarPoint(
      heading: "Exception — 'than'",
      tamilHeading: "விதிவிலக்கு — 'than'",
      explanation: "If the subordinate clause is introduced by 'than', it may be followed by a present tense even if the main clause is in the past tense.", tamilExplanation: "துணைத் தொடர் 'than' என்ற சொல்லால் தொடங்கினால், முதன்மைத் தொடர் இறந்தகாலத்தில் இருந்தாலும் நிகழ்காலம் பயன்படலாம்.",
      examples: ["She liked him better than she likes you.", "He helped me more than he helps his own children."],
    ),
    GrammarPoint(
      heading: "Rule 2",
      tamilHeading: "விதி 2",
      explanation: "A present or future tense in the main clause may be followed by any tense (present, past or future) required by the sense, in the subordinate clause.", tamilExplanation: "முதன்மைத் தொடர் நிகழ்காலம் அல்லது எதிர்காலத்தில் இருந்தால், துணைத் தொடரில் பொருளுக்கு ஏற்ப எந்த காலமும் (நிகழ்/இறந்த/எதிர்) பயன்படலாம்.",
      examples: [
        "She thinks that she works hard.",
        "She thinks that he worked well.",
        "She will think that he is present.",
        "She works hard lest she should fail.",
        "She worked hard lest she should fail.",
        "She will work hard lest she should fail.",
      ],
    ),
  ],
);

// ============================================================
// Topic 12 — Voice
// ============================================================
final GrammarTopic _voiceTopic = GrammarTopic(
  id: "voice",
  title: "Voice",
  tamilTitle: "வினைமுறை",
  emoji: "🔄",
  intro:
      "The hunter killed the tiger (Active Voice) — the subject is the doer of the action. "
      "The tiger was killed by the hunter (Passive Voice) — the subject is the sufferer/receiver of the action.",
  tamilIntro: "செய்பவர் எழுவாயாக இருந்தால் Active Voice; செயலைப் பெறுபவர் எழுவாயாக இருந்தால் Passive Voice.",
  points: const [
    GrammarPoint(heading: "a) Simple present", examples: ["The grocer sells sugar. (AV) → Sugar is sold by the grocer. (PV)", "Cats catch mice. (AV) → Mice are caught by cats. (PV)"]),
    GrammarPoint(heading: "b) Present Continuous", examples: ["The farmer is tilling the land. (AV) → The land is being tilled by the farmer. (PV)", "Are they picking some flowers? (AV) → Are some flowers being picked by them? (PV)"]),
    GrammarPoint(heading: "c) Present Perfect", examples: ["He has written a letter. (AV) → A letter has been written by him. (PV)", "I have taken your books. (AV) → Your books have been taken by me. (PV)"]),
    GrammarPoint(heading: "d) Simple Past", examples: ["He took my book. (AV) → My book was taken by him. (PV)", "Did he tell the truth? (AV) → Was the truth told by him? (PV)"]),
    GrammarPoint(heading: "e) Past Continuous", examples: ["He was playing football. (AV) → Football was being played by him. (PV)", "Were the farmers sowing the seeds? (AV) → Were the seeds being sown by the farmers? (PV)"]),
    GrammarPoint(heading: "f) Past Perfect", examples: ["The boys had eaten the cake. (AV) → The cake had been eaten by the boys. (PV)"]),
    GrammarPoint(heading: "g) Simple Future", examples: ["We shall finish the work by 6 p.m. (AV) → The work shall be finished by us by 6 p.m. (PV)", "He will hurt you. (AV) → You will be hurt by him. (PV)"]),
    GrammarPoint(heading: "h) Future Perfect", examples: ["He will have closed the shop by 8 o'clock. (AV) → The shop will have been closed by him by 8 o'clock. (PV)"]),
    GrammarPoint(
      heading: "Verbs with two objects",
      tamilHeading: "இரு செயப்படுபொருள் கொண்ட வினைச்சொற்கள்",
      explanation: "In the passive voice, one object becomes the subject and the other is retained as object.", tamilExplanation: "Passive voice-இல், ஒரு object எழுவாய் ஆகும்; மற்றொன்று object ஆகவே தொடரும்.",
      examples: ["He gave me some apples. (AV) → I was given some apples by him. (PV)", "He taught us English. (AV) → We were taught English by him. (PV)"],
    ),
    GrammarPoint(
      heading: "Intransitive verb + preposition",
      tamilHeading: "செயப்படுபொருள் குன்றிய வினை + முன்னிடைச்சொல்",
      explanation: "Some intransitive verbs, used with a preposition as a transitive verb, can take the passive voice.", tamilExplanation: "சில செயப்படுபொருள் குன்றிய வினைச்சொற்கள், ஒரு முன்னிடைச்சொல்லுடன் சேர்ந்து transitive verb போல செயல்பட்டு, passive voice எடுக்கலாம்.",
      examples: ["All laughed at her. (AV) → She was laughed at by all. (PV)", "She agreed to my proposal. (AV) → My proposal was agreed to by her. (PV)"],
    ),
    GrammarPoint(heading: "Imperative mood (Command/request)", examples: ["Shut the door. (AV) → Let the door be shut. (PV)"]),
    GrammarPoint(heading: "Interrogative (Question)", examples: ["When did you write this letter? (AV) → When was this letter written by you? (PV)"]),
    GrammarPoint(
      heading: "Passive voice without 'by'",
      tamilHeading: "'by' இல்லாத Passive Voice",
      examples: ["They elected him as king. (AV) → He was elected as king. (PV)", "They named their son Samuel. (AV) → Their son was named Samuel. (PV)"],
    ),
  ],
  fillSets: [
    GrammarFillSet(
      id: "voice_change",
      title: "Change the Voice",
      tamilTitle: "வினைமுறையை மாற்றுங்கள்",
      emoji: "🔄",
      instructions: "Change each sentence from Active to Passive voice.",
      tamilInstructions: "ஒவ்வொரு வாக்கியத்தையும் Active-இலிருந்து Passive Voice-க்கு மாற்றுங்கள்.",
      items: [
        GrammarFillItem(prompt: "Everybody loves animals.", answer: "Animals are loved by everybody.", tamilHint: "எளிய நிகழ்காலம்"),
        GrammarFillItem(prompt: "Does she always help her husband?", answer: "Is her husband always helped by her?", tamilHint: "வினா வாக்கியம்"),
        GrammarFillItem(prompt: "Meera is cooking the dinner.", answer: "The dinner is being cooked by Meera.", tamilHint: "தொடர் நிகழ்காலம்"),
        GrammarFillItem(prompt: "They are singing a prayer song.", answer: "A prayer song is being sung by them.", tamilHint: "தொடர் நிகழ்காலம்"),
        GrammarFillItem(prompt: "He has sold his old car.", answer: "His old car has been sold by him.", tamilHint: "முடிந்த நிகழ்காலம்"),
        GrammarFillItem(prompt: "Has she lost her purse?", answer: "Has her purse been lost by her?", tamilHint: "வினா வாக்கியம்"),
        GrammarFillItem(prompt: "The teacher punished all the pupils.", answer: "All the pupils were punished by the teacher.", tamilHint: "எளிய இறந்தகாலம்"),
        GrammarFillItem(prompt: "The wind was blowing the clouds away.", answer: "The clouds were being blown away by the wind.", tamilHint: "தொடர் இறந்தகாலம்"),
        GrammarFillItem(prompt: "Had the postman delivered the letter?", answer: "Had the letter been delivered by the postman?", tamilHint: "வினா வாக்கியம்"),
        GrammarFillItem(prompt: "Everyone will blame us.", answer: "We will be blamed by everyone.", tamilHint: "எளிய எதிர்காலம்"),
      ],
    ),
  ],
);

// ============================================================
// Topic 13 — Adverb
// ============================================================
final GrammarTopic _adverbTopic = GrammarTopic(
  id: "adverb",
  title: "Adverb",
  tamilTitle: "வினையுரிச்சொல்",
  emoji: "⚡",
  intro: "Adverbs are used to modify verbs.",
  tamilIntro: "வினைச்சொல்லை மேலும் விவரிக்கும் சொல் வினையுரிச்சொல்.",
  points: const [
    GrammarPoint(heading: "Adverb of Manner", tamilHeading: "விதம் காட்டும் வினையுரிச்சொல் — 'How?'", examples: ["wisely, well, fast, bravely, badly, slowly"]),
    GrammarPoint(heading: "Adverb of Place", tamilHeading: "இடம் காட்டும் வினையுரிச்சொல் — 'Where?'", examples: ["outside, inside, everywhere, anywhere, here, there, hither, thither, out, forward, backward"]),
    GrammarPoint(heading: "Adverb of Time", tamilHeading: "நேரம் காட்டும் வினையுரிச்சொல் — 'When?'", examples: ["today, tomorrow, yesterday, daily, early, presently, immediately, ago"]),
    GrammarPoint(heading: "Adverb of Number", tamilHeading: "எண்ணிக்கை காட்டும் வினையுரிச்சொல் — 'How often?'", examples: ["twice, always, often, seldom, once"]),
    GrammarPoint(heading: "Adverb of Degree", tamilHeading: "அளவு காட்டும் வினையுரிச்சொல் — 'How much?'", examples: ["very, quite, nearly, entirely, partly"]),
    GrammarPoint(heading: "Interrogative Adverbs", tamilHeading: "வினா வினையுரிச்சொல்", examples: ["when, where, how, why"]),
  ],
);

// ============================================================
// Topic 14 — Clause
// ============================================================
final GrammarTopic _clauseTopic = GrammarTopic(
  id: "clause",
  title: "Clause",
  tamilTitle: "தொடர்",
  emoji: "🔗",
  intro: "A clause is a group of words with its own subject and verb, forming part of a bigger (complex) sentence.",
  tamilIntro: "தன்னுடைய எழுவாயும் வினைச்சொல்லும் கொண்ட, ஒரு பெரிய வாக்கியத்தின் பகுதியாக இருக்கும் சொற்றொடர்.",
  points: const [
    GrammarPoint(
      heading: "1. Noun Clause",
      tamilHeading: "பெயர்த் தொடர்",
      explanation: "Does the work of a noun in a complex sentence — as subject, object, object of a preposition, complement, or apposition.", tamilExplanation: "ஒரு complex sentence-இல் பெயர்ச்சொல்லின் வேலையைச் செய்யும் — subject, object, preposition-இன் object, complement, அல்லது apposition ஆக.",
      examples: [
        "Subject: What she says is quite true.",
        "Subject: That he is an honest man is quite clear.",
        "Subject: Why she left is a mystery.",
        "Object: I do not know when she will come.",
        "Object: Tell me why you told a lie.",
        "Object: No one knows how old she is.",
        "Object of preposition: Pay careful attention to what he says.",
        "Object of preposition: He was greatly pleased with what I said.",
        "Complement: Her fear is that she may fail.",
        "Complement: Life is what we make of it.",
        "Complement: His belief is that ghosts can talk.",
        "Apposition: My hope that you may pass is very strong.",
        "Apposition: The report that he was killed is false.",
        "Apposition: It is clear that he was innocent.",
      ],
    ),
    GrammarPoint(
      heading: "2. Adjective Clause",
      tamilHeading: "பெயரடைத் தொடர்",
      explanation: "Introduced by a relative pronoun or relative adverb.", tamilExplanation: "ஒரு relative pronoun அல்லது relative adverb-ஆல் தொடங்கப்படும்.",
      examples: [
        "This is the boy who won the first prize.",
        "This is the house that John built.",
        "The time when the train leaves is not known.",
        "The reason why he told a lie is not known.",
      ],
    ),
    GrammarPoint(
      heading: "3. Adverb Clause of time",
      tamilHeading: "நேரம் காட்டும் வினையுரிச் தொடர்",
      explanation: "Introduced by: when, whenever, while, before, after, since, till, as.", tamilExplanation: "இவற்றால் தொடங்கப்படும்: when, whenever, while, before, after, since, till, as.",
      examples: [
        "When the cat is away the mice are at play.",
        "He goes mad whenever he comes to visit his mother's grave.",
        "Do not talk while you are eating.",
        "Before you leave switch off the light.",
        "I have been ill since you have left.",
        "As soon as the train had left, my friend rushed into the platform.",
        "No sooner did he see me than he took to his heels.",
      ],
    ),
    GrammarPoint(
      heading: "Adverb Clause of place",
      tamilHeading: "இடம் காட்டும் வினையுரிச் தொடர்",
      explanation: "Introduced by: where, wherever, whenever.", tamilExplanation: "இவற்றால் தொடங்கப்படும்: where, wherever, whenever.",
      examples: ["I have kept the book where no one can find it.", "Wherever he goes follow him.", "You can come whenever you like."],
    ),
    GrammarPoint(
      heading: "Adverb Clause of purpose",
      tamilHeading: "நோக்கம் காட்டும் வினையுரிச் தொடர்",
      explanation: "Introduced by: because, as, then, that, since.", tamilExplanation: "இவற்றால் தொடங்கப்படும்: because, as, then, that, since.",
      examples: ["I am glad because you are in time.", "I am glad that you do not like it.", "I am glad since you promise to serve me faithfully.", "I am glad as the truth comes out."],
    ),
    GrammarPoint(
      heading: "Adverb Clause of condition",
      tamilHeading: "நிபந்தனை காட்டும் வினையுரிச் தொடர்",
      explanation: "Introduced by: if, whether, unless.", tamilExplanation: "இவற்றால் தொடங்கப்படும்: if, whether, unless.",
      examples: ["If it rains we shall not play.", "He will not pass whether he works or not.", "Unless he works very hard he will fail."],
    ),
    GrammarPoint(
      heading: "Adverb Clause of Result",
      tamilHeading: "விளைவு காட்டும் வினையுரிச் தொடர்",
      explanation: "Introduced by: so.", tamilExplanation: "இதனால் தொடங்கப்படும்: so.",
      examples: ["He is so old that he can hardly work.", "She is so kind a woman that all respect her.", "The news is so good that it cannot be true."],
    ),
    GrammarPoint(
      heading: "Adverb Clause of comparison",
      tamilHeading: "ஒப்பீடு காட்டும் வினையுரிச் தொடர்",
      examples: [
        "Degree: She is younger than she looks.",
        "Degree: He is as foolish as he is lazy.",
        "Degree: He is not wise as you think.",
        "Manner: She does as she pleases.",
        "Manner: As you sow, you will reap.",
        "Manner: It all ended as we expected.",
      ],
    ),
    GrammarPoint(
      heading: "Adverb Clause of supposition or contrast",
      tamilHeading: "ஒப்புதல்/முரண் காட்டும் வினையுரிச் தொடர்",
      explanation: "Introduced by: though, even if, even though, although.", tamilExplanation: "இவற்றால் தொடங்கப்படும்: though, even if, even though, although.",
      examples: ["Though he is fair, she hates him.", "Although he was ill, he attended the class.", "Even if he is old, he is able to do a lot of work."],
    ),
  ],
  fillSets: const [
    GrammarFillSet(
      id: "noun_clause_exercise",
      title: "Noun Clauses",
      tamilTitle: "பெயர்த் தொடர்கள்",
      emoji: "🧩",
      instructions: "The book gives the complete noun clause for each — tap to check yourself, then reveal to confirm.",
      tamilInstructions: "இவற்றுக்கான முழுமையான பெயர்த் தொடர் புத்தகத்திலேயே கொடுக்கப்பட்டுள்ளது.",
      items: [
        GrammarFillItem(prompt: "1. Tell him ____", answer: "Tell him what you know about him.", tamilHint: "அவனைப் பற்றி நீ அறிந்ததைச் சொல்."),
        GrammarFillItem(prompt: "2. It is certain ____", answer: "It is certain that he will never get up early.", tamilHint: "அவன் ஒருபோதும் அதிகாலையில் எழ மாட்டான் என்பது உறுதி."),
        GrammarFillItem(prompt: "3. He was pleased with ____", answer: "He was pleased with what you have told about him.", tamilHint: "நீ அவனைப் பற்றிச் சொன்னதில் அவன் மகிழ்ந்தான்."),
        GrammarFillItem(prompt: "4. I think ____", answer: "I think that he is innocent.", tamilHint: "அவன் நேர்மையானவன் என்று நினைக்கிறேன்."),
        GrammarFillItem(prompt: "5. She told us ____", answer: "She told us where were you last Sunday.", tamilHint: "கடந்த ஞாயிறு நீ எங்கிருந்தாய் என்று அவள் சொன்னாள்."),
        GrammarFillItem(prompt: "6. All thought ____", answer: "All thought that he was dead and gone.", tamilHint: "அவன் இறந்துவிட்டான் என்று அனைவரும் நினைத்தனர்."),
        GrammarFillItem(prompt: "7. He knew ____", answer: "He knew that he will pass.", tamilHint: "தான் தேர்ச்சி பெறுவேன் என்று அவனுக்குத் தெரியும்."),
        GrammarFillItem(prompt: "8. No one knows ____", answer: "No one knows that he will pass.", tamilHint: "அவன் தேர்ச்சி பெறுவான் என்று யாருக்கும் தெரியாது."),
        GrammarFillItem(prompt: "9. Can you guess ____", answer: "Can you guess who he is.", tamilHint: "அவன் யார் என்று உன்னால் ஊகிக்க முடியுமா?"),
        GrammarFillItem(prompt: "10. ____ surprises me", answer: "Failure which is quite certain surprises me.", tamilHint: "நிச்சயமான தோல்வி என்னை ஆச்சரியப்படுத்துகிறது."),
      ],
    ),
  ],
);

// ============================================================
// Topic 15 — Preposition
// ============================================================
final GrammarTopic _prepositionTopic = GrammarTopic(
  id: "preposition",
  title: "Preposition",
  tamilTitle: "முன்னிடைச்சொல்",
  emoji: "📍",
  intro: 'Preposition is a word placed before a noun or pronoun to show what relation the person or thing denoted by the noun stands in to something else.',
  tamilIntro: "பெயர்ச்சொல்/பிரதிபெயர்ச்சொல்லுக்கு முன் வைக்கப்பட்டு, அதற்கும் மற்றொரு பொருளுக்கும் உள்ள தொடர்பைக் காட்டும் சொல்.",
  points: const [
    GrammarPoint(heading: "Simple prepositions", tamilHeading: "எளிய முன்னிடைச்சொற்கள்", examples: ["At, by, for, off, in, with, on, out, to, through, from"]),
    GrammarPoint(heading: "Compound prepositions", tamilHeading: "கூட்டு முன்னிடைச்சொற்கள்", examples: ["According, above, about, along, amidst, among, around, behind, beside, between, inside, outside, underneath, within, without"]),
    GrammarPoint(heading: "Phrase prepositions & phrasal verbs", tamilHeading: "சொற்றொடர் முன்னிடைச்சொற்கள்", examples: ["According to, in addition to, in place of, along with, in case of, in regard to, because of, in course of, inspite of, by dint of, in favour of, instead of"]),
    GrammarPoint(
      heading: "The uses of 'at' and 'in'",
      tamilHeading: "'at' மற்றும் 'in' பயன்பாடு",
      examples: [
        "'At' is used for a point of time: He came here at day break, at sunset etc.",
        "'In' is used for a period of time: In the morning, in the month of May, etc.",
        "'At' is used with reference to space, for small towns/villages: I met him at Keeranur. I will see him at school.",
        "'In' is used for big towns, cities, countries: He works in Mumbai. He works in Dubai.",
      ],
    ),
  ],
  fillSets: const [
    GrammarFillSet(
      id: "preposition_fill",
      title: "Fill in the Prepositions",
      tamilTitle: "முன்னிடைச்சொற்களை நிரப்புங்கள்",
      emoji: "📍",
      instructions: "Fill in the blanks with suitable prepositions.",
      tamilInstructions: "பொருத்தமான முன்னிடைச்சொல்லைக் கொண்டு காலியிடத்தை நிரப்புங்கள்.",
      items: [
        GrammarFillItem(prompt: "He was struck ____ his enemies ____ with a stick.", answer: "by, with", tamilHint: "'struck by' + 'with a stick' கருவி"),
        GrammarFillItem(prompt: "The tiger was killed ____ the hunter ____ a gun.", answer: "by, with", tamilHint: "செய்பவர் - by, கருவி - with"),
        GrammarFillItem(prompt: "He lives ____ Puri but I meet him often ____ Kolkotta.", answer: "at, in", tamilHint: "சிறு ஊர் - at, பெரிய நகரம் - in"),
        GrammarFillItem(prompt: "The two brothers quarralled ____ themselves.", answer: "between", tamilHint: "இருவருக்கு இடையே - between"),
        GrammarFillItem(prompt: "It has been raining ____ yesterday.", answer: "since", tamilHint: "தொடர்ச்சியான நேரம் - since"),
        GrammarFillItem(prompt: "He came and sat ____ me ____ last month.", answer: "by, for", tamilHint: "அருகில் - by, கால அளவு - for"),
        GrammarFillItem(prompt: "He has been ill ____ Tuesday.", answer: "since", tamilHint: "தொடர்ச்சியான நேரம் - since"),
        GrammarFillItem(prompt: "We have lived in this town ____ 1975.", answer: "since", tamilHint: "தொடர்ச்சியான நேரம் - since"),
        GrammarFillItem(prompt: "He met her ____ the station.", answer: "at", tamilHint: "இடம் - at"),
        GrammarFillItem(prompt: "I have cut my finger ____ a knife.", answer: "with", tamilHint: "கருவி - with"),
      ],
    ),
  ],
);

// ============================================================
// Topic 16 — Articles
// ============================================================
final GrammarTopic _articlesTopic = GrammarTopic(
  id: "articles",
  title: "Articles",
  tamilTitle: "கட்டுரைச் சொற்கள்",
  emoji: "🔤",
  intro: "'a', 'an', and 'the' are called Articles. 'a' and 'an' are indefinite articles; 'the' is the definite article.",
  tamilIntro: "'a', 'an' — திட்டமிடப்படாத பொருளைக் குறிக்கும் (Indefinite); 'the' — திட்டமிட்ட குறிப்பிட்ட பொருளைக் குறிக்கும் (Definite).",
  points: const [
    GrammarPoint(
      heading: "'a' is used before",
      tamilHeading: "'a' பயன்படும் இடங்கள்",
      examples: [
        "A noun beginning with a consonant sound: a boy, a flower, a woman, a cow, a horse.",
        "A vowel with the sound of (Y): a useless person, a ewe, a European, a unit, a utensil, a unicorn, a union, a university.",
        "A noun beginning with 'O' but with the sound (WO): a one rupee note, a one way road, a one eyed giant, such a one.",
      ],
    ),
    GrammarPoint(
      heading: "'an' is used before",
      tamilHeading: "'an' பயன்படும் இடங்கள்",
      examples: [
        "Idiomatic/figurative expressions: a few, a little (vs. few, little).",
        "Numerical expressions: a lot of, a thousand, a dozen.",
        "Price, speed, ratio: 50 kms an hour, three times a day, Rs.100 a metre.",
        "Exclamations before singular countable nouns: What a hot day! What a pretty baby!",
        "With a noun complement, including professions: He is a Teacher. She is a dancer. I am an engineer.",
      ],
    ),
    GrammarPoint(
      heading: "'the' is used",
      tamilHeading: "'the' பயன்படும் இடங்கள்",
      examples: [
        "For a particular person or thing: The house I have just bought is spacious. Call the boy wearing the blue shirt.",
        "For a singular noun representing a whole class: The cow is a useful animal. The dog is a faithful animal.",
        "Before rivers, mountain ranges, groups of islands: The Ganges, The Thames, The Himalayas, The British Isles, The Andamans.",
        "Before oceans, seas, gulfs, bays: The Indian Ocean, The Red Sea, The Arabian Sea, The Bay of Bengal, The Persian Gulf.",
        "Before names of some countries/provinces: The USA, The UK, The Deccan, The Punjab.",
        "Before names of well-known books: The Bible, The Bagavat Gita, The Kuran.",
        "Before adjectives in the superlative degree: May is the hottest month of the year.",
        "With a double comparative: The higher you go the colder it becomes.",
        "Before an adjective used as a noun: The poor depend on the rich. The wise don't like the company of the foolish.",
        "Before names of ships, trains, hotels, theatres, clubs: The Vaigai Express, The Taj Hotel, The Sapphire Theatre, The INS Virat.",
      ],
    ),
  ],
  fillSets: const [
    GrammarFillSet(
      id: "articles_fill",
      title: "Fill in the Articles",
      tamilTitle: "கட்டுரைச் சொற்களை நிரப்புங்கள்",
      emoji: "🔤",
      instructions: "Fill in the blanks with suitable articles (a / an / the).",
      tamilInstructions: "பொருத்தமான கட்டுரைச் சொல்லைக் (a/an/the) கொண்டு நிரப்புங்கள்.",
      items: [
        GrammarFillItem(
          prompt: "Leo Tolstoy was born in ___ Russian noble family. He became ___ orphan at ___ age of nine. He was enlisted as ___ officer in army and served there.",
          answer: "a Russian noble family / an orphan / the age of nine / an officer",
          tamilHint: "லியோ டால்ஸ்டாயின் பிறப்பு, திருமணம், இராணுவப் பணி பற்றிய பத்தி.",
        ),
        GrammarFillItem(
          prompt: "Experiments had reached ___ last stage and it seemed that success was just around ___ corner, when ___ disaster occurred which threw the whole family into mourning.",
          answer: "the last stage / the corner / a disaster",
          tamilHint: "சோதனைகள் கடைசி கட்டத்தை அடைந்தபோது நேர்ந்த சோகம் பற்றிய பத்தி.",
        ),
        GrammarFillItem(
          prompt: "As ___ world has advanced in science, war has become very dangerous. War at ___ present time will mean ___ end of ___ world.",
          answer: "the world / the present time / the end / the world",
          tamilHint: "அறிவியல் முன்னேற்றமும் போரின் ஆபத்தும் பற்றிய பத்தி.",
        ),
        GrammarFillItem(
          prompt: "___ most wonderful invention of the country is ___ computer. It has today become ___ integral part of ___ man's life in every field.",
          answer: "The most wonderful invention / the computer / an integral part / man's life (no article needed)",
          tamilHint: "கணினியின் கண்டுபிடிப்பு பற்றிய பத்தி.",
        ),
        GrammarFillItem(
          prompt: "___ video games is an example of ___ computer graphics system at work — programmed computer changes information into ___ pictures.",
          answer: "A / a / — (pictures needs no article, being plural and general)",
          tamilHint: "வீடியோ கேம்ஸ் மற்றும் கணினி கிராபிக்ஸ் பற்றிய பத்தி.",
        ),
      ],
    ),
  ],
);

// ============================================================
// Topic 17 — Question Tags
// ============================================================
final GrammarTopic _questionTagsTopic = GrammarTopic(
  id: "question_tags",
  title: "Question Tags",
  tamilTitle: "வினாத் தொகுப்புகள்",
  emoji: "❓",
  intro: "A question tag is a short question attached to a statement, used to draw attention, add emphasis, or evoke a response.",
  tamilIntro: "ஒரு வாக்கியத்தின் இறுதியில் இணைக்கப்படும் சிறு வினா — கவனத்தை ஈர்க்கவும், பதிலை எதிர்பார்க்கவும் பயன்படும்.",
  points: const [
    GrammarPoint(heading: "1", tamilHeading: "விதி 1", explanation: "Tag questions always use a contraction: aren't, isn't, didn't, won't etc.", tamilExplanation: "Tag questions எப்போதும் சுருக்கமான (contraction) வடிவையே பயன்படுத்தும்: aren't, isn't, didn't, won't போன்றவை."),
    GrammarPoint(heading: "2", tamilHeading: "விதி 2", explanation: "The subject of a tag question is never a noun but a pronoun.", tamilExplanation: "Tag question-இன் subject ஒருபோதும் பெயர்ச்சொல்லாக இருக்காது, பிரதிபெயர்ச்சொல்லாகவே இருக்கும்.", examples: ["Isn't he? Don't they? Can we? Am I?"]),
    GrammarPoint(heading: "3", tamilHeading: "விதி 3", explanation: "Tags are never used with questions, only added at the end of statements.", tamilExplanation: "Tags வினா வாக்கியங்களுடன் ஒருபோதும் பயன்படாது; செய்தி வாக்கியங்களின் முடிவில் மட்டுமே சேர்க்கப்படும்.", examples: ["He is clever, isn't he?"]),
    GrammarPoint(heading: "4", tamilHeading: "விதி 4", explanation: "The verb in the question tag is either the auxiliary used in the statement, or the proper form of Do, Does or Did.", tamilExplanation: "Question tag-இல் உள்ள வினைச்சொல், வாக்கியத்தில் பயன்படுத்திய auxiliary-ஐயோ அல்லது Do/Does/Did-இன் சரியான வடிவத்தையோ கொண்டிருக்கும்."),
    GrammarPoint(
      heading: "5",
      tamilHeading: "விதி 5",
      explanation: "An affirmative statement takes a negative tag; a negative statement takes a positive tag.", tamilExplanation: "உறுதிமொழி வாக்கியத்திற்கு மறுப்பு tag; மறுப்பு வாக்கியத்திற்கு உறுதிமொழி tag வரும்.",
      examples: ["The boy is neat, isn't he? (Negative tag)", "The boy is not neat, is he? (Positive tag)"],
    ),
    GrammarPoint(heading: "6", tamilHeading: "விதி 6", explanation: "There is always a comma between the statement and the question tag, and the question ends with a question mark.", tamilExplanation: "வாக்கியத்துக்கும் tag-க்கும் இடையே எப்போதும் காற்புள்ளி (,) வரும்; வினா கேள்விக்குறியுடன் (?) முடியும்."),
  ],
  fillSets: const [
    GrammarFillSet(
      id: "question_tags_fill",
      title: "Add the Question Tag",
      tamilTitle: "வினாத் தொகுப்பைச் சேர்க்கவும்",
      emoji: "❓",
      instructions: "Add a suitable question tag to each statement.",
      tamilInstructions: "ஒவ்வொரு வாக்கியத்திற்கும் பொருத்தமான வினாத் தொகுப்பைச் சேர்க்கவும்.",
      items: [
        GrammarFillItem(prompt: "Your friend is an engineer", answer: "Your friend is an engineer, isn't he?", tamilHint: "positive statement → negative tag"),
        GrammarFillItem(prompt: "She can speak English", answer: "She can speak English, can't she?", tamilHint: "positive statement → negative tag"),
        GrammarFillItem(prompt: "You must take this medicine", answer: "You must take this medicine, mustn't you?", tamilHint: "positive statement → negative tag"),
        GrammarFillItem(prompt: "They came rather late for the party", answer: "They came rather late for the party, didn't they?", tamilHint: "'came' → Did-tag"),
        GrammarFillItem(prompt: "George likes coffee", answer: "George likes coffee, doesn't he?", tamilHint: "'likes' → Does-tag"),
      ],
    ),
  ],
);

// ============================================================
// All Module 3 topics, in book order
// ============================================================
final List<GrammarTopic> grammarTopics = [
  _sentenceTopic,
  _partsOfSpeechTopic,
  _nounTopic,
  _nounNumberTopic,
  _pronounTopic,
  _adjectiveTopic,
  _wordFormationTopic,
  _verbTopic,
  _verbAgreementTopic,
  _tensesTopic,
  _sequenceOfTensesTopic,
  _voiceTopic,
  _adverbTopic,
  _clauseTopic,
  _prepositionTopic,
  _articlesTopic,
  _questionTagsTopic,
];
