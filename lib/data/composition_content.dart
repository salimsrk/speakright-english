// Module 5 · Composition — content, transcribed and cross-checked
// directly against the course book's page images (book pages 69-75,
// "MODULE - V COMPOSITION - A" through the book's closing page,
// "COMPOSITION - B: DEVELOPING HINTS"). Page 75 is the last page of the
// book — it ends with a small decorative flower-basket image after the
// fifth hint, so this module completes the whole book.
//
// Book-error corrections made while transcribing (single obvious
// print/OCR slips, not rewrites):
//  - Passage 1 (Corruption): "policy objections" -> "policy objectives"
//    (repeats the earlier, correct "policy objectives"; "objections"
//    doesn't fit the sentence).
//  - Passage 2 (Mother Teresa): "as profound as profound as" -> "as
//    profound as" (duplicated words); "behests" -> "bequests" (the
//    sentence is about donations and money left to her in wills);
//    "ministered on encountered" -> "ministered to" (garbled ending).
//  - Passage 3 (IRMA): "came to being" -> "came into being";
//    "co-operation, NGOs" -> "co-operatives, NGOs" (IRMA works with
//    co-operative societies, not with the abstract idea "co-operation"
//    twice); "development organsitions" -> "development organisations".
//  - Passage 4: heading "INDENTITY" -> "IDENTITY"; "Nancy Chodovow" ->
//    "Nancy Chodorow" (the real sociologist this book is quoting);
//    "sterotype" -> "stereotype".
//  - Passage 5: heading "REARED BEHAVIOURS" -> "LEARNED BEHAVIOURS"
//    (the passage's own repeated point is that reactions are learned;
//    "reared" doesn't fit and the body text below uses "learned early
//    in our lives"); "the way me react" -> "the way we react".
//  - Model Letters intro: the book's sentence is cut short ("...evolve
//    such writing skills to begin with observe the") — completed as
//    "...evolve such writing skills. To begin with, observe the
//    following:" to make it a complete sentence introducing the list
//    that follows it.
//  - Developing Hints: "a dove files past" -> "flies past"; "a boy
//    takes aim the dove bee stings" -> "a boy takes aim at the dove —
//    the bee stings him" (a word was clearly dropped); "tells his to
//    lay" -> "tells him to lay"; "good one's" -> "good ones"; "once
//    climbs up a tree" -> "one climbs up a tree"; "asks the other what
//    the bear —" -> "... what the bear said to him" (a word was
//    dropped before the dash).

import '../models/composition.dart';

// ============================================================
// Reading passages ("Improve Your Reading Skill")
// ============================================================
final List<ReadingPassage> readingPassages = [
  ReadingPassage(
    title: "Corruption as Human Rights Violation",
    tamilTitle: "ஊழல் — மனித உரிமை மீறல்",
    byline: "By C. Raj Kumar, Courtesy \"The Hindu\"",
    emoji: "⚖️",
    passage:
        "Having recognized that corruption affects human rights and the rule "
        "of law, it is important for the NHRC to develop the right to "
        "corruption-free governance, through a number of rights-based "
        "strategies in India. Rights-based approaches to governance are "
        "those strategies that rest on the conceptual foundation that "
        "social and economic goals do not remain policy objectives, but get "
        "transformed into rights that are vested with the citizenry — "
        "increasing incentives for public vigilance. In this conception "
        "there are \"right-bearers\" and \"duty-holders\": the people will "
        "have rights relating to various social and economic goals that "
        "were hitherto described as policy objectives. The representatives "
        "of the government are vested with the duty of ensuring the "
        "protection and promotion of the particular right.",
    tamilSummary:
        "ஊழல் மனித உரிமைகளையும் சட்டத்தின் ஆட்சியையும் பாதிக்கிறது என்பதை "
        "ஏற்றுக்கொண்டு, குடிமக்களுக்கு உரிமைகள் அடிப்படையிலான அணுகுமுறைகள் மூலம் "
        "ஊழல் இல்லா ஆட்சியை உருவாக்குவது முக்கியம் என்பதை இந்தக் கட்டுரை "
        "விளக்குகிறது.",
  ),
  ReadingPassage(
    title: "Mother Teresa",
    tamilTitle: "அன்னை தெரேசா",
    byline: "By Naveen Chawla",
    emoji: "🕊️",
    passage:
        "Throughout her life Mother Teresa remained humble, simple, and in "
        "many senses an ordinary woman. Yet she led one of the most "
        "extraordinary lives of the twentieth century. She was not erudite, "
        "but her distilled wisdom was as profound as that of any "
        "philosopher saint. She believed in taking one small step at a "
        "time, yet she handled several complex activities simultaneously "
        "in many parts of the world. She gratefully acknowledged the "
        "millions in donations and bequests that made her work possible, "
        "but remembered only the 'sacrifice' money, like that of the "
        "little Calcutta boy who ate no sugar for three days to offer her "
        "one rupee that was thus saved. Although she lived and worked in "
        "largely Hindu India, she made no attempt at conversion. "
        "Conversion, she said, was God's work, not hers. In reflecting "
        "this position, she also astutely conformed to her environment, "
        "while at the same time being faithful to Jesus, whom she saw in "
        "all those she ministered to.",
    tamilSummary:
        "தாழ்மையும் எளிமையும் கொண்ட அன்னை தெரேசா, சிறிய அடிகளாக பெரிய "
        "சேவைகளைச் செய்தார். மதமாற்றம் தன் வேலை இல்லை என்று அவர் தெளிவாகக் "
        "கூறினார், இந்தியச் சூழலுக்கு ஏற்ப தன்னை மாற்றிக்கொண்டே இயேசுவுக்கு "
        "உண்மையாக இருந்தார்.",
  ),
  ReadingPassage(
    title: "Grooming India's Rural Managers",
    tamilTitle: "இந்தியாவின் கிராமப்புற மேலாளர்களை உருவாக்குதல்",
    emoji: "🌾",
    passage:
        "The Institute of Rural Management, Anand — popularly known as "
        "IRMA — has grown to become a towering institution for "
        "professional management of rural organizations since it came "
        "into being in 1979.\n\n"
        "This institution in the country's milk capital Anand, Gujarat, "
        "was founded at the initiation of the National Dairy Development "
        "Board (NDDB) with the support of the State and Central "
        "governments and the Swiss Development Cooperation. It has been "
        "closely working with co-operatives, NGOs, governments, and "
        "national and international agencies. IRMA got very high ratings "
        "in recent surveys. It holds an enviable reputation in terms of "
        "industry interface and international linkages.\n\n"
        "Apart from giving research and consultation services for "
        "improving the management of rural organizations and programmes, "
        "IRMA offers post-graduate and doctoral programmes in rural "
        "management. Its programme in rural management (PRM) is one of "
        "the best in the country for those aspiring to undertake "
        "challenging managerial responsibilities in the rural "
        "co-operative sector and development organisations.",
    tamilSummary:
        "1979ல் தொடங்கப்பட்ட IRMA (Institute of Rural Management, Anand), "
        "கிராமப்புற நிறுவனங்களை தொழில்முறையாக நிர்வகிக்க பயிற்சி அளிக்கும் "
        "முன்னணி நிறுவனமாக வளர்ந்துள்ளது.",
  ),
  ReadingPassage(
    title: "Are Women More Dependent on Relationships for Identity?",
    tamilTitle: "பெண்கள் தங்கள் அடையாளத்திற்கு உறவுகளை அதிகம் சார்ந்திருக்கிறார்களா?",
    byline: "By Dr. Alan Loy McGinnis",
    emoji: "🧩",
    passage:
        "Most studies show that women have more difficulty establishing "
        "their singularity than men. The old stereotype is that men live "
        "for their work and women live for love; hence, when a "
        "relationship ends, a divorce occurs, or a friendship blows up, it "
        "is harder on women than on men.\n\n"
        "Does that mean that women are by nature weaker and more "
        "dependent? Not at all. It has to do with the fact that most small "
        "children spend more time during their early years with their "
        "mothers than they do with their fathers. Nancy Chodorow has done "
        "some illuminating work in this area. She points out that a "
        "little boy soon realizes that he is not like his mother and that "
        "he must differentiate himself from this person. Masculinity is "
        "defined by separation. A girl, on the other hand, feels no such "
        "need and remains close to her mother. These facts have great "
        "consequences for the way we cope when we become adults. Males "
        "often grow up being good at independence, but having trouble "
        "with closeness. Females often grow up being good at "
        "relationships but having problems with independence.",
    tamilSummary:
        "சிறு வயதில் தாயுடன் நெருக்கமாக இருப்பதால், பெண்கள் உறவுகளில் "
        "திறமையாகவும், தனித்து நிற்பதில் சிரமமாகவும் இருக்கலாம் என்றும், "
        "ஆண்கள் தன்னிச்சையில் திறமையாகவும், நெருக்கத்தில் சிரமமாகவும் "
        "இருக்கலாம் என்றும் இந்தக் கட்டுரை விளக்குகிறது.",
  ),
  ReadingPassage(
    title: "How Do You React to Conflicts?",
    tamilTitle: "முரண்பாடுகளுக்கு நீங்கள் எப்படி எதிர்வினையாற்றுகிறீர்கள்?",
    emoji: "🤝",
    passage:
        "Reactions are learned behaviours.\n\n"
        "People react to conflicts differently, some calmly and others "
        "with an explosive response. Some people flee from the conflict, "
        "and others come back fighting. Some individuals look for ways to "
        "negotiate, while others keep pushing to get their own way. Just "
        "as conflicts come in many forms, so do our reactions.\n\n"
        "Often the way we react to conflicts is also based on how we "
        "experienced conflicts growing up. Most likely, today's reactions "
        "are based on yesterday's model. As you were growing up, how did "
        "those around you deal with conflicts? What messages did your "
        "parents, teachers, religious leaders and scoutmasters give you?\n\n"
        "Our reactions to conflicts were learned early in our lives. "
        "These patterns are well ingrained into our adult behaviour and "
        "attitudes. Fortunately, we can re-learn and modify the way we "
        "react to conflicts.\n\n"
        "Reviewing the ways you react to conflict is another piece of the "
        "puzzle for understanding how conflicts work. Often a heightened "
        "awareness of how we react can help keep some conflicts from "
        "escalation; we can choose how we react. We can actually learn new "
        "and better ways to react when we have conflicts.",
    tamilSummary:
        "முரண்பாடுகளுக்கு நாம் எப்படி எதிர்வினையாற்றுகிறோம் என்பது சிறுவயதிலேயே "
        "கற்றுக்கொள்ளப்பட்டது. அதை நாம் மீண்டும் கற்று, சிறந்த முறையில் "
        "எதிர்வினையாற்ற மாற்றிக்கொள்ள முடியும்.",
  ),
];

// ============================================================
// Model Letters ("Requisitions")
// ============================================================
const List<String> letterWritingTips = [
  "Format is official.",
  "Salutation is official.",
  "State the subject.",
  "Introduce yourself.",
  "State the purpose.",
  "Make your request or prayer.",
  "Be clear in your request.",
  "Close the letter with a Thank you and signature.",
];

const String letterWritingIntro =
    "Students normally face difficulty in expressing their thoughts in "
    "English while making official requests through formal letters to "
    "the college, authorities, or for any other official matter. Model "
    "formats are given below. Observe these formats and evolve such "
    "writing skills. To begin with, observe the following:";

const String letterWritingTamilIntro =
    "கல்லூரி அல்லது அதிகாரிகளுக்கு முறையான கடிதங்கள் மூலம் வேண்டுகோள் "
    "வைக்கும்போது, மாணவர்கள் ஆங்கிலத்தில் தங்கள் எண்ணங்களை வெளிப்படுத்த "
    "சிரமப்படுவார்கள். கீழே கொடுக்கப்பட்டுள்ள மாதிரி வடிவங்களை கவனித்து அந்த "
    "எழுத்துத் திறனை வளர்த்துக் கொள்ளுங்கள்.";

final List<ModelLetter> modelLetters = [
  ModelLetter(
    title: "Request for Bonafide Certificate",
    tamilTitle: "பொருந்தும் சான்றிதழுக்கான கோரிக்கை",
    emoji: "📄",
    dateLine: "Date: 01.07.2007, Tiruchy",
    subject: "Sub: Request for Bonafide Certificate.",
    body: [
      "Respected Sir,",
      "I am a student of I B.A., Economics class; my Roll No. is 02416.",
      "I am a day scholar residing at Tiruverambur. Kindly furnish me with a 'Bonafide Certificate' to help me avail a 'Bus Pass' from the Transport authority concerned.",
      "Thank You,",
      "Yours Faithfully,\n(Signature)",
    ],
  ),
  ModelLetter(
    title: "Request for Conduct / Transfer Certificate",
    tamilTitle: "நடத்தை / மாற்றுச் சான்றிதழுக்கான கோரிக்கை",
    emoji: "📄",
    dateLine: "Date: 02.07.2007, Tiruchy",
    subject: "Sub: Request for Conduct Certificate, Transfer Certificate etc.,",
    body: [
      "Respected Sir,",
      "I was a student of the I B.Sc., Mathematics class from 2004 to 2007. I request you to furnish me with my Conduct Certificate and Transfer Certificate.",
      "I have enclosed the 'No Dues Certificate' from the department concerned.",
      "Thank You,",
      "Yours Faithfully,\n(Signature)",
    ],
  ),
];

// ============================================================
// Composition — B: Developing Hints
// ============================================================
final List<StoryHint> storyHints = [
  StoryHint(
    title: "The Bee and the Dove",
    tamilTitle: "தேனீயும் புறாவும்",
    emoji: "🐝",
    hint:
        "A bee — falls into a tank — a dove flies past — drops a large leaf "
        "into the water — the bee climbs onto the leaf — flies away — a "
        "boy takes aim at the dove — the bee stings him — the dove is "
        "saved.",
    sampleStory:
        "A bee, while drinking water at a tank, slipped and fell in. Unable "
        "to fly with its wet wings, it was in danger of drowning. Just "
        "then a dove flew past, saw the bee struggling, and dropped a "
        "large leaf into the water. The bee climbed onto the leaf, dried "
        "its wings, and flew safely away. Some days later, a boy crept up "
        "with a catapult and took aim at the dove, which was resting on a "
        "branch, unaware of the danger. The bee, seeing this, darted "
        "forward and stung the boy sharply on the hand. He cried out and "
        "missed his aim, and the dove flew away unharmed — saved, in turn, "
        "by the very bee it had once rescued.",
  ),
  StoryHint(
    title: "The Hen That Laid Golden Eggs",
    tamilTitle: "பொன் முட்டையிடும் கோழி",
    emoji: "🥚",
    hint:
        "A man has a hen which lays a golden egg everyday — the man "
        "collects ten eggs in ten days, then he gets impatient — wants to "
        "become rich overnight — kills the hen.",
    sampleStory:
        "A poor man owned a hen that laid one golden egg every day. Each "
        "morning he sold the egg and slowly grew richer. After ten days, "
        "with ten golden eggs sold, he grew impatient — why wait a whole "
        "day for just one egg, when the hen's body must be full of gold "
        "all at once? Unable to control his greed, he killed the hen and "
        "cut it open, only to find it was an ordinary hen inside, with no "
        "gold at all. In trying to get rich overnight, he had destroyed "
        "the very source of his good fortune.",
  ),
  StoryHint(
    title: "The Good Boy and the Rotten Apple",
    tamilTitle: "நல்ல பையனும் அழுகிய ஆப்பிளும்",
    emoji: "🍎",
    hint:
        "A good boy — disobeys his parents — gets into bad company — "
        "father gives him some apples — tells him to lay them aside for a "
        "few days. Places a rotten apple among them — the rotten apple "
        "spoils the good ones — a lesson on bad company.",
    sampleStory:
        "A good boy began disobeying his parents and mixing with a bad "
        "group of friends at school. Worried, his father tried to reason "
        "with him, but the boy insisted his friends' company could not "
        "possibly harm him. One day, the father gave him a basket of fresh "
        "apples and asked him to set them aside for a few days, having "
        "secretly placed one rotten apple among them. A few days later, "
        "the boy found that the rotten apple had spoiled almost all the "
        "good ones around it. 'This is exactly what bad company does to a "
        "good person,' his father said — and the boy finally understood.",
  ),
  StoryHint(
    title: "The Two Friends and the Bear",
    tamilTitle: "இரு நண்பர்களும் கரடியும்",
    emoji: "🐻",
    hint:
        "Two men travelling through a forest — agree to help each other "
        "in danger — suddenly a bear appears — one climbs up a tree — the "
        "other lies down on the ground and holds his breath — the bear "
        "comes up to him — smells his face — thinks he is dead — goes "
        "away — the first man now comes down — asks the other what the "
        "bear said to him — answer: \"Beware of a friend who runs away in "
        "time of danger.\"",
    sampleStory:
        "Two friends were travelling through a forest and promised to "
        "help each other if danger came. Suddenly a bear appeared. One "
        "man, without a thought for his friend, scrambled up a tree. The "
        "other, with no time to escape, dropped flat to the ground and "
        "held his breath, pretending to be dead. The bear came up, sniffed "
        "at his face and ears, and, believing him dead, lumbered away. "
        "Once it was gone, the first man climbed down and asked, "
        "laughing, 'What did the bear whisper in your ear?' His friend "
        "replied gravely, 'It told me to beware of a friend who runs away "
        "in time of danger.'",
  ),
  StoryHint(
    title: "King Solomon and the Queen of Sheba",
    tamilTitle: "சாலமன் அரசனும் சீபா ராணியும்",
    emoji: "👸",
    hint:
        "King Solomon, noted for his wisdom — the Queen of Sheba heard of "
        "his fame — came to visit — impressed by his wealth and grandeur "
        "— wanted to test his power of solving puzzles — showed him two "
        "garlands of flowers, one in her right hand and one in her left — "
        "one real, the other artificial — asks, 'Which is which?' — "
        "courtiers puzzled — both garlands look the same — Solomon silent "
        "— queen feels triumphant — Solomon orders the windows to be "
        "opened — bees fly in from the garden — buzz about the queen — "
        "all settle on the garland in her right hand — Solomon says the "
        "flower in the right hand is real, the one in the left is "
        "artificial — the queen is impressed with his wisdom.",
    sampleStory:
        "King Solomon was famous throughout the land for his wisdom. When "
        "the Queen of Sheba heard of his fame, she travelled to his court "
        "to see for herself, and was dazzled by his wealth and grandeur. "
        "Still, she wished to test his wisdom with a puzzle. She held up "
        "two garlands of flowers, one in each hand — one real, the other "
        "so skilfully made that it looked exactly the same — and asked, "
        "'Which is real, and which is artificial?' The courtiers stared "
        "and could not tell. Solomon said nothing for a moment, then "
        "quietly ordered the windows of the hall to be opened. At once, "
        "bees from the garden outside flew in, buzzed around the queen, "
        "and settled only on the garland in her right hand. 'The flower "
        "in your right hand is real,' Solomon said, 'the one in your left "
        "is artificial — the bees know real nectar when they find it.' "
        "The queen was deeply impressed, for his wisdom had triumphed "
        "without a single word of guesswork.",
  ),
];
