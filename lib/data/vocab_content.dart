import '../models/vocab.dart';

/// SpeakRight English — Module II: VOCABULARY
/// Content digitized directly from the uploaded course book
/// (English_Book_Digitized.docx, paragraphs 92-251, tables 9-31),
/// cross-checked against the scanned original (pages 12-17) for the
/// image-only puzzles that have no extractable text.
///
/// Every English item below has a Tamil gloss alongside it (matching the
/// approach used in Module I), except the syllable-count word lists and
/// silent-letter example words, which get one Tamil rule-note per group
/// instead of a per-word gloss (there's no "meaning" to translate for a
/// bare word list — the point there is pronunciation, not vocabulary).
///
/// Two places needed a judgement call because the book's own answer key
/// was missing or unusable, per Salim's go-ahead to use standard answers
/// now and revise later if the client wants something different:
///  - The LEMONADE "connect the theme" quiz (no answer key in the book at
///    all) — answers below are the standard/expected ones.
///  - The Country/Currency matching table lists "Sterling" as one of the
///    9 currencies but no European country among the 9 listed countries;
///    New Zealand is matched to Sterling below via its historical
///    Commonwealth currency link — flagged here as the one assumption.
/// Two puzzles from the scanned pages (the bottle-contents riddle and the
/// 26-letter crossword) are pure images with no legible answer anywhere
/// in the book — they're included as open reference items with no
/// solution, rather than guessed.

// ---------------------------------------------------------------------
// 1) DIFFICULT / EASIER WORDS  (70 pairs)
// ---------------------------------------------------------------------
final WordGroup difficultEasyWords = WordGroup(
  id: "difficult_easy",
  title: "Difficult Words & Their Easier Words",
  tamilTitle: "கடினமான வார்த்தைகளும் அவற்றின் எளிய வார்த்தைகளும்",
  leftLabel: "Difficult word",
  rightLabel: "Easier word",
  emoji: "📖",
  pairs: const [
    WordPair("Accessory", "Additional", tamilB: "கூடுதலான"),
    WordPair("Commutation", "Exchange", tamilB: "பரிமாற்றம்"),
    WordPair("Derelict", "Abandoned", tamilB: "கைவிடப்பட்ட"),
    WordPair("Tentative", "Experimental", tamilB: "பரிசோதனை முறையிலான"),
    WordPair("Eschew", "Avoid", tamilB: "தவிர்"),
    WordPair("Adversary", "Enemy", tamilB: "எதிரி"),
    WordPair("Fortuitous", "Accidental", tamilB: "தற்செயலான"),
    WordPair("Reverberate", "Echo", tamilB: "எதிரொலி"),
    WordPair("Audacious", "Bold", tamilB: "தைரியமான"),
    WordPair("Valediction", "Farewell", tamilB: "பிரியாவிடை"),
    WordPair("Impeccable", "Blameless", tamilB: "குற்றமற்ற"),
    WordPair("Obese", "Fat", tamilB: "குண்டான"),
    WordPair("Terminus", "Boundary", tamilB: "எல்லை"),
    WordPair("Decrepit", "Feeble", tamilB: "பலவீனமான"),
    WordPair("Alacrity", "Briskness", tamilB: "சுறுசுறுப்பு"),
    WordPair("Plenary", "Fuel", tamilB: "எரிபொருள்"),
    WordPair("Benediction", "Blessing", tamilB: "ஆசீர்வாதம்"),
    WordPair("Plenitude", "Fullness", tamilB: "முழுமை"),
    WordPair("Felicitation", "Congratulation", tamilB: "வாழ்த்து"),
    WordPair("Fecundity", "Fruitfulness", tamilB: "பலனுள்ள தன்மை"),
    WordPair("Vanquish", "Conquer", tamilB: "வெற்றி கொள்"),
    WordPair("Amicable", "Friendly", tamilB: "நட்பான"),
    WordPair("Ludicrous", "Comical", tamilB: "சிரிப்பூட்டும்"),
    WordPair("Aptitude", "Fitness", tamilB: "தகுதி"),
    WordPair("Frigid", "Cold", tamilB: "குளிர்ந்த"),
    WordPair("Ignominy", "Disgrace", tamilB: "அவமானம்"),
    WordPair("Coagulation", "Clotting", tamilB: "உறைதல்"),
    WordPair("Inundate", "Flood", tamilB: "வெள்ளம்"),
    WordPair("Masticate", "Chew", tamilB: "மெல்லுதல்"),
    WordPair("Vertigo", "Giddiness", tamilB: "தலைச்சுற்றல்"),
    WordPair("Tranquil", "Calm", tamilB: "அமைதியான"),
    WordPair("Tardy", "Slow", tamilB: "மெதுவான"),
    WordPair("Ambiguous", "Doubtful", tamilB: "சந்தேகத்திற்குரிய"),
    WordPair("Veracity", "Truth", tamilB: "உண்மை"),
    WordPair("Inebriate", "Drunk", tamilB: "குடிபோதையிலான"),
    WordPair("Incessant", "Unceasing", tamilB: "நிற்காத"),
    WordPair("Decadence", "Decay", tamilB: "சிதைவு"),
    WordPair("Undulate", "Wavy", tamilB: "அலை போன்ற"),
    WordPair("Lethal", "Deadly", tamilB: "கொல்லும் தன்மையுள்ள"),
    WordPair("Oscillate", "Waver", tamilB: "தயங்கு"),
    WordPair("Elucidate", "Explain", tamilB: "விளக்கு"),
    WordPair("Adjacent", "Near", tamilB: "அருகில் உள்ள"),
    WordPair("Gigantic", "Huge", tamilB: "மிகப்பெரிய"),
    WordPair("Anonymous", "Nameless", tamilB: "பெயர் தெரியாத"),
    WordPair("Recluse", "Hermit", tamilB: "துறவி"),
    WordPair("Elliptical", "Oval", tamilB: "நீள்வட்டமான"),
    WordPair("Deleterious", "Hurtful", tamilB: "தீங்கு விளைவிக்கும்"),
    WordPair("Pristine", "Original", tamilB: "மூலமான"),
    WordPair("Animosity", "Hatred", tamilB: "வெறுப்பு"),
    WordPair("Collateral", "Parallel", tamilB: "இணையான"),
    WordPair("Inadequate", "Insufficient", tamilB: "போதுமானதாக இல்லாத"),
    WordPair("Tableau", "Picture", tamilB: "படம்"),
    WordPair("Inexorable", "Inflexible", tamilB: "மாற்ற முடியாத"),
    WordPair("Lucrative", "Profitable", tamilB: "லாபகரமான"),
    WordPair("Facetious", "Jocular", tamilB: "நகைச்சுவையான"),
    WordPair("Enigma", "Puzzle", tamilB: "புதிர்"),
    WordPair("Erudite", "Learned", tamilB: "கல்வி கற்ற"),
    WordPair("Pristine", "Original", tamilB: "மூலமான"),
    WordPair("Indolent", "Lazy", tamilB: "சோம்பேறியான"),
    WordPair("Vilify", "Slander", tamilB: "அவதூறு செய்"),
    WordPair("Clemency", "Leniency", tamilB: "இரக்கம்"),
    WordPair("Garrulous", "Talkative", tamilB: "அதிகம் பேசுகிற"),
    WordPair("Hilarious", "Merry", tamilB: "மகிழ்ச்சியான"),
    WordPair("Mendacious", "Untruthful", tamilB: "பொய்யான"),
    WordPair("Incarcerate", "Imprison", tamilB: "சிறையில் அடை"),
    WordPair("Mundane", "Worldly", tamilB: "உலகியல் சார்ந்த"),
    WordPair("Miscellaneous", "Mixed", tamilB: "கலந்த"),
    WordPair("Nefarious", "Wicked", tamilB: "தீயவனான"),
    WordPair("Matrimony", "Marriage", tamilB: "திருமணம்"),
    WordPair("Humidity", "Moisture", tamilB: "ஈரப்பதம்"),
  ],
);

// ---------------------------------------------------------------------
// 2) IDIOMS & EXPRESSIONS  (41 pairs)
// ---------------------------------------------------------------------
final WordGroup idioms = WordGroup(
  id: "idioms",
  title: "Idioms & Expressions",
  tamilTitle: "மரபுத் தொடர்களும் அவற்றின் பொருளும்",
  leftLabel: "Expression",
  rightLabel: "Meaning",
  emoji: "💬",
  pairs: const [
    WordPair("Above all", "Chiefly, before everything else", tamilB: "எல்லாவற்றுக்கும் மேலாக, முதன்மையாக"),
    WordPair("Above-board", "Not open to question, honest, straight forward, beyond reproach",
        tamilB: "மறைவின்றி நேர்மையான, நம்பகமான"),
    WordPair("Above-par", "Of superior quality", tamilB: "உயர்ந்த தரமான"),
    WordPair("To break the back of anything", "To perform the most difficult part of it",
        tamilB: "மிகக் கடினமான பகுதியை முடித்துவிடுதல்"),
    WordPair("To get one's back up", "To rouse one's anger", tamilB: "கோபத்தை எழுப்புதல்"),
    WordPair("To backbite a person", "To slander or to speak ill of someone", tamilB: "மறைவாக பழி சொல்லுதல்"),
    WordPair("He is the backbone of the team", "He is the one on whom his team mainly relies for its successes",
        tamilB: "அணியின் வெற்றிக்கு முக்கிய ஆதாரமாக இருப்பவர்"),
    WordPair("He has no backbone", "He has no will of his own", tamilB: "சொந்த மன உறுதி இல்லாதவர்"),
    WordPair("Backstairs influence", "Influence exerted in an underhand or clandestine manner",
        tamilB: "மறைமுக செல்வாக்கு"),
    WordPair("If the cap fits, wear it", "If you think the remarks made refer to you, then act accordingly",
        tamilB: "குறிப்பு உங்களைப் பற்றியதென்றால் ஏற்றுக்கொள்ளுங்கள்"),
    WordPair("To let the cat out of the bag", "To expose the trick; to let out the secret beforehand",
        tamilB: "இரகசியத்தை முன்னரே வெளியிடுதல்"),
    WordPair("She is no chicken", "She is older than she says, or appears to be", tamilB: "தோற்றத்தை விட வயதானவர்"),
    WordPair("Chicken-hearted", "Weak, timid, cowardly", tamilB: "பயந்தாங்கொள்ளித்தனமான"),
    WordPair("Don't count your chickens before they are hatched",
        "Don't calculate your gains before they are realized", tamilB: "கிடைக்கும் முன்பே லாபத்தை எண்ணாதே"),
    WordPair("A dare-devil", "A fearless, reckless man", tamilB: "அச்சமற்ற துணிச்சலான மனிதன்"),
    WordPair("Give a dog a bad name and hang him",
        "Once a person loses his reputation, he is likely to be blamed for the misdeeds of others",
        tamilB: "பெயர் கெட்டவுடன் மற்றவர் தவறுக்கும் குற்றம் சுமத்தப்படுவான்"),
    WordPair("Every dog has his day", "Sooner or later everyone has his share of good fortune",
        tamilB: "எல்லோருக்கும் ஒரு நல்ல நாள் வரும்"),
    WordPair("To be a dog in the manger", "To prevent others from using what one cannot use oneself, to be selfish",
        tamilB: "தானும் பயன்படுத்தாமல் மற்றவரையும் பயன்படுத்த விடாத சுயநலம்"),
    WordPair("Draconian legislation",
        "Very severe laws (From Draco, an Athenian legislator, whose laws were extremely severe)",
        tamilB: "மிகக் கடுமையான சட்டங்கள்"),
    WordPair("Eagle eye", "Quick to discover, very discerning", tamilB: "கூர்மையான கவனிப்பு உள்ளவர்"),
    WordPair("At the eleventh hour", "At the last moment", tamilB: "கடைசி நேரத்தில்"),
    WordPair("Bad faith", "Dishonest intentions", tamilB: "நேர்மையற்ற எண்ணம்"),
    WordPair("In good faith", "With honest intentions", tamilB: "நேர்மையான எண்ணத்துடன்"),
    WordPair("A breach of faith", "To act contrary to what one had professed",
        tamilB: "சொன்னதற்கு மாறாக நடத்தல், நம்பிக்கை துரோகம்"),
    WordPair("The game is up", "All is lost, everything has failed", tamilB: "எல்லாம் முடிந்துவிட்டது"),
    WordPair("To have the game in one's hand", "To be certain of winning",
        tamilB: "வெற்றி நிச்சயம் என்ற நிலையில் இருத்தல்"),
    WordPair("To play the game", "To act fairly and honourably", tamilB: "நேர்மையாக நடந்துகொள்ளுதல்"),
    WordPair("He has a green eye", "He is jealous", tamilB: "பொறாமை உள்ளவர்"),
    WordPair("To have one's heart in one's mouth", "To be afraid", tamilB: "பயத்தில் இருத்தல்"),
    WordPair("His heart is in his boots", "He is a coward", tamilB: "கோழையாக இருத்தல்"),
    WordPair("To be in hot water", "To be in trouble or difficulty", tamilB: "சிக்கலில் இருத்தல்"),
    WordPair("To break the ice", "To be the first person to begin; to prepare the way",
        tamilB: "தொடங்கி வைத்தல், ஆரம்பத் தடையை உடைத்தல்"),
    WordPair("To buy a pig in a poke", "To purchase something on mere reputation and without examining it beforehand",
        tamilB: "பரிசோதிக்காமல் நம்பிக்கையில் வாங்குதல்"),
    WordPair("Red flag", "The symbol of revolution", tamilB: "புரட்சியின் அடையாளம்"),
    WordPair("To be caught red-handed", "To be caught in the very act of committing a crime",
        tamilB: "குற்றம் செய்யும்போதே பிடிபடுதல்"),
    WordPair("To draw a red-herring across the trail", "To turn attention from the real issue by irrelevant discussion",
        tamilB: "உண்மையான விஷயத்திலிருந்து கவனத்தை திசை திருப்புதல்"),
    WordPair("Red-letter day", "A memorable day; a day of great importance",
        tamilB: "மறக்க முடியாத முக்கியமான நாள்"),
    WordPair("Red-tape",
        "A term used to describe the delay in attending to matters in government departments because of official routine and formality",
        tamilB: "அரசு அலுவலக வழக்கத்தால் ஏற்படும் தாமதம்"),
    WordPair("A close shave", "A narrow escape", tamilB: "சிறிதில் தப்பித்தல்"),
    WordPair("To be on tenterhooks", "To be in a state of suspense and anxiety",
        tamilB: "பதற்றமும் ஏக்கமும் நிறைந்த நிலை"),
    WordPair("If wishes were horses, beggars might ride", "If all people's wishes came true everybody would be rich",
        tamilB: "ஆசைகள் நிறைவேறினால் எல்லோரும் செல்வந்தராவர்"),
  ],
);

// ---------------------------------------------------------------------
// 3) CATEGORY WORD LISTS  (13 lists, 115 pairs total)
// ---------------------------------------------------------------------
final WordGroup collectiveNouns = WordGroup(
  id: "collective_nouns",
  title: "Words Denoting Groups (Collective Nouns)",
  tamilTitle: "கூட்டங்களைக் குறிக்கும் வார்த்தைகள்",
  leftLabel: "Word",
  rightLabel: "Meaning",
  emoji: "🐦",
  pairs: const [
    WordPair("Flight", "A number of birds, bees or insects moving together", tamilB: "பறவைகள், தேனீக்கள் அல்லது பூச்சிகளின் திரள்"),
    WordPair("Pack", "A number of wolves, hounds or submarines", tamilB: "ஓநாய், நாய் அல்லது நீர்மூழ்கிக் கப்பல்களின் கூட்டம்"),
    WordPair("Troops", "A number of lions, monkeys or cavalry of soldiers", tamilB: "சிங்கம், குரங்கு அல்லது படைவீரர்களின் கூட்டம்"),
    WordPair("Litter", "A number of young pigs, dogs, cats brought forth at one birth", tamilB: "ஒரே ஈற்றில் பிறந்த குட்டிகளின் தொகுதி"),
    WordPair("Congregation", "A number of people at church", tamilB: "தேவாலயத்தில் கூடும் மக்கள் கூட்டம்"),
    WordPair("Audience", "A number of people listening to a concert or lecture", tamilB: "இசை நிகழ்ச்சி/சொற்பொழிவு கேட்பவர்களின் கூட்டம்"),
    WordPair("Spectators", "A number of people looking on at a football match etc.", tamilB: "விளையாட்டைப் பார்க்கும் பார்வையாளர் கூட்டம்"),
    WordPair("Crowd", "A number of people collected together in the street", tamilB: "தெருவில் கூடும் மக்கள் திரள்"),
    WordPair("Coterie", "A number of people who get together to work for some cause or common interest", tamilB: "ஒரு நோக்கத்திற்காக கூடும் நண்பர்கள் குழு"),
    WordPair("Mob, rabble", "A number of disorderly people", tamilB: "ஒழுங்கற்ற மக்கள் கூட்டம்"),
    WordPair("Gang", "A number of workmen, prisoners, thieves etc.", tamilB: "தொழிலாளர், கைதிகள், திருடர்களின் குழு"),
    WordPair("Convoy", "A number of merchant ships protected by warships", tamilB: "போர்க்கப்பல்களால் பாதுகாக்கப்படும் வணிகக் கப்பல் கூட்டம்"),
    WordPair("Suite", "A set of furniture, rooms etc.", tamilB: "தளபாடங்கள்/அறைகளின் தொகுதி"),
  ],
);

final WordGroup dwellings = WordGroup(
  id: "dwellings",
  title: "Words Denoting Places (Dwellings & Storage)",
  tamilTitle: "இடங்களைக் குறிக்கும் வார்த்தைகள்",
  leftLabel: "Word",
  rightLabel: "Meaning",
  emoji: "🏠",
  pairs: const [
    WordPair("Kennel", "A house or shelter for a dog", tamilB: "நாய்க்கு வசிப்பிடம்"),
    WordPair("Stable", "A house or shelter for a horse", tamilB: "குதிரைக்கு வசிப்பிடம்"),
    WordPair("Pen, byre", "A house or shelter for a cow", tamilB: "மாட்டிற்கு வசிப்பிடம்"),
    WordPair("Dovecot", "A house or box in which pigeons or doves live", tamilB: "புறாக்கள் வாழும் பெட்டி/வீடு"),
    WordPair("Garage", "A place for housing cars", tamilB: "கார் நிறுத்தும் இடம்"),
    WordPair("Hanger", "A place for housing aeroplanes", tamilB: "விமானம் நிறுத்தும் இடம்"),
    WordPair("Caboose, galley", "The kitchen of a ship", tamilB: "கப்பலின் சமையலறை"),
    WordPair("Archive", "A place where government records are kept", tamilB: "அரசு ஆவணங்கள் பாதுகாக்கப்படும் இடம்"),
    WordPair("Cache", "A place where treasures, stores, ammunition are hidden", tamilB: "பொக்கிஷம், ஆயுதங்கள் மறைத்து வைக்கும் இடம்"),
    WordPair("Granary", "A place for storing grain", tamilB: "தானியம் சேமிக்கும் இடம்"),
    WordPair("Depot", "A place where goods are stored", tamilB: "பொருட்கள் சேமிக்கப்படும் இடம்"),
    WordPair("Garret", "An upper room or storey immediately under the roof", tamilB: "கூரைக்கு அடியில் உள்ள மேல்தள அறை"),
    WordPair("Mint", "A place where money is coined", tamilB: "நாணயம் தயாரிக்கும் இடம்"),
    WordPair("Casino", "A place with gambling tables, etc.", tamilB: "சூதாட்ட மேசைகள் உள்ள இடம்"),
    WordPair("Cellar", "An underground place for storing wine or other provisions", tamilB: "மது/பொருட்கள் சேமிக்கும் தரைக்கீழ் அறை"),
  ],
);

final WordGroup professions = WordGroup(
  id: "professions",
  title: "Words Denoting Professions or Trade",
  tamilTitle: "தொழில்களைக் குறிக்கும் வார்த்தைகள்",
  leftLabel: "Word",
  rightLabel: "Meaning",
  emoji: "🧑‍🔧",
  pairs: const [
    WordPair("Oculist", "One who attends to the diseases of the eye", tamilB: "கண் நோய்களுக்கு சிகிச்சை அளிப்பவர்"),
    WordPair("Optician", "One who tests eyesight and sells spectacles", tamilB: "பார்வையை சோதித்து கண்ணாடி விற்பவர்"),
    WordPair("Physician", "One who attends to sick people and prescribes medicines", tamilB: "நோயாளிகளுக்கு மருந்து கொடுக்கும் மருத்துவர்"),
    WordPair("Chauffeur", "One who drives a motor car", tamilB: "கார் ஓட்டுநர்"),
    WordPair("Costermonger", "One who sells fruits, vegetables, etc. from a barrow", tamilB: "வண்டியில் பழம்/காய்கறி விற்பவர்"),
    WordPair("Ironmanager", "One who deals in iron and hardware", tamilB: "இரும்பு பொருட்கள் வியாபாரி"),
    WordPair("Glazier", "One who sets glass in windows, doors, etc.", tamilB: "ஜன்னல்/கதவுகளில் கண்ணாடி பொருத்துபவர்"),
    WordPair("Usurer", "One who lends money at exorbitant interest", tamilB: "அதிக வட்டிக்கு பணம் கடன் கொடுப்பவர்"),
    WordPair("Pawnbroker", "One who lends money and keeps goods as security", tamilB: "அடகு வைத்து பணம் கடன் கொடுப்பவர்"),
    WordPair("Scrivener", "One who draws up contracts and also lends money on interest", tamilB: "ஒப்பந்தங்கள் எழுதி வட்டிக்கும் கடன் கொடுப்பவர்"),
    WordPair("Undertaker", "A tradesman who manages funerals", tamilB: "இறுதிச் சடங்குகளை நடத்துபவர்"),
  ],
);

final WordGroup personCharacteristics = WordGroup(
  id: "person_characteristics",
  title: "Names for Persons with Certain Characteristics",
  tamilTitle: "சிறப்பியல்பு கொண்ட நபர்களைக் குறிக்கும் வார்த்தைகள்",
  leftLabel: "Word",
  rightLabel: "Meaning",
  emoji: "🧍",
  pairs: const [
    WordPair("Minion", "One who becomes the favourite of a distinguished personage and serves him as a slave", tamilB: "பெரியவரின் விருப்பத்திற்குரிய அடிமை போன்ற பணியாளர்"),
    WordPair("Fugitive", "One who runs away from justice or the law", tamilB: "சட்டத்திடமிருந்து ஓடிப்போகிறவர்"),
    WordPair("Refugee, alien", "One who takes refuge in a foreign country", tamilB: "வேற்று நாட்டில் அடைக்கலம் புகுபவர்"),
    WordPair("Exile", "One who is banished from his home or his country", tamilB: "தாய்நாட்டிலிருந்து நாடு கடத்தப்பட்டவர்"),
    WordPair("Kleptomaniac", "One who has an irresistible tendency to steal", tamilB: "திருட வேண்டும் என்ற தணிக்க முடியாத ஆசை உள்ளவர்"),
    WordPair("Martyr", "One who dies for a noble cause", tamilB: "உயர்ந்த நோக்கத்திற்காக உயிர் தியாகம் செய்பவர்"),
    WordPair("Assassin", "One who kills political figures", tamilB: "அரசியல் பிரமுகர்களை கொலை செய்பவர்"),
    WordPair("Accomplice", "A partner in crime", tamilB: "குற்றத்தில் பங்குடையவர்"),
    WordPair("Stowaway", "One who hides away on a ship to obtain a free passage", tamilB: "இலவசமாக பயணிக்க கப்பலில் மறைந்திருப்பவர்"),
  ],
);

final WordGroup government = WordGroup(
  id: "government",
  title: "Words Pertaining to Government",
  tamilTitle: "அரசாங்கம் தொடர்பான வார்த்தைகள்",
  leftLabel: "Word",
  rightLabel: "Meaning",
  emoji: "🏛️",
  pairs: const [
    WordPair("Democracy", "Government of the people, for the people and by the people", tamilB: "மக்களால், மக்களுக்காக, மக்களின் அரசாங்கம்"),
    WordPair("Autocracy, despotism", "Government by a sovereign with uncontrolled authority", tamilB: "கட்டுப்பாடற்ற அதிகாரம் கொண்ட ஒரு தலைவரின் ஆட்சி"),
    WordPair("Aristocracy", "Government by the nobility", tamilB: "பிரபு வர்க்கத்தினரின் ஆட்சி"),
    WordPair("Bureaucracy", "Government by departments of state", tamilB: "அரசு துறைகளால் நடத்தப்படும் ஆட்சி"),
    WordPair("Referendum", "To decide a political question by the direct vote of the whole electorate", tamilB: "மக்கள் நேரடி வாக்கெடுப்பு மூலம் முடிவெடுத்தல்"),
    WordPair("Regent", "One who governs a kingdom during the infancy, absence, or disability of the sovereign", tamilB: "மன்னரின் சிறுவயது/இல்லாமை காலத்தில் ஆட்சி நடத்துபவர்"),
  ],
);

final WordGroup church = WordGroup(
  id: "church",
  title: "Words Pertaining to the Church",
  tamilTitle: "தேவாலயம் தொடர்பான வார்த்தைகள்",
  leftLabel: "Word",
  rightLabel: "Meaning",
  emoji: "⛪",
  pairs: const [
    WordPair("Aisle", "A passage between the pews in a church", tamilB: "தேவாலயத்தில் இருக்கைகளுக்கு இடையேயான வழி"),
    WordPair("Sexton", "One who has charge of a church building", tamilB: "தேவாலய கட்டிடத்தை பராமரிப்பவர்"),
    WordPair("Encyclical", "A letter from the Pope to all Roman Catholics", tamilB: "போப்பாண்டவர் அனைத்து கத்தோலிக்கர்களுக்கும் அனுப்பும் கடிதம்"),
    WordPair("Cassock", "A long loose gown worn by priests and choristers", tamilB: "குருமார் அணியும் நீண்ட தளர்ந்த அங்கி"),
    WordPair("Surplice", "A loose white vestment worn over the cassock", tamilB: "காசொக்கின் மேல் அணியும் வெள்ளை ஆடை"),
    WordPair("Blaspheme", "To utter profane language against god or anything holy", tamilB: "கடவுளுக்கு எதிராக அவமரியாதையாக பேசுதல்"),
    WordPair("Heresy", "Holding opinions contrary to the true doctrine of the church so as to cause a division", tamilB: "தேவாலயத்தின் உண்மையான கோட்பாட்டிற்கு மாறான கருத்து"),
    WordPair("Sacrilege", "Violating or profaning religious things", tamilB: "புனிதமான பொருட்களை அவமதித்தல்"),
    WordPair("Nave", "The central or main part of a church", tamilB: "தேவாலயத்தின் மைய பகுதி"),
    WordPair("Chancel", "The eastern end of a church", tamilB: "தேவாலயத்தின் கிழக்கு முனை"),
  ],
);

final WordGroup marriage = WordGroup(
  id: "marriage",
  title: "Words Pertaining to Marriage",
  tamilTitle: "திருமணம் தொடர்பான வார்த்தைகள்",
  leftLabel: "Word",
  rightLabel: "Meaning",
  emoji: "💍",
  pairs: const [
    WordPair("Fiance, fiancee", "One engaged to be married", tamilB: "திருமணத்திற்கு நிச்சயிக்கப்பட்டவர்"),
    WordPair("Betrothed, affianced", "Engaged to be married", tamilB: "திருமணத்திற்கு நிச்சயிக்கப்பட்ட நிலை"),
    WordPair("Trousseau", "A bride's outfit", tamilB: "மணப்பெண்ணின் திருமண உடைகள் தொகுப்பு"),
    WordPair("Elope", "To run away with a lover in order to get married secretly", tamilB: "காதலருடன் ரகசியமாக ஓடிப்போய் திருமணம் செய்தல்"),
  ],
);

final WordGroup tradeGovernment = WordGroup(
  id: "trade",
  title: "Words Pertaining to Government / Trade",
  tamilTitle: "வர்த்தகம் தொடர்பான வார்த்தைகள்",
  leftLabel: "Word",
  rightLabel: "Meaning",
  emoji: "📦",
  pairs: const [
    WordPair("Imports", "Goods brought into a country", tamilB: "நாட்டிற்குள் கொண்டு வரப்படும் பொருட்கள்"),
    WordPair("Exports", "Goods carried out of a country", tamilB: "நாட்டிலிருந்து அனுப்பப்படும் பொருட்கள்"),
    WordPair("Tariff", "A list of table of duties payable on exports or imports", tamilB: "இறக்குமதி/ஏற்றுமதி வரி பட்டியல்"),
    WordPair("Invoice", "A list of goods dispatched with quantity and price to the purchaser", tamilB: "அனுப்பிய பொருட்களின் அளவும் விலையும் கொண்ட பட்டியல்"),
    WordPair("Consignee", "One to whom goods are dispatched", tamilB: "பொருட்கள் அனுப்பப்படுபவர்"),
  ],
);

final WordGroup literary = WordGroup(
  id: "literary",
  title: "Literary Words",
  tamilTitle: "இலக்கியம் தொடர்பான வார்த்தைகள்",
  leftLabel: "Word",
  rightLabel: "Meaning",
  emoji: "📚",
  pairs: const [
    WordPair("Diary", "A book in which the events of each day are recorded", tamilB: "தினமும் நடந்தவை பதிவு செய்யும் புத்தகம்"),
    WordPair("Dictionary", "A book containing the words of a language with their definitions, in alphabetical order", tamilB: "மொழியின் சொற்களை அகரவரிசையில் விளக்கும் புத்தகம்"),
    WordPair("Directory", "A book of names and addresses", tamilB: "பெயர்கள் மற்றும் முகவரிகள் கொண்ட புத்தகம்"),
    WordPair("Glossary", "A list of explanations of rare, technical or obsolete words", tamilB: "அரிய/தொழில்நுட்ப சொற்களுக்கான விளக்கப் பட்டியல்"),
    WordPair("Memoirs", "A written account, usually in book form, of the interesting and memorable experience of one's life", tamilB: "வாழ்க்கையின் நினைவுகூரத்தக்க அனுபவங்களை எழுதிய குறிப்புகள்"),
    WordPair("Watermark", "The trade mark of the maker seen on paper when it is held up to the light", tamilB: "தாளில் தெரியும் தயாரிப்பாளரின் அடையாளம்"),
    WordPair("Autobiography", "A record of one's life written by himself", tamilB: "ஒருவர் தானே எழுதிய தன் வாழ்க்கை வரலாறு"),
    WordPair("Biography", "The history of the life of a person", tamilB: "ஒருவரின் வாழ்க்கை வரலாறு"),
  ],
);

final WordGroup miscellaneous = WordGroup(
  id: "miscellaneous",
  title: "Miscellaneous Words",
  tamilTitle: "பல்வேறு வார்த்தைகள்",
  leftLabel: "Word",
  rightLabel: "Meaning",
  emoji: "🔧",
  pairs: const [
    WordPair("Extravagant", "Wasteful in spending", tamilB: "செலவில் வீண் விரயம் செய்கிற"),
    WordPair("Miscellaneous", "Consisting of several kinds", tamilB: "பலவகைகளை உள்ளடக்கிய"),
    WordPair("Insolvent", "Unable to pay one's debts", tamilB: "கடன் தீர்க்க இயலாத நிலை"),
    WordPair("Palisade", "A fence or railing of stakes, or iron, etc.", tamilB: "கம்பங்களால் ஆன வேலி"),
    WordPair("Stile", "Steps to enable one to get over a fence", tamilB: "வேலியைத் தாண்டுவதற்கான படிக்கட்டு"),
    WordPair("Shunting", "To turn a train etc. on a side track", tamilB: "ரயிலை பக்கப் பாதைக்கு மாற்றுதல்"),
    WordPair("Effluent", "The liquid which comes out from a sewerage tank", tamilB: "கழிவுநீர் தொட்டியிலிருந்து வரும் திரவம்"),
    WordPair("Gavel", "A chairman's hammer", tamilB: "தலைவர் பயன்படுத்தும் சிறு சுத்தியல்"),
    WordPair("Baton", "A stick used by a music conductor, or by a policeman", tamilB: "இசை நடத்துனர்/காவலர் பயன்படுத்தும் குச்சி"),
    WordPair("Viaduct", "A bridge carrying a road or railway across a river or valley", tamilB: "ஆறு/பள்ளத்தாக்கின் மேல் அமைந்த பாலம்"),
    WordPair("Valise", "A leather travelling bag carried in the hand", tamilB: "கையில் எடுத்துச் செல்லும் தோல் பயணப்பை"),
    WordPair("Amulet", "A thing worn by some persons as a charm against evil, witchcraft, sickness etc.", tamilB: "தீமையிலிருந்து பாதுகாக்க அணியும் ஏலசு"),
  ],
);

final WordGroup medical = WordGroup(
  id: "medical",
  title: "Medical Words",
  tamilTitle: "மருத்துவம் தொடர்பான வார்த்தைகள்",
  leftLabel: "Word",
  rightLabel: "Meaning",
  emoji: "🩺",
  pairs: const [
    WordPair("Epidemic", "A disease affecting many persons at the same place and time", tamilB: "ஒரே இடத்தில் பலரைப் பாதிக்கும் நோய்"),
    WordPair("Pandemic", "A disease widely epidemic", tamilB: "பரவலாக பலரைப் பாதிக்கும் நோய்"),
    WordPair("Endemic", "A disease confined to a particular district or place", tamilB: "ஒரு குறிப்பிட்ட பகுதிக்கே உரிய நோய்"),
    WordPair("Sporadic", "A disease affecting widely scattered groups of people", tamilB: "சிதறிய இடங்களில் தோன்றும் நோய்"),
    WordPair("Cicatrice, cicatrix", "The mark or scar left after a wound is healed", tamilB: "காயம் ஆறியபின் மிஞ்சும் தழும்பு"),
    WordPair("Antidote", "A medicine to counteract poison", tamilB: "விஷத்தை முறியடிக்கும் மருந்து"),
    WordPair("Deodorant", "A substance to keep down foul smells", tamilB: "துர்நாற்றத்தை போக்கும் பொருள்"),
  ],
);

final WordGroup death = WordGroup(
  id: "death",
  title: "Words Pertaining to Death",
  tamilTitle: "மரணம் தொடர்பான வார்த்தைகள்",
  leftLabel: "Word",
  rightLabel: "Meaning",
  emoji: "🕯️",
  pairs: const [
    WordPair("Asphyxia", "Fainting or death due to being deprived of air", tamilB: "காற்று கிடைக்காமல் மயங்குதல் அல்லது இறத்தல்"),
    WordPair("Corpse", "The dead body of a human being", tamilB: "மனிதனின் பிணம்"),
    WordPair("Carcass", "The dead body of an animal", tamilB: "விலங்கின் பிணம்"),
    WordPair("Carrion", "Dead and decaying flesh (esp. of animals)", tamilB: "அழுகிய இறைச்சி (விலங்குகளின்)"),
    WordPair("Mortuary", "A place where dead bodies are temporarily placed", tamilB: "பிணங்கள் தற்காலிகமாக வைக்கப்படும் இடம்"),
    WordPair("Morgue", "Place where the bodies of persons found dead are placed for identification", tamilB: "இறந்தவர்களை அடையாளம் காண வைக்கும் இடம்"),
    WordPair("Pyre", "A pile of wood on which a dead body is burned", tamilB: "பிணத்தை எரிக்க அடுக்கப்படும் விறகுக் குவியல்"),
    WordPair("Hearse", "A vehicle for taking dead bodies to the cemetery", tamilB: "பிணத்தை கல்லறைக்கு கொண்டு செல்லும் வாகனம்"),
    WordPair("Cemetery", "A place where dead bodies are interred", tamilB: "பிணங்கள் புதைக்கப்படும் இடம்"),
    WordPair("Epitaph", "An inscription on a tomb", tamilB: "கல்லறையில் பொறிக்கப்படும் வாசகம்"),
    WordPair("Crypt", "A vault beneath a church used for a burial", tamilB: "தேவாலயத்தின் அடியில் உள்ள புதைகுழி அறை"),
  ],
);

final WordGroup natureStudy = WordGroup(
  id: "nature_study",
  title: "Nature Study Words",
  tamilTitle: "இயற்கை ஆய்வு தொடர்பான வார்த்தைகள்",
  leftLabel: "Word",
  rightLabel: "Meaning",
  emoji: "🌿",
  pairs: const [
    WordPair("Spoor", "A trace of wild animal", tamilB: "காட்டு விலங்கு விட்டுச்செல்லும் தடம்"),
    WordPair("Venison", "The meat of deer", tamilB: "மான் இறைச்சி"),
    WordPair("Drought", "Absence of rain for a long time", tamilB: "நீண்ட காலம் மழையின்றி இருத்தல்"),
    WordPair("Migrate", "To move from one country to another", tamilB: "ஒரு நாட்டிலிருந்து இன்னொரு நாட்டிற்கு இடம்பெயர்தல்"),
  ],
);

final List<WordGroup> categoryWordLists = [
  collectiveNouns,
  dwellings,
  professions,
  personCharacteristics,
  government,
  church,
  marriage,
  tradeGovernment,
  literary,
  miscellaneous,
  medical,
  death,
  natureStudy,
];

// ---------------------------------------------------------------------
// 4) GENDER  (18 pairs)
// ---------------------------------------------------------------------
final WordGroup genderWords = WordGroup(
  id: "gender",
  title: "Gender — Masculine & Feminine",
  tamilTitle: "பாலினம் — ஆண்பால் மற்றும் பெண்பால்",
  leftLabel: "Masculine",
  rightLabel: "Feminine",
  emoji: "⚥",
  pairs: const [
    WordPair("Author", "Authoress", tamilB: "ஆண்: எழுத்தாளர் / பெண்: பெண் எழுத்தாளர்"),
    WordPair("Bachelor", "Maid, spinster", tamilB: "ஆண்: மணமாகாதவன் / பெண்: மணமாகாதவள்"),
    WordPair("Drone", "Bee", tamilB: "ஆண்: ஆண் தேனீ / பெண்: தேனீ"),
    WordPair("Duke", "Duchess", tamilB: "ஆண்: பிரபு / பெண்: பிரபுவின் மனைவி"),
    WordPair("Emperor", "Empress", tamilB: "ஆண்: பேரரசர் / பெண்: பேரரசி"),
    WordPair("Fox", "Vixen", tamilB: "ஆண்: நரி (ஆண்) / பெண்: நரி (பெண்)"),
    WordPair("Friar", "Nun", tamilB: "ஆண்: கிறிஸ்தவத் துறவி / பெண்: கன்னியாஸ்திரி"),
    WordPair("Gander", "Goose", tamilB: "ஆண்: வாத்து (ஆண்) / பெண்: வாத்து (பெண்)"),
    WordPair("Gentleman", "Lady", tamilB: "ஆண்: மேன்மகன் / பெண்: மேன்மகள்"),
    WordPair("Horse", "Mare", tamilB: "ஆண்: குதிரை (ஆண்) / பெண்: குதிரை (பெண்)"),
    WordPair("Jack-ass", "Jenny-ass", tamilB: "ஆண்: கழுதை (ஆண்) / பெண்: கழுதை (பெண்)"),
    WordPair("Monk", "Nun", tamilB: "ஆண்: துறவி / பெண்: கன்னியாஸ்திரி"),
    WordPair("Nephew", "Niece", tamilB: "ஆண்: மருமகன் / பெண்: மருமகள்"),
    WordPair("Stallion", "Mare", tamilB: "ஆண்: ஆண் குதிரை / பெண்: பெண் குதிரை"),
    WordPair("Swain", "Nymph", tamilB: "ஆண்: கிராமியக் காதலன் / பெண்: வனதேவதை"),
    WordPair("Tutor", "Governess", tamilB: "ஆண்: வீட்டு ஆசிரியர் / பெண்: பெண் வீட்டு ஆசிரியை"),
    WordPair("Wizard", "Witch", tamilB: "ஆண்: மந்திரவாதி / பெண்: சூனியக்காரி"),
    WordPair("Waiter", "Waitress", tamilB: "ஆண்: பணியாளர் (ஆண்) / பெண்: பணியாளர் (பெண்)"),
  ],
);

// ---------------------------------------------------------------------
// 5) SOUNDS OF BIRDS & ANIMALS  (31 pairs)
// ---------------------------------------------------------------------
final WordGroup animalSounds = WordGroup(
  id: "sounds",
  title: "Distinctive Sounds of Birds & Animals",
  tamilTitle: "பறவைகள் மற்றும் விலங்குகளின் ஒலிகள்",
  leftLabel: "Bird / Animal",
  rightLabel: "Sound",
  emoji: "🔊",
  pairs: const [
    WordPair("Hens", "Cluck, cackle, chuckle", tamilB: "கொக்கரிப்பு"),
    WordPair("Cows", "Moo", tamilB: "மூளுதல்"),
    WordPair("Geese", "Cackle", tamilB: "கொக்கரிப்பு"),
    WordPair("Grasshoppers", "Chirr", tamilB: "சிர்ரென்ற ஒலி"),
    WordPair("Ducks", "Quack", tamilB: "க்வாக் ஒலி"),
    WordPair("Apes", "Gibber", tamilB: "முணுமுணுப்பு"),
    WordPair("Parrots", "Chatter", tamilB: "கிண்டல் பேச்சு / கொஞ்சல்"),
    WordPair("Bears", "Growl", tamilB: "உறுமல்"),
    WordPair("Frogs", "Croak", tamilB: "தவளை கத்தும் ஒலி"),
    WordPair("Eagles", "Scream", tamilB: "கூச்சலிடுதல்"),
    WordPair("Crows", "Caw", tamilB: "காகம் கத்துதல்"),
    WordPair("Hyenas", "Laugh, Scream", tamilB: "சிரிப்பு ஒலி"),
    WordPair("Wolves", "Howl", tamilB: "ஓலமிடுதல்"),
    WordPair("Seagulls", "Scream", tamilB: "கூச்சலிடுதல்"),
    WordPair("Sparrows", "Chirp", tamilB: "சிலம்பொலி"),
    WordPair("Bees", "Buzz", tamilB: "ரீங்காரம்"),
    WordPair("Crickets", "Chirp", tamilB: "சிலிர்ப்பு ஒலி"),
    WordPair("Beetles", "Drone", tamilB: "முரல் ஒலி"),
    WordPair("Sheep", "Bleat", tamilB: "மே மே எனும் ஒலி"),
    WordPair("Rabbits", "Squeal", tamilB: "சிறு கூச்சல்"),
    WordPair("Elephants", "Trumpet", tamilB: "பீப்பிடுதல்"),
    WordPair("Pigs", "Grunt, Squeal", tamilB: "குரல் எழுப்புதல்"),
    WordPair("Lions", "Roar", tamilB: "கர்ஜனை"),
    WordPair("Mice", "Squeak", tamilB: "சிறு ஒலி"),
    WordPair("Snakes", "Hiss", tamilB: "சீறுதல்"),
    WordPair("Deer", "Bell", tamilB: "கூவுதல்"),
    WordPair("Owls", "Hoot, screech, cur", tamilB: "கூவுதல்"),
    WordPair("Asses", "Bray", tamilB: "கழுதை கத்துதல்"),
    WordPair("Cats", "Mew, purr", tamilB: "மியாவ் ஒலி"),
    WordPair("Horses", "Neigh", tamilB: "கனைத்தல்"),
    WordPair("Oxen", "Low", tamilB: "மாடு கத்துதல்"),
  ],
);

// ---------------------------------------------------------------------
// 6) YOUNG ONES OF ANIMALS  (30 pairs)
// ---------------------------------------------------------------------
final WordGroup youngOnes = WordGroup(
  id: "young_ones",
  title: "Names Given to the Young Ones of Animals",
  tamilTitle: "விலங்குகளின் குட்டிகளுக்கான பெயர்கள்",
  leftLabel: "Adult",
  rightLabel: "Young",
  emoji: "🐣",
  pairs: const [
    WordPair("Eagle", "Eaglet", tamilB: "கழுகுக் குட்டி"),
    WordPair("Swan", "Cygnet", tamilB: "அன்னக் குஞ்சு"),
    WordPair("Whale", "Calf", tamilB: "திமிங்கலக் குட்டி"),
    WordPair("Butterfly, moth", "Caterpillar", tamilB: "கம்பளிப் பூச்சி"),
    WordPair("Elephant", "Calf", tamilB: "யானைக் குட்டி"),
    WordPair("Lion, bear, fox", "Cub", tamilB: "குட்டி (சிங்கம்/கரடி/நரி)"),
    WordPair("Pig", "Piglet", tamilB: "பன்றிக் குட்டி"),
    WordPair("Eel", "Elver", tamilB: "விலாங்கு மீன் குட்டி"),
    WordPair("Duck", "Duckling", tamilB: "வாத்துக் குஞ்சு"),
    WordPair("Hawk", "Bowet", tamilB: "பருந்துக் குஞ்சு"),
    WordPair("Deer", "Fawn", tamilB: "மான் குட்டி"),
    WordPair("Bird", "Nestling", tamilB: "கூட்டுக் குஞ்சு"),
    WordPair("Bull", "Calf", tamilB: "காளைக் கன்று"),
    WordPair("Salmon", "Parr", tamilB: "சால்மன் மீன் குட்டி"),
    WordPair("Cow", "Heifer", tamilB: "இளம் பசு"),
    WordPair("Trout", "Fry", tamilB: "மீன் குஞ்சு"),
    WordPair("Hen", "Pullet", tamilB: "இளங்கோழி"),
    WordPair("Frog (toad)", "Tadpole", tamilB: "தேரை/தவளைக் குட்டி"),
    WordPair("Sheep", "Lamb", tamilB: "ஆட்டுக்குட்டி"),
    WordPair("Hare", "Leveret", tamilB: "முயல் குட்டி"),
    WordPair("Horse", "Foal", tamilB: "குதிரைக் குட்டி"),
    WordPair("Mare", "Filly", tamilB: "பெண் குதிரைக் குட்டி"),
    WordPair("Ass", "Foal", tamilB: "கழுதைக் குட்டி"),
    WordPair("Stallion (horse)", "Colt or foal", tamilB: "ஆண் குதிரைக் குட்டி"),
    WordPair("Cock", "Cockerel", tamilB: "இளங்கோழி (ஆண்)"),
    WordPair("Goose", "Gosling", tamilB: "வாத்துக் குஞ்சு"),
    WordPair("Cat", "Kitten", tamilB: "பூனைக் குட்டி"),
    WordPair("Goat", "Kid", tamilB: "வெள்ளாட்டுக் குட்டி"),
    WordPair("Fowl", "Chicken", tamilB: "கோழிக் குஞ்சு"),
    WordPair("Owl", "Owlet", tamilB: "ஆந்தைக் குஞ்சு"),
  ],
);

final List<WordGroup> allWordGroups = [
  difficultEasyWords,
  idioms,
  ...categoryWordLists,
  genderWords,
  animalSounds,
  youngOnes,
];

// ---------------------------------------------------------------------
// 7) CONFUSABLES / TROUBLESOME WORDS  (13 pairs)
// ---------------------------------------------------------------------
final List<ConfusablePair> confusables = const [
  ConfusablePair("Alter", "Altar", "Alter = to change. Altar = a structure used in worship.",
      "Alter = மாற்றுதல். Altar = வழிபாட்டிற்கான பீடம்."),
  ConfusablePair("Cite", "Site", "Cite = to use as an example. Site = location.",
      "Cite = எடுத்துக்காட்டாகக் குறிப்பிடுதல். Site = இடம்."),
  ConfusablePair("Dairy", "Diary", "Dairy = a farm engaged in milk production. Diary = a daily record of experiences.",
      "Dairy = பால் பண்ணை. Diary = தினக்குறிப்பு."),
  ConfusablePair("Descent", "Dissent", "Descent = a way sloping down. Dissent = disagreement, to disagree.",
      "Descent = கீழிறங்கும் பாதை/வம்சாவளி. Dissent = கருத்து வேறுபாடு."),
  ConfusablePair("Contagious", "Infectious",
      "If a disease is contagious it is transmitted by physical contact. An infectious disease can be communicated through the air or in water.",
      "Contagious = தொடுதலால் பரவும் நோய். Infectious = காற்று/நீர் மூலம் பரவும் நோய்."),
  ConfusablePair("Dispose of", "Dispense with",
      "If you dispose of something you threw it away. If you dispense with it you do without it.",
      "Dispose of = தூக்கி எறிதல். Dispense with = இல்லாமலேயே செய்தல்."),
  ConfusablePair("Explicit", "Implicit", "Explicit means stated directly, implicit means stated indirectly.",
      "Explicit = நேரடியாகக் கூறப்பட்டது. Implicit = மறைமுகமாகக் குறிப்பிடப்பட்டது."),
  ConfusablePair("Flaunt", "Flout",
      "To flaunt something is to show it off in a shameless way. To flout is to deliberately ignore a rule or an accepted standard of behaviour.",
      "Flaunt = வெளிப்படையாக காட்டிக்கொள்ளுதல். Flout = விதியை வேண்டுமென்றே மீறுதல்."),
  ConfusablePair("Graceful", "Gracious",
      "Graceful describes a person's attractive bearing and ease of movement, Gracious implies kindness or courtesy from a superior.",
      "Graceful = அழகான நடையுடையவர். Gracious = கருணையும் மரியாதையும் உடையவர்."),
  ConfusablePair("Commissionaire", "Commissioner",
      "A commissioner is a member of a team – Police commissioner. A commissionaire is a uniformed doorman.",
      "Commissioner = குழுவின் உறுப்பினர் (போலீஸ் கமிஷனர்). Commissionaire = சீருடை அணிந்த வாசல் காவலர்."),
  ConfusablePair("Councillor", "Counsellor",
      "A councillor is a member of a council. A counsellor is someone who provides advice (or, in British English, a barrister).",
      "Councillor = கவுன்சில் உறுப்பினர். Counsellor = ஆலோசகர்/வழக்கறிஞர்."),
  ConfusablePair("Transparent", "Translucent",
      "Transparent is clear passing through. Translucent, while similar in meaning, emphasizes the idea of light passing through.",
      "Transparent = தெளிவாகத் தெரியும். Translucent = ஒளி ஊடுருவும் ஆனால் தெளிவாகத் தெரியாத."),
  ConfusablePair("Gourmet", "Gourmand",
      "A gourmet is an expert in the appreciation of fine food. A gourmand, when sitting down to a meal, is more interested in quantity than quality.",
      "Gourmet = நல்ல உணவை மெச்சும் நிபுணர். Gourmand = அளவைப் பொருட்படுத்தாமல் உண்பவர்."),
];

// ---------------------------------------------------------------------
// 8) PRONUNCIATION — SYLLABLES  (6 groups)
// ---------------------------------------------------------------------
final List<PronunciationGroup> syllableGroups = const [
  PronunciationGroup(
    title: "One Speech Unit (Monosyllabic words)",
    tamilTitle: "ஒரே ஒரு உச்சரிப்பு அலகு கொண்ட வார்த்தைகள்",
    rule: "English words are built from speech units called \"syllables\". A word with just one syllable is spoken as a single beat — like \"cut\".",
    tamilRule: "ஆங்கில வார்த்தைகள் \"syllable\" எனப்படும் உச்சரிப்பு அலகுகளால் ஆனவை. ஒரே ஒரு அலகு கொண்ட வார்த்தை ஒரே ஒரு தட்டில் உச்சரிக்கப்படும் — உதாரணமாக \"cut\".",
    words: ["Ace", "Bay", "Cow", "God", "Day", "Five", "Key", "May", "Can", "End", "Eight", "Silk", "Age", "Too", "Go", "Row", "Come", "Hear", "Stop"],
  ),
  PronunciationGroup(
    title: "Two Speech Units (Disyllabic words)",
    tamilTitle: "இரண்டு உச்சரிப்பு அலகுகள் கொண்ட வார்த்தைகள்",
    rule: "These words break into two beats when spoken.",
    tamilRule: "இந்த வார்த்தைகள் உச்சரிக்கும்போது இரண்டு தட்டுகளாகப் பிரியும்.",
    words: ["Forward", "Reward", "Context", "Before", "Nucleus", "Birthday", "Pattern", "Entire", "Assure", "Assort", "Captain", "Tackle", "Canal", "Effect", "Beside", "About"],
  ),
  PronunciationGroup(
    title: "Three Speech Units (Trisyllabic words)",
    tamilTitle: "மூன்று உச்சரிப்பு அலகுகள் கொண்ட வார்த்தைகள்",
    rule: "These words break into three beats when spoken.",
    tamilRule: "இந்த வார்த்தைகள் உச்சரிக்கும்போது மூன்று தட்டுகளாகப் பிரியும்.",
    words: ["Bicycle", "Calculate", "Educate", "Accident", "Quarrelsome", "Recommend", "Understand", "Entertain", "Horizon", "Familiar", "Deliver", "Elastic"],
  ),
  PronunciationGroup(
    title: "Four Speech Units (Tetrasyllabic words)",
    tamilTitle: "நான்கு உச்சரிப்பு அலகுகள் கொண்ட வார்த்தைகள்",
    rule: "These words break into four beats when spoken.",
    tamilRule: "இந்த வார்த்தைகள் உச்சரிக்கும்போது நான்கு தட்டுகளாகப் பிரியும்.",
    words: ["Caterpillar", "Criticism", "Capitalize", "Melancholy", "Rhinoceros", "Unfortunate", "Circulation"],
  ),
  PronunciationGroup(
    title: "Five Speech Units (Pentasyllabic words)",
    tamilTitle: "ஐந்து உச்சரிப்பு அலகுகள் கொண்ட வார்த்தைகள்",
    rule: "These words break into five beats when spoken.",
    tamilRule: "இந்த வார்த்தைகள் உச்சரிக்கும்போது ஐந்து தட்டுகளாகப் பிரியும்.",
    words: ["Irregular", "Co-ordinator", "Communicative", "Anthropology", "Pronunciation", "Respectively"],
  ),
  PronunciationGroup(
    title: "More Than Five Speech Units (Compound words)",
    tamilTitle: "ஐந்துக்கும் மேற்பட்ட உச்சரிப்பு அலகுகள் கொண்ட வார்த்தைகள்",
    rule: "Long, multi-part words like these can have six or more beats.",
    tamilRule: "இது போன்ற நீண்ட வார்த்தைகளில் ஆறு அல்லது அதற்கு மேற்பட்ட தட்டுகள் இருக்கலாம்.",
    words: ["Indefinitely", "Anticipatory", "Irregularity", "Tiruchirappalli", "Alphabetically", "Particularization"],
  ),
];

// ---------------------------------------------------------------------
// 9) PRONUNCIATION — SILENT & SPECIAL LETTERS  (15 groups)
// ---------------------------------------------------------------------
final List<PronunciationGroup> silentLetterGroups = const [
  PronunciationGroup(
    title: "'b' is silent",
    tamilTitle: "'b' எழுத்து ஒலிக்காது",
    tamilRule: "இந்த வார்த்தைகளில் 'b' எழுத்து உச்சரிக்கப்படாது.",
    words: ["comb", "womb", "limb", "bomb", "plumb", "doubt", "thumb", "debt"],
  ),
  PronunciationGroup(
    title: "'c' is pronounced as 's'",
    tamilTitle: "'c' எழுத்து 's' போல ஒலிக்கும்",
    tamilRule: "இந்த வார்த்தைகளில் 'c' எழுத்து 's' எழுத்து போல உச்சரிக்கப்படும்.",
    words: ["cell", "central", "century", "race", "vice", "ace", "cyanide", "face", "pace", "rice", "duce"],
  ),
  PronunciationGroup(
    title: "'c' is pronounced as 'k'",
    tamilTitle: "'c' எழுத்து 'k' போல ஒலிக்கும்",
    tamilRule: "இந்த வார்த்தைகளில் 'c' எழுத்து 'k' எழுத்து போல உச்சரிக்கப்படும்.",
    words: ["cord", "come", "cut", "clean", "music", "corn", "court", "cover", "class", "connect", "curfew", "canal", "capsule"],
  ),
  PronunciationGroup(
    title: "'e' is silent",
    tamilTitle: "'e' எழுத்து ஒலிக்காது",
    tamilRule: "இந்த வார்த்தைகளின் இறுதியில் உள்ள 'e' எழுத்து உச்சரிக்கப்படாது.",
    words: ["alternate", "gate", "lapse", "like", "lime", "prescribe", "ace", "age", "tale", "rhyme", "write"],
  ),
  PronunciationGroup(
    title: "'g' is pronounced hard (as in \"go\")",
    tamilTitle: "'g' எழுத்து கடினமாக (hard) ஒலிக்கும்",
    tamilRule: "இந்த வார்த்தைகளில் 'g' எழுத்து கடினமான ஒலியுடன் உச்சரிக்கப்படும்.",
    words: ["grade", "grow", "glide", "get", "girl", "garage", "gate", "god", "go", "ghost", "glory", "goat"],
  ),
  PronunciationGroup(
    title: "'g' is pronounced soft (as in \"gem\")",
    tamilTitle: "'g' எழுத்து மென்மையாக (soft) ஒலிக்கும்",
    tamilRule: "இந்த வார்த்தைகளில் 'g' எழுத்து மென்மையான ஒலியுடன் உச்சரிக்கப்படும்.",
    words: ["Germany", "genuine", "gypsy", "gem", "ginger", "gentle", "genetics", "gypsum", "gender", "geography"],
  ),
  PronunciationGroup(
    title: "'gh' is pronounced as 'f'",
    tamilTitle: "'gh' எழுத்துக்கள் 'f' போல ஒலிக்கும்",
    tamilRule: "இந்த வார்த்தைகளில் 'gh' எழுத்துக்கள் 'f' எழுத்து போல உச்சரிக்கப்படும்.",
    words: ["rough", "cough", "laugh"],
  ),
  PronunciationGroup(
    title: "'h' is silent",
    tamilTitle: "'h' எழுத்து ஒலிக்காது",
    tamilRule: "இந்த வார்த்தைகளில் 'h' எழுத்து உச்சரிக்கப்படாது.",
    words: ["hour", "honour", "honest", "heir", "heiress", "exhibit", "vehicle", "vehement"],
  ),
  PronunciationGroup(
    title: "'k' is silent",
    tamilTitle: "'k' எழுத்து ஒலிக்காது",
    tamilRule: "'kn' என தொடங்கும் இந்த வார்த்தைகளில் 'k' எழுத்து உச்சரிக்கப்படாது.",
    words: ["know", "knowledge", "knight", "knife", "knee", "knack", "knob", "knit", "knock", "knuckle"],
  ),
  PronunciationGroup(
    title: "'l' is silent",
    tamilTitle: "'l' எழுத்து ஒலிக்காது",
    tamilRule: "இந்த வார்த்தைகளில் 'l' எழுத்து உச்சரிக்கப்படாது.",
    words: ["alms", "psalm", "calm", "balm", "talk", "walk", "would", "should", "could", "half"],
  ),
  PronunciationGroup(
    title: "'n' is silent",
    tamilTitle: "'n' எழுத்து ஒலிக்காது",
    tamilRule: "'mn' என முடியும் இந்த வார்த்தைகளில் 'n' எழுத்து உச்சரிக்கப்படாது.",
    words: ["condemn", "autumn", "column"],
  ),
  PronunciationGroup(
    title: "'gh' is silent",
    tamilTitle: "'gh' எழுத்துக்கள் ஒலிக்காது",
    tamilRule: "இந்த வார்த்தைகளில் 'gh' எழுத்துக்கள் முற்றிலும் உச்சரிக்கப்படாது.",
    words: ["neighbour", "bright", "weight", "height", "might", "tight", "right", "plough"],
  ),
  PronunciationGroup(
    title: "'p' is silent before 's', 'n' or 't'",
    tamilTitle: "'s', 'n', 't' முன் வரும் 'p' எழுத்து ஒலிக்காது",
    tamilRule: "'ps', 'pn' போன்ற எழுத்துத் தொகுப்புகளில் 'p' எழுத்து உச்சரிக்கப்படாது.",
    words: ["psyche", "psychology", "pseudonym", "pneumatic", "pneumonia", "psalm", "psalter", "psychiatrist"],
  ),
  PronunciationGroup(
    title: "'t' is silent",
    tamilTitle: "'t' எழுத்து ஒலிக்காது",
    tamilRule: "இந்த வார்த்தைகளில் 't' எழுத்து உச்சரிக்கப்படாது.",
    words: ["castle", "christmas", "bustle", "thistle", "bristle"],
  ),
  PronunciationGroup(
    title: "'w' is silent",
    tamilTitle: "'w' எழுத்து ஒலிக்காது",
    tamilRule: "இந்த வார்த்தைகளில் 'w' எழுத்து உச்சரிக்கப்படாது.",
    words: ["hawk", "awe", "row", "write", "wrong", "wring"],
  ),
];

// ---------------------------------------------------------------------
// 10) FUN WITH WORDS — I. ODD ONE OUT  (6 questions, book-confirmed answers)
// ---------------------------------------------------------------------
final List<OddOneOut> oddOneOutQuestions = const [
  OddOneOut(
    words: ["Spring", "Winter", "Summer", "Autumn", "Cold"],
    oddIndex: 4,
    reason: "Cold is not a season — it describes weather/temperature. The other four are seasons.",
    tamilReason: "குளிர் (Cold) ஒரு பருவகாலம் அல்ல, மற்ற நான்கும் பருவகாலங்கள்.",
  ),
  OddOneOut(
    words: ["Eyes", "Ears", "Nose", "Tongue", "Talk"],
    oddIndex: 4,
    reason: "Talk is an action, not a part of the body. The other four are body parts.",
    tamilReason: "பேசுதல் (Talk) ஒரு செயல், உடல் உறுப்பு அல்ல; மற்ற நான்கும் உடல் உறுப்புகள்.",
  ),
  OddOneOut(
    words: ["Kerala", "Bengal", "Orissa", "Oriya", "Punjab"],
    oddIndex: 3,
    reason: "Oriya is a language/people name, not a state. The other four are Indian states.",
    tamilReason: "ஒரியா (Oriya) ஒரு மாநிலம் அல்ல, அது மொழி/இனப்பெயர்; மற்ற நான்கும் மாநிலங்கள்.",
  ),
  OddOneOut(
    words: ["Elephant", "Lion", "Tiger", "Crow", "Horse"],
    oddIndex: 3,
    reason: "Crow is a bird. The other four are mammals.",
    tamilReason: "காகம் (Crow) ஒரு பறவை; மற்ற நான்கும் பாலூட்டி விலங்குகள்.",
  ),
  OddOneOut(
    words: ["Hydrogen", "Chlorine", "Nitrogen", "Air", "Oxygen"],
    oddIndex: 3,
    reason: "Air is a mixture of gases. The other four are pure elements/gases.",
    tamilReason: "காற்று (Air) பல வாயுக்களின் கலவை; மற்ற நான்கும் தூய வாயுக்கள்.",
  ),
  OddOneOut(
    words: ["Paradip", "Kandla", "Amritsar", "Marmagao", "Cochin"],
    oddIndex: 2,
    reason: "Amritsar is not a port city. The other four are port cities.",
    tamilReason: "அமிர்தசரஸ் (Amritsar) துறைமுக நகரம் அல்ல; மற்ற நான்கும் துறைமுக நகரங்கள்.",
  ),
];

// ---------------------------------------------------------------------
// 11) FUN WITH WORDS — II. JUMBLED WORDS  (10 items, book-confirmed answers)
// ---------------------------------------------------------------------
final List<AnagramItem> jumbledWords = const [
  AnagramItem(scrambled: "esroh", clue: "Name of an animal", tamilClue: "ஒரு விலங்கின் பெயர்", answer: "HORSE"),
  AnagramItem(scrambled: "eors", clue: "Name of a flower", tamilClue: "ஒரு பூவின் பெயர்", answer: "ROSE"),
  AnagramItem(scrambled: "rcmah", clue: "A month of the year", tamilClue: "ஆண்டின் ஒரு மாதம்", answer: "MARCH"),
  AnagramItem(scrambled: "ydraif", clue: "Day of the week", tamilClue: "வாரத்தின் ஒரு நாள்", answer: "FRIDAY"),
  AnagramItem(scrambled: "ceurrmy", clue: "An element", tamilClue: "ஒரு தனிமம்", answer: "MERCURY"),
  AnagramItem(scrambled: "aaahlmtj", clue: "A historical place/monument in India", tamilClue: "இந்தியாவின் ஒரு வரலாற்று நினைவுச்சின்னம்", answer: "TAJMAHAL"),
  AnagramItem(scrambled: "mmeeetthorr", clue: "An instrument used to measure heat", tamilClue: "வெப்பத்தை அளக்கும் கருவி", answer: "THERMOMETER"),
  AnagramItem(scrambled: "rreeclut", clue: "A person connected with the teaching profession", tamilClue: "கற்பித்தல் தொழிலுடன் தொடர்புடையவர்", answer: "LECTURER"),
  AnagramItem(scrambled: "oellyw", clue: "A color", tamilClue: "ஒரு நிறம்", answer: "YELLOW"),
  AnagramItem(scrambled: "adrug", clue: "A person connected with railways", tamilClue: "ரயில்வேயுடன் தொடர்புடையவர்", answer: "GUARD"),
];

// ---------------------------------------------------------------------
// 12) FUN WITH WORDS — VI. Rearrange & find the word that is NOT a mammal
// ---------------------------------------------------------------------
final List<AnagramItem> nonMammalPuzzle = const [
  AnagramItem(scrambled: "TEACHEH", clue: "A mammal", tamilClue: "இது ஒரு பாலூட்டி விலங்கு", answer: "CHEETAH"),
  AnagramItem(scrambled: "LUGSALE", clue: "NOT a mammal — this is a bird! This is the answer to the puzzle.", tamilClue: "இது ஒரு பறவை (பாலூட்டி அல்ல) — இதுவே புதிருக்கான பதில்!", answer: "SEAGULL"),
  AnagramItem(scrambled: "LOGLIAR", clue: "A mammal", tamilClue: "இது ஒரு பாலூட்டி விலங்கு", answer: "GORILLA"),
  AnagramItem(scrambled: "LEGLAZE", clue: "A mammal", tamilClue: "இது ஒரு பாலூட்டி விலங்கு", answer: "GAZELLE"),
  AnagramItem(scrambled: "PEARDOL", clue: "A mammal", tamilClue: "இது ஒரு பாலூட்டி விலங்கு", answer: "LEOPARD"),
];

// ---------------------------------------------------------------------
// 13) FUN WITH WORDS — VII/VIII. SYNONYM & ANTONYM MCQs  (5 + 5)
// ---------------------------------------------------------------------
final List<McqQuestion> synonymQuestions = const [
  McqQuestion(prompt: "Educate", tamilPrompt: "கல்வி கற்பி", options: ["Intelligent", "Instruct", "Hatching", "Literate"], correctIndex: 1),
  McqQuestion(prompt: "Fierce", tamilPrompt: "கடுமையான/உக்கிரமான", options: ["Functions", "Pushing", "Anger", "Insurant"], correctIndex: 2),
  McqQuestion(prompt: "Insult", tamilPrompt: "அவமதி", options: ["Rude", "Irritant", "Foran", "Offend"], correctIndex: 3),
  McqQuestion(prompt: "Humbug", tamilPrompt: "பாசாங்கு/ஏமாற்று", options: ["Deceive", "Increase", "Hyperaemia", "Pretense"], correctIndex: 3),
  McqQuestion(prompt: "Loyalty", tamilPrompt: "விசுவாசம்", options: ["Devotion", "Truth", "Resourcefulness", "Adaptation"], correctIndex: 0),
];

final List<McqQuestion> antonymQuestions = const [
  McqQuestion(prompt: "Voluntary", tamilPrompt: "தன்னார்வமான (எதிர்ச்சொல் தேவை)", options: ["Compulsory", "Fixed", "Rigid", "Undertake"], correctIndex: 0),
  McqQuestion(prompt: "Illuminate", tamilPrompt: "ஒளியூட்டு (எதிர்ச்சொல் தேவை)", options: ["Burn", "Light", "Darken", "Pacify"], correctIndex: 2),
  McqQuestion(prompt: "Swell", tamilPrompt: "வீங்கு (எதிர்ச்சொல் தேவை)", options: ["Inflation", "Bulge", "Distend", "Contract"], correctIndex: 3),
  McqQuestion(prompt: "Consolidate", tamilPrompt: "உறுதிப்படுத்து (எதிர்ச்சொல் தேவை)", options: ["Brighten", "March", "Weaken", "Lighten"], correctIndex: 2),
  McqQuestion(prompt: "Tolerance", tamilPrompt: "சகிப்புத்தன்மை (எதிர்ச்சொல் தேவை)", options: ["Limit", "Plump", "Portative", "Bigotry"], correctIndex: 3),
];

// ---------------------------------------------------------------------
// 14) FUN WITH WORDS — III. WORD → GAME(S) MATCHING  (10 pairs, book-confirmed
//     from the garbled answer-key text: "...b. Cricket / ...d. Cricket,
//     Football, Hockey / ...f. Hockey, Football / ...h. Horse riding /
//     ...j. Table tennis" for the even letters, with the odd letters
//     recoverable from the same key.)
// ---------------------------------------------------------------------
final WordGroup gamesMatching = WordGroup(
  id: "games_matching",
  title: "Relate the Word to the Game(s)",
  tamilTitle: "வார்த்தையை விளையாட்டுடன் இணைக்கவும்",
  leftLabel: "Word",
  rightLabel: "Game(s)",
  emoji: "🏏",
  pairs: const [
    WordPair("A. Goal", "Hockey, Football", tamilB: "ஹாக்கி, கால்பந்து"),
    WordPair("B. Wicket", "Cricket", tamilB: "கிரிக்கெட்"),
    WordPair("C. Throw", "Cricket, Football", tamilB: "கிரிக்கெட், கால்பந்து"),
    WordPair("D. Hat-trick", "Cricket, Football, Hockey", tamilB: "கிரிக்கெட், கால்பந்து, ஹாக்கி"),
    WordPair("E. Sudden death", "Football", tamilB: "கால்பந்து"),
    WordPair("F. Corner", "Hockey, Football", tamilB: "ஹாக்கி, கால்பந்து"),
    WordPair("G. Deuce", "Tennis", tamilB: "டென்னிஸ்"),
    WordPair("H. Jockey", "Horse riding", tamilB: "குதிரை சவாரி"),
    WordPair("I. Sword", "Fencing", tamilB: "வாள்வீச்சு விளையாட்டு"),
    WordPair("J. Ping pong", "Table tennis", tamilB: "மேசை டென்னிஸ்"),
  ],
);

// ---------------------------------------------------------------------
// 15) FUN WITH WORDS — IV. COUNTRY ↔ CURRENCY MATCHING  (9 pairs)
//     The book gives this as a shuffled matching exercise (two scrambled
//     versions, tables 29 & 30) with no answer key. Real-world correct
//     pairs are used below. One assumption: "Sterling" is one of the 9
//     currency names given but no European country is among the 9
//     countries listed — New Zealand is matched to it here via its
//     historical Commonwealth currency link (pre-1967 NZ pound tied to
//     sterling). Changeable later if the client wants something else.
// ---------------------------------------------------------------------
final WordGroup countryCurrencyMatching = WordGroup(
  id: "country_currency",
  title: "Match the Country with Its Currency",
  tamilTitle: "நாட்டையும் அதன் நாணயத்தையும் இணைக்கவும்",
  leftLabel: "Country",
  rightLabel: "Currency",
  emoji: "💱",
  pairs: const [
    WordPair("Russia", "Rouble", tamilB: "ரூபிள்"),
    WordPair("Pakistan", "Rupee", tamilB: "ரூபாய்"),
    WordPair("South Africa", "Rand", tamilB: "ராண்ட்"),
    WordPair("Japan", "Yen", tamilB: "யென்"),
    WordPair("Burma", "Kyat", tamilB: "கியாட்"),
    WordPair("Canada", "Dollar", tamilB: "டாலர்"),
    WordPair("Mexico", "Peso", tamilB: "பெசோ"),
    WordPair("New Zealand", "Sterling", tamilB: "ஸ்டெர்லிங் (பழைய கால காமன்வெல்த் தொடர்பு — இது ஒரு அனுமானம்)"),
    WordPair("Brazil", "Cruzeiro", tamilB: "குருசெய்ரோ"),
  ],
);

// ---------------------------------------------------------------------
// 16) EXERCISE YOUR VOCABULARY — Animal / Profession ↔ Association matching
//     (10 pairs). The book's Group B list has two garbled OCR words —
//     "Humplet" (read as Trumpet, matching the animal-sounds table's
//     "Elephants → Trumpet") and "Hund" (read as Hand, for a potter
//     shaping clay by hand) — both flagged as reasonable reconstructions.
// ---------------------------------------------------------------------
final WordGroup animalAssociationMatching = WordGroup(
  id: "animal_association",
  title: "Match Group A with Group B",
  tamilTitle: "குழு A ஐ குழு B உடன் இணைக்கவும்",
  leftLabel: "Group A",
  rightLabel: "Group B",
  emoji: "🐘",
  pairs: const [
    WordPair("Birds", "Fly", tamilB: "பறத்தல்"),
    WordPair("Monkeys", "Chatter", tamilB: "பேச்சொலி எழுப்புதல்"),
    WordPair("Elephant", "Trumpet", tamilB: "பீப்பிடுதல் (\"Humplet\" எனப் படிக்கக்கூடிய மங்கலான சொல்)"),
    WordPair("Banana", "Fruit", tamilB: "பழம்"),
    WordPair("Sheep", "Mutton", tamilB: "ஆட்டு இறைச்சி"),
    WordPair("Philatelist", "Stamps", tamilB: "தபால்தலை சேகரிப்பு"),
    WordPair("Carpenter", "Wood", tamilB: "மரவேலை"),
    WordPair("Potter", "Hand", tamilB: "கையால் வடிவமைத்தல் (\"Hund\" எனப் படிக்கக்கூடிய மங்கலான சொல் — அனுமானம்)"),
    WordPair("Florist", "Flowers", tamilB: "பூக்கள்"),
    WordPair("Musician", "Music", tamilB: "இசை"),
  ],
);

final List<WordGroup> matchingPuzzles = [
  gamesMatching,
  countryCurrencyMatching,
  animalAssociationMatching,
];

// ---------------------------------------------------------------------
// 17) LEMONADE VOCABULARY TEST — "connect the theme"  (10 items)
//     No answer key exists in the book for this test at all — these are
//     the standard/expected answers, per Salim's go-ahead.
// ---------------------------------------------------------------------
final List<ThemeQuizItem> lemonadeQuiz = const [
  ThemeQuizItem(clues: ["Monitors", "Motherboard", "Software", "Floppy"], answer: "Computer", tamilAnswer: "கணினி"),
  ThemeQuizItem(clues: ["Sleeper", "Bogey", "Track", "Coach"], answer: "Train", tamilAnswer: "ரயில்"),
  ThemeQuizItem(clues: ["Counter", "Currency", "Cashier", "Manager"], answer: "Bank", tamilAnswer: "வங்கி"),
  ThemeQuizItem(clues: ["Ticket", "Matinee show", "House full"], answer: "Cinema", tamilAnswer: "திரையரங்கம்"),
  ThemeQuizItem(clues: ["Procession", "Members", "Supporters", "Well-wishers"], answer: "Political rally", tamilAnswer: "அரசியல் பேரணி"),
  ThemeQuizItem(clues: ["Advertisement", "Article", "Report", "Editorial"], answer: "Newspaper", tamilAnswer: "செய்தித்தாள்"),
  ThemeQuizItem(clues: ["Lens", "Shutter", "Flash", "Speed"], answer: "Camera", tamilAnswer: "கேமரா"),
  ThemeQuizItem(clues: ["Tail", "Horns", "Milk", "Grass"], answer: "Cow", tamilAnswer: "பசு"),
  ThemeQuizItem(clues: ["Groceries", "Consumables", "Cosmetics", "Stationery"], answer: "Supermarket", tamilAnswer: "பெரங்காடி (சூப்பர்மார்க்கெட்)"),
  ThemeQuizItem(clues: ["Law and order", "Crime", "Lock-up", "Constable"], answer: "Police station", tamilAnswer: "காவல் நிலையம்"),
];

// ---------------------------------------------------------------------
// 18) STAND-ALONE PUZZLES (V, IX, X from "Fun with Words")
// ---------------------------------------------------------------------
final List<PuzzleReference> puzzleReferences = const [
  PuzzleReference(
    title: "V. Missing Letters",
    tamilTitle: "V. விடுபட்ட எழுத்துகள்",
    description:
        "Place these 8 letters — C D R R S S S W — into a grid to form two words that share one letter in common.",
    tamilDescription:
        "C D R R S S S W ஆகிய 8 எழுத்துகளையும் ஒரு கட்டத்தில் அமைத்து, ஒரு எழுத்தைப் பகிர்ந்துகொள்ளும் இரண்டு வார்த்தைகளை உருவாக்கவும்.",
    solution: "CROSS and WORDS — together \"CROSSWORDS\" — sharing the letter O in the middle.",
    tamilSolution: "CROSS மற்றும் WORDS — சேர்த்தால் \"CROSSWORDS\" — நடுவே உள்ள 'O' எழுத்தைப் பகிர்ந்துகொள்கின்றன.",
  ),
  PuzzleReference(
    title: "IX. The Bottle Puzzle — One Word, Many Meanings",
    tamilTitle: "IX. பாட்டில் புதிர் — ஒரே வார்த்தை, பல அர்த்தங்கள்",
    description:
        "The book's original puzzle here was a hand-drawn picture with no printed answer anywhere in the text, so here's a new picture puzzle in the same spirit instead. This bottle's label says \"SPIRIT\". In English, that one word can mean more than one thing. Look at the label, then think: what does \"spirit\" mean here — and what else can it mean?",
    tamilDescription:
        "இந்தப் புதிரின் மூல வடிவம் புத்தகத்தில் ஒரு படமாக மட்டும் இருந்தது, அதற்கான பதில் புத்தகத்தில் எங்கும் இல்லை — அதனால் அதே உணர்வில் ஒரு புதிய படப் புதிர் இங்கே. இந்த பாட்டிலின் லேபிளில் \"SPIRIT\" என்று எழுதியிருக்கிறது. ஆங்கிலத்தில் இந்த ஒரே வார்த்தைக்கு ஒன்றுக்கு மேற்பட்ட அர்த்தங்கள் உண்டு. லேபிளைப் பார்த்து யோசியுங்கள்: இங்கே \"spirit\" என்றால் என்ன அர்த்தம் — வேறு என்ன அர்த்தமும் இருக்கலாம்?",
    solution:
        "\"Spirit\" has two common meanings: 1) A strong alcoholic drink (like whisky, rum or brandy) — which is what this bottle holds. 2) A person's soul, mood or inner energy — as in \"high spirits\" or \"the human spirit\". One word, two very different meanings — English has many words like this!",
    tamilSolution:
        "\"Spirit\" என்ற வார்த்தைக்கு இரண்டு பொதுவான அர்த்தங்கள் உண்டு: 1) ஒரு கடுமையான மதுபானம் (விஸ்கி, ரம் போன்றவை) — இந்த பாட்டிலில் இருப்பது இதுதான். 2) ஒருவரின் ஆன்மா, மனநிலை அல்லது உள் ஆற்றல் — \"high spirits\" (உற்சாகம்) போன்ற பயன்பாட்டில். ஒரே வார்த்தை, முற்றிலும் வேறுபட்ட இரண்டு அர்த்தங்கள் — ஆங்கிலத்தில் இது போன்ற பல வார்த்தைகள் உண்டு!",
    imageAsset: "assets/module2/bottle_spirit.png",
  ),
  PuzzleReference(
    title: "X. Can You Find All 26 Letters?",
    tamilTitle: "X. 26 எழுத்துகளும் கண்டுபிடிக்க முடியுமா?",
    description:
        "The book's original puzzle here asked you to fit all 26 letters of the alphabet into a crossword grid — a picture with no printed answer anywhere in the text. Here's something just as fun you can try anywhere: can you think of a sentence that uses every single letter from A to Z at least once? English calls this a \"pangram\".",
    tamilDescription:
        "இந்தப் புதிரின் மூல வடிவம் 26 எழுத்துகளையும் ஒரு குறுக்கெழுத்துக் கட்டத்தில் பொருத்தச் சொன்னது — அதற்கான பதிலும் புத்தகத்தில் இல்லை. அதே போன்ற வேடிக்கையான ஒன்று: A முதல் Z வரை உள்ள ஒவ்வொரு எழுத்தும் குறைந்தது ஒரு முறையாவது வரும்படி ஒரு வாக்கியத்தை யோசிக்க முடியுமா? ஆங்கிலத்தில் இதற்கு \"pangram\" என்று பெயர்.",
    solution:
        "Here's a famous example: \"The quick brown fox jumps over the lazy dog.\" Check it yourself — it uses every letter from A to Z, all in one sentence!",
    tamilSolution:
        "இதோ ஒரு பிரபலமான உதாரணம்: \"The quick brown fox jumps over the lazy dog.\" இதை நீங்களே சரிபார்க்கலாம் — A முதல் Z வரை உள்ள எல்லா எழுத்துகளும் இந்த ஒரே வாக்கியத்தில் வந்திருக்கும்!",
  ),
];
