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
//
// Tamil coverage: every reading passage has a full Tamil translation
// (`tamilPassage`), the letter-writing checklist has a Tamil line per
// tip, both model letters have a Tamil subject and Tamil body
// paragraphs, and all five story hints have a Tamil translation of both
// their hint outline and their sample story — not just Tamil titles.

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
    tamilPassage:
        "ஊழல் மனித உரிமைகளையும் சட்டத்தின் ஆட்சியையும் பாதிக்கிறது என்பதை "
        "உணர்ந்து, இந்தியாவில் பல உரிமை அடிப்படையிலான உத்திகள் மூலம் ஊழல் "
        "இல்லா ஆட்சிக்கான உரிமையை NHRC உருவாக்குவது முக்கியம். ஆட்சிக்கான "
        "உரிமை அடிப்படையிலான அணுகுமுறைகள் என்பவை, சமூக மற்றும் பொருளாதார "
        "இலக்குகள் வெறும் கொள்கை நோக்கங்களாக நீடிக்காமல், குடிமக்களுக்கு "
        "வழங்கப்படும் உரிமைகளாக மாறும் என்ற கருத்தியல் அடித்தளத்தின் மீது "
        "அமைந்தவை — இது பொதுமக்களின் கண்காணிப்பிற்கான ஊக்கத்தை அதிகரிக்கிறது. "
        "இந்தக் கருத்தில் \"உரிமை பெறுபவர்கள்\" மற்றும் \"கடமை வகிப்பவர்கள்\" "
        "என இருவகையினர் உள்ளனர்: முன்பு கொள்கை நோக்கங்களாகக் கருதப்பட்ட "
        "பல்வேறு சமூக மற்றும் பொருளாதார இலக்குகள் தொடர்பான உரிமைகள் "
        "மக்களுக்கு இருக்கும். குறிப்பிட்ட உரிமையைப் பாதுகாத்து மேம்படுத்தும் "
        "கடமை அரசாங்கத்தின் பிரதிநிதிகளுக்கு வழங்கப்பட்டுள்ளது.",
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
    tamilPassage:
        "அன்னை தெரேசா தன் வாழ்நாள் முழுவதும் தாழ்மையாகவும், எளிமையாகவும், "
        "பல வகைகளில் ஒரு சாதாரண பெண்ணாகவே இருந்தார். ஆயினும் அவர் "
        "இருபதாம் நூற்றாண்டின் மிகவும் அசாதாரணமான வாழ்க்கைகளில் ஒன்றை "
        "வாழ்ந்தார். அவர் பெரும் கல்வியறிவு பெற்றவர் அல்ல, ஆனால் அவரது "
        "தூய்மைப்படுத்தப்பட்ட ஞானம் எந்த தத்துவ ஞானியையும் போல ஆழமானதாக "
        "இருந்தது. ஒரு நேரத்தில் ஒரு சிறிய அடி எடுத்து வைப்பதில் அவர் "
        "நம்பிக்கை கொண்டிருந்தார், ஆயினும் உலகின் பல பகுதிகளில் ஒரே "
        "நேரத்தில் பல சிக்கலான செயல்பாடுகளைக் கையாண்டார். தன் பணியை "
        "சாத்தியமாக்கிய மில்லியன் கணக்கான நன்கொடைகள் மற்றும் உயில் மூலம் "
        "கிடைத்தவற்றுக்கு அவர் நன்றியுடன் இருந்தார், ஆனால் மூன்று நாட்களுக்கு "
        "சர்க்கரை சாப்பிடாமல் சேமித்த ஒரு ரூபாயை அவருக்குக் கொடுத்த "
        "கல்கத்தாவின் சிறுவனைப் போன்ற 'தியாகப்' பணத்தை மட்டுமே அவர் "
        "நினைவில் வைத்திருந்தார். பெரும்பாலும் இந்து மதத்தினர் வாழும் "
        "இந்தியாவில் வாழ்ந்து பணியாற்றினாலும், அவர் மதமாற்றத்திற்கு எந்த "
        "முயற்சியும் செய்யவில்லை. மதமாற்றம் தன் வேலை அல்ல, கடவுளின் வேலை "
        "என்று அவர் கூறினார். இந்த நிலைப்பாட்டைப் பிரதிபலிக்கும் விதமாக, "
        "தான் பணிவிடை செய்த அனைவரிடமும் இயேசுவைக் கண்ட அவர், இயேசுவுக்கு "
        "உண்மையாக இருந்தபடியே, தன் சூழலுக்கும் புத்திசாலித்தனமாக இசைவாக "
        "இருந்தார்.",
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
    tamilPassage:
        "இன்ஸ்டிடியூட் ஆஃப் ரூரல் மேனேஜ்மென்ட், ஆனந்த் — பொதுவாக IRMA என "
        "அறியப்படுவது — 1979ல் தொடங்கப்பட்டதிலிருந்து, கிராமப்புற "
        "நிறுவனங்களின் தொழில்முறை நிர்வாகத்திற்கான ஒரு உயரிய நிறுவனமாக "
        "வளர்ந்துள்ளது.\n\n"
        "நாட்டின் பால் தலைநகரமான குஜராத் மாநிலத்தின் ஆனந்தில் அமைந்துள்ள "
        "இந்நிறுவனம், தேசிய பால் வளர்ச்சி வாரியத்தின் (NDDB) முன்முயற்சியில், "
        "மாநில மற்றும் மத்திய அரசுகள் மற்றும் சுவிஸ் மேம்பாட்டு "
        "ஒத்துழைப்பின் ஆதரவுடன் நிறுவப்பட்டது. இது கூட்டுறவு சங்கங்கள், "
        "தன்னார்வ தொண்டு நிறுவனங்கள், அரசுகள், தேசிய மற்றும் சர்வதேச "
        "நிறுவனங்களுடன் நெருக்கமாகச் செயல்பட்டு வருகிறது. சமீபத்திய "
        "கணக்கெடுப்புகளில் IRMA மிக உயர்ந்த மதிப்பீடுகளைப் பெற்றுள்ளது. "
        "தொழில்துறை தொடர்பு மற்றும் சர்வதேச இணைப்புகளில் இது "
        "பொறாமைக்குரிய நற்பெயரைப் பெற்றுள்ளது.\n\n"
        "கிராமப்புற நிறுவனங்கள் மற்றும் திட்டங்களின் நிர்வாகத்தை மேம்படுத்த "
        "ஆராய்ச்சி மற்றும் ஆலோசனை சேவைகளை வழங்குவதுடன், IRMA கிராமப்புற "
        "மேலாண்மையில் முதுகலை மற்றும் முனைவர் பட்ட படிப்புகளையும் "
        "வழங்குகிறது. கிராமப்புற கூட்டுறவுத் துறை மற்றும் மேம்பாட்டு "
        "நிறுவனங்களில் சவாலான மேலாண்மைப் பொறுப்புகளை மேற்கொள்ள "
        "விரும்புவோருக்கு, அதன் கிராமப்புற மேலாண்மைத் திட்டம் (PRM) "
        "நாட்டிலேயே சிறந்த படிப்புகளில் ஒன்றாகும்.",
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
    tamilPassage:
        "பெரும்பாலான ஆய்வுகள் காட்டுவது என்னவென்றால், ஆண்களை விட பெண்கள் "
        "தங்கள் தனித்துவத்தை நிலைநாட்டுவதில் அதிக சிரமத்தை எதிர்கொள்கின்றனர். "
        "ஆண்கள் தங்கள் வேலைக்காக வாழ்கின்றனர், பெண்கள் காதலுக்காக "
        "வாழ்கின்றனர் என்பது பழைய stereotype; எனவே ஒரு உறவு "
        "முடிவடையும்போது, விவாகரத்து நிகழும்போது, அல்லது ஒரு நட்பு "
        "உடைந்துவிடும்போது, ஆண்களை விட பெண்களுக்கே அது கடினமாக "
        "இருக்கும்.\n\n"
        "இதன் பொருள் பெண்கள் இயற்கையிலேயே பலவீனமானவர்களா, அதிகம் "
        "சார்ந்திருப்பவர்களா என்பதா? இல்லவே இல்லை. பெரும்பாலான சிறு "
        "குழந்தைகள் தங்கள் ஆரம்ப ஆண்டுகளில் தந்தையை விட தாயுடன் அதிக "
        "நேரம் செலவிடுகின்றன என்ற உண்மையுடன் இது தொடர்புடையது. நான்சி "
        "சோடோரோ இந்தத் துறையில் சிறப்பான ஆய்வுகளைச் செய்துள்ளார். ஒரு சிறு "
        "பையன் தான் தன் தாயைப் போல இல்லை என்பதையும், அவளிடமிருந்து தன்னை "
        "வேறுபடுத்திக்கொள்ள வேண்டும் என்பதையும் விரைவில் உணர்கிறான் என்று "
        "அவர் சுட்டிக்காட்டுகிறார். ஆண்மை பிரிவினையால் வரையறுக்கப்படுகிறது. "
        "மறுபுறம், ஒரு பெண் குழந்தைக்கு அப்படி ஒரு தேவை இல்லை, அவள் தன் "
        "தாயுடன் நெருக்கமாகவே இருக்கிறாள். இந்த உண்மைகள் நாம் பெரியவர்களாக "
        "ஆகும்போது எப்படி சமாளிக்கிறோம் என்பதில் பெரும் தாக்கத்தை "
        "ஏற்படுத்துகின்றன. ஆண்கள் பெரும்பாலும் தனித்து நிற்பதில் "
        "திறமையாக வளர்கின்றனர், ஆனால் நெருக்கத்தில் சிரமப்படுகின்றனர். "
        "பெண்கள் பெரும்பாலும் உறவுகளில் திறமையாக வளர்கின்றனர், ஆனால் "
        "தனித்து நிற்பதில் சிரமப்படுகின்றனர்.",
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
    tamilPassage:
        "எதிர்வினைகள் என்பவை கற்றுக்கொள்ளப்பட்ட நடத்தைகள்.\n\n"
        "மக்கள் முரண்பாடுகளுக்கு வெவ்வேறு விதமாக எதிர்வினையாற்றுகின்றனர், "
        "சிலர் அமைதியாகவும், சிலர் வெடிப்பாகவும். சிலர் "
        "முரண்பாட்டிலிருந்து விலகி ஓடுகின்றனர், சிலர் மீண்டும் போராட "
        "வருகின்றனர். சிலர் பேச்சுவார்த்தை வழிகளைத் தேடுகின்றனர், சிலர் "
        "தங்கள் வழியையே தொடர்ந்து வலியுறுத்துகின்றனர். முரண்பாடுகள் பல "
        "வடிவங்களில் வருவது போலவே, நம் எதிர்வினைகளும் பலவகைப்படும்.\n\n"
        "நாம் முரண்பாடுகளுக்கு எதிர்வினையாற்றும் விதம், நாம் வளரும்போது "
        "முரண்பாடுகளை எப்படி அனுபவித்தோம் என்பதையும் பெரும்பாலும் "
        "பொறுத்தது. இன்றைய எதிர்வினைகள் பெரும்பாலும் நேற்றைய மாதிரியை "
        "அடிப்படையாகக் கொண்டவையே. நீங்கள் வளரும்போது, உங்களைச் "
        "சுற்றியிருந்தவர்கள் முரண்பாடுகளை எப்படிக் கையாண்டனர்? உங்கள் "
        "பெற்றோர், ஆசிரியர்கள், மத தலைவர்கள், ஸ்கவுட் தலைவர்கள் "
        "உங்களுக்கு என்ன செய்திகளைத் தந்தனர்?\n\n"
        "முரண்பாடுகளுக்கான நம் எதிர்வினைகள் நம் வாழ்க்கையின் "
        "ஆரம்பத்திலேயே கற்றுக் கொள்ளப்பட்டவை. இந்த மாதிரிகள் நம் பெரியவர் "
        "நடத்தை மற்றும் மனப்பான்மையில் ஆழமாக பதிந்துள்ளன. அதிர்ஷ்டவசமாக, "
        "நாம் மீண்டும் கற்று, முரண்பாடுகளுக்கு எதிர்வினையாற்றும் விதத்தை "
        "மாற்றிக்கொள்ள முடியும்.\n\n"
        "நீங்கள் முரண்பாட்டுக்கு எதிர்வினையாற்றும் விதங்களை மறுபரிசீலனை "
        "செய்வது, முரண்பாடுகள் எப்படி வேலை செய்கின்றன என்பதைப் "
        "புரிந்துகொள்வதற்கான இன்னொரு பகுதியாகும். நாம் எப்படி "
        "எதிர்வினையாற்றுகிறோம் என்பதைப் பற்றிய அதிக விழிப்புணர்வு, சில "
        "முரண்பாடுகள் தீவிரமடைவதைத் தடுக்க உதவும்; நாம் எப்படி "
        "எதிர்வினையாற்றுவது என்பதை நாமே தேர்வு செய்யலாம். முரண்பாடுகள் "
        "ஏற்படும்போது, புதிய மற்றும் சிறந்த முறையில் எதிர்வினையாற்ற நாம் "
        "உண்மையிலேயே கற்றுக்கொள்ளலாம்.",
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

const List<String> letterWritingTamilTips = [
  "வடிவமைப்பு அதிகாரப்பூர்வமானதாக இருக்க வேண்டும்.",
  "வாழ்த்துரை (Salutation) அதிகாரப்பூர்வமானதாக இருக்க வேண்டும்.",
  "பொருளை (Subject) குறிப்பிடவும்.",
  "உங்களை அறிமுகப்படுத்திக் கொள்ளுங்கள்.",
  "நோக்கத்தைத் தெரிவிக்கவும்.",
  "உங்கள் கோரிக்கையை அல்லது வேண்டுகோளை வையுங்கள்.",
  "உங்கள் கோரிக்கையில் தெளிவாக இருங்கள்.",
  "நன்றி மற்றும் கையொப்பத்துடன் கடிதத்தை முடிக்கவும்.",
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
    tamilSubject: "பொருள்: பொருந்தும் சான்றிதழுக்கான கோரிக்கை.",
    body: [
      "Respected Sir,",
      "I am a student of I B.A., Economics class; my Roll No. is 02416.",
      "I am a day scholar residing at Tiruverambur. Kindly furnish me with a 'Bonafide Certificate' to help me avail a 'Bus Pass' from the Transport authority concerned.",
      "Thank You,",
      "Yours Faithfully,\n(Signature)",
    ],
    tamilBody: [
      "மதிப்பிற்குரிய ஐயா,",
      "நான் I B.A., பொருளியல் வகுப்பு மாணவன்; எனது Roll No. 02416.",
      "நான் திருவெரம்பூரில் வசிக்கும் டே ஸ்காலர். போக்குவரத்து அதிகாரிகளிடமிருந்து 'பஸ் பாஸ்' பெற உதவும் வகையில், எனக்கு ஒரு 'Bonafide Certificate' வழங்குமாறு தயவுசெய்து கேட்டுக்கொள்கிறேன்.",
      "நன்றி,",
      "தங்கள் உண்மையுள்ள,\n(கையொப்பம்)",
    ],
  ),
  ModelLetter(
    title: "Request for Conduct / Transfer Certificate",
    tamilTitle: "நடத்தை / மாற்றுச் சான்றிதழுக்கான கோரிக்கை",
    emoji: "📄",
    dateLine: "Date: 02.07.2007, Tiruchy",
    subject: "Sub: Request for Conduct Certificate, Transfer Certificate etc.,",
    tamilSubject: "பொருள்: நடத்தைச் சான்றிதழ், மாற்றுச் சான்றிதழ் போன்றவற்றிற்கான கோரிக்கை,",
    body: [
      "Respected Sir,",
      "I was a student of the I B.Sc., Mathematics class from 2004 to 2007. I request you to furnish me with my Conduct Certificate and Transfer Certificate.",
      "I have enclosed the 'No Dues Certificate' from the department concerned.",
      "Thank You,",
      "Yours Faithfully,\n(Signature)",
    ],
    tamilBody: [
      "மதிப்பிற்குரிய ஐயா,",
      "நான் 2004 முதல் 2007 வரை I B.Sc., கணிதவியல் வகுப்பு மாணவனாக இருந்தேன். எனக்கு எனது நடத்தைச் சான்றிதழையும் மாற்றுச் சான்றிதழையும் வழங்குமாறு கேட்டுக்கொள்கிறேன்.",
      "சம்பந்தப்பட்ட துறையிலிருந்து பெற்ற 'No Dues Certificate'-ஐ இத்துடன் இணைத்துள்ளேன்.",
      "நன்றி,",
      "தங்கள் உண்மையுள்ள,\n(கையொப்பம்)",
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
    tamilHint:
        "ஒரு தேனீ — குளத்தில் விழுகிறது — ஒரு புறா பறந்து செல்கிறது — "
        "தண்ணீரில் ஒரு பெரிய இலையைப் போடுகிறது — தேனீ இலையின் மீது "
        "ஏறுகிறது — பறந்து செல்கிறது — ஒரு பையன் புறாவை குறி வைக்கிறான் — "
        "தேனீ அவனைக் கொட்டுகிறது — புறா காப்பாற்றப்படுகிறது.",
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
    tamilSampleStory:
        "ஒரு தேனீ, குளத்தில் தண்ணீர் குடிக்கும்போது வழுக்கி விழுந்தது. "
        "ஈரமான இறக்கைகளால் பறக்க முடியாமல், அது மூழ்கும் ஆபத்தில் "
        "இருந்தது. அப்போது ஒரு புறா பறந்து சென்று, தேனீ போராடுவதைக் கண்டு, "
        "தண்ணீரில் ஒரு பெரிய இலையைப் போட்டது. தேனீ இலையின் மீது ஏறி, தன் "
        "இறக்கைகளை உலரவைத்து, பாதுகாப்பாகப் பறந்து சென்றது. சில "
        "நாட்களுக்குப் பிறகு, ஒரு பையன் கவண் வைத்துக்கொண்டு மெதுவாக "
        "நெருங்கி, கிளையில் ஓய்வெடுத்துக் கொண்டிருந்த, ஆபத்தை அறியாத "
        "புறாவைக் குறி வைத்தான். இதைக் கண்ட தேனீ, முன்னோக்கிச் சென்று "
        "பையனின் கையில் கடுமையாகக் கொட்டியது. அவன் கூச்சலிட்டு குறி "
        "தவறினான், புறா காயமின்றிப் பறந்து சென்றது — தான் ஒருமுறை "
        "காப்பாற்றிய அதே தேனீயால் திரும்பவும் காப்பாற்றப்பட்டது.",
  ),
  StoryHint(
    title: "The Hen That Laid Golden Eggs",
    tamilTitle: "பொன் முட்டையிடும் கோழி",
    emoji: "🥚",
    hint:
        "A man has a hen which lays a golden egg everyday — the man "
        "collects ten eggs in ten days, then he gets impatient — wants to "
        "become rich overnight — kills the hen.",
    tamilHint:
        "ஒரு மனிதனிடம் ஒவ்வொரு நாளும் பொன் முட்டையிடும் ஒரு கோழி "
        "இருக்கிறது — மனிதன் பத்து நாட்களில் பத்து முட்டைகளைச் "
        "சேகரிக்கிறான், பிறகு பொறுமை இழக்கிறான் — ஒரே இரவில் பணக்காரனாக "
        "ஆக விரும்புகிறான் — கோழியைக் கொல்கிறான்.",
    sampleStory:
        "A poor man owned a hen that laid one golden egg every day. Each "
        "morning he sold the egg and slowly grew richer. After ten days, "
        "with ten golden eggs sold, he grew impatient — why wait a whole "
        "day for just one egg, when the hen's body must be full of gold "
        "all at once? Unable to control his greed, he killed the hen and "
        "cut it open, only to find it was an ordinary hen inside, with no "
        "gold at all. In trying to get rich overnight, he had destroyed "
        "the very source of his good fortune.",
    tamilSampleStory:
        "ஒரு ஏழை மனிதனிடம் ஒவ்வொரு நாளும் ஒரு பொன் முட்டையிடும் கோழி "
        "இருந்தது. ஒவ்வொரு காலையும் அவன் முட்டையை விற்று மெதுவாகச் "
        "செல்வந்தனாக ஆனான். பத்து நாட்களுக்குப் பிறகு, பத்து பொன் "
        "முட்டைகளை விற்ற பின், அவனுக்குப் பொறுமை இல்லாமல் போனது — கோழியின் "
        "உடலில் ஒரே நேரத்தில் நிறைய தங்கம் இருக்கும் போது, ஒரே ஒரு "
        "முட்டைக்காக ஒரு நாள் முழுவதும் காத்திருப்பது ஏன்? தன் "
        "பேராசையைக் கட்டுப்படுத்த முடியாமல், அவன் கோழியைக் கொன்று "
        "வெட்டிப் பார்த்தான், ஆனால் உள்ளே தங்கம் எதுவும் இல்லாத ஒரு "
        "சாதாரண கோழியைத்தான் கண்டான். ஒரே இரவில் பணக்காரனாக முயன்றதில், "
        "தன் அதிர்ஷ்டத்தின் மூலத்தையே அவன் அழித்துவிட்டான்.",
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
    tamilHint:
        "ஒரு நல்ல பையன் — தன் பெற்றோருக்குக் கீழ்ப்படியாமல் இருக்கிறான் — "
        "கெட்ட நண்பர்களுடன் சேர்கிறான் — தந்தை அவனுக்குச் சில "
        "ஆப்பிள்களைக் கொடுத்து, சில நாட்களுக்கு ஒதுக்கி வைக்கச் "
        "சொல்கிறார். அவற்றுக்கிடையே ஒரு அழுகிய ஆப்பிளை வைக்கிறார் — "
        "அழுகிய ஆப்பிள் நல்ல ஆப்பிள்களைக் கெடுக்கிறது — கெட்ட "
        "நண்பர்களைப் பற்றிய பாடம்.",
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
    tamilSampleStory:
        "ஒரு நல்ல பையன் தன் பெற்றோருக்குக் கீழ்ப்படியாமல் பள்ளியில் கெட்ட "
        "நண்பர்களுடன் சேரத் தொடங்கினான். கவலைப்பட்ட தந்தை அவனுக்கு "
        "அறிவுறுத்த முயன்றார், ஆனால் தன் நண்பர்களின் சகவாசம் தனக்குத் "
        "தீங்கு செய்யாது என்று பையன் வலியுறுத்தினான். ஒரு நாள், தந்தை "
        "அவனுக்கு ஒரு கூடை புதிய ஆப்பிள்களைக் கொடுத்து, சில நாட்களுக்கு "
        "ஒதுக்கி வைக்கச் சொன்னார், ஆனால் ரகசியமாக அவற்றுக்கிடையே ஒரு "
        "அழுகிய ஆப்பிளை வைத்திருந்தார். சில நாட்களுக்குப் பிறகு, அழுகிய "
        "ஆப்பிள் அதைச் சுற்றியிருந்த கிட்டத்தட்ட எல்லா நல்ல ஆப்பிள்களையும் "
        "கெடுத்திருப்பதைப் பையன் கண்டான். 'கெட்ட நண்பர்கள் ஒரு நல்ல "
        "மனிதனுக்கு இதைத்தான் செய்வார்கள்' என்று தந்தை சொன்னார் — "
        "இறுதியில் பையன் புரிந்துகொண்டான்.",
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
    tamilHint:
        "காட்டின் வழியாகப் பயணிக்கும் இரு நண்பர்கள் — ஆபத்தில் "
        "ஒருவருக்கொருவர் உதவ ஒப்புக்கொள்கிறார்கள் — திடீரென ஒரு கரடி "
        "தோன்றுகிறது — ஒருவன் மரத்தில் ஏறுகிறான் — மற்றவன் தரையில் "
        "படுத்து மூச்சை அடக்கிக்கொள்கிறான் — கரடி அவனிடம் வருகிறது — "
        "அவன் முகத்தை முகர்கிறது — அவன் இறந்துவிட்டான் என்று நினைத்து — "
        "சென்றுவிடுகிறது — முதல் மனிதன் இப்போது கீழே இறங்குகிறான் — கரடி "
        "என்ன சொன்னது என்று மற்றவனிடம் கேட்கிறான் — பதில்: \"ஆபத்து "
        "நேரத்தில் ஓடிவிடும் நண்பனிடம் எச்சரிக்கையாக இரு.\"",
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
    tamilSampleStory:
        "இரு நண்பர்கள் காட்டின் வழியாகப் பயணித்துக் கொண்டிருந்தனர், "
        "ஆபத்து வந்தால் ஒருவருக்கொருவர் உதவுவதாக உறுதியளித்தனர். திடீரென "
        "ஒரு கரடி தோன்றியது. ஒருவன், தன் நண்பனைப் பற்றி நினைக்காமல், "
        "விரைவாக ஒரு மரத்தில் ஏறினான். மற்றவன், தப்பிக்க நேரமில்லாமல், "
        "தரையில் விழுந்து படுத்து, இறந்தவன் போல் நடித்து மூச்சை அடக்கினான். "
        "கரடி அருகில் வந்து, அவன் முகத்தையும் காதுகளையும் முகர்ந்துபார்த்து, "
        "அவன் இறந்துவிட்டான் என்று நம்பி, மெதுவாக நடந்து சென்றுவிட்டது. "
        "அது சென்றவுடன், முதல் மனிதன் கீழே இறங்கி, சிரித்துக்கொண்டே "
        "'கரடி உன் காதில் என்ன கிசுகிசுத்தது?' என்று கேட்டான். அவன் "
        "நண்பன் தீவிரமாக பதிலளித்தான், 'ஆபத்து நேரத்தில் ஓடிவிடும் "
        "நண்பனிடம் எச்சரிக்கையாக இருக்கச் சொன்னது.'",
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
    tamilHint:
        "தன் ஞானத்திற்குப் பெயர்பெற்ற சாலமன் அரசன் — அவனுடைய புகழைக் "
        "கேள்விப்பட்ட சீபா ராணி — வருகை தருகிறாள் — அவனது செல்வத்தையும் "
        "மகிமையையும் கண்டு வியக்கிறாள் — புதிர் தீர்க்கும் அவனது திறனைச் "
        "சோதிக்க விரும்புகிறாள் — தன் வலது கையில் ஒன்றும் இடது கையில் "
        "ஒன்றுமாக இரண்டு பூமாலைகளைக் காட்டுகிறாள் — ஒன்று உண்மையானது, "
        "மற்றொன்று செயற்கையானது — 'எது எது?' எனக் கேட்கிறாள் — அரசவை "
        "உறுப்பினர்கள் திகைக்கின்றனர் — இரண்டு மாலைகளும் ஒரே மாதிரி "
        "தோன்றுகின்றன — சாலமன் மௌனமாக இருக்கிறான் — ராணி வெற்றி பெற்றதாக "
        "உணர்கிறாள் — சாலமன் ஜன்னல்களைத் திறக்கச் சொல்கிறான் — "
        "தோட்டத்திலிருந்து தேனீக்கள் பறந்து வருகின்றன — ராணியைச் சுற்றி "
        "ரீங்காரமிடுகின்றன — அனைத்தும் அவளுடைய வலது கையிலுள்ள மாலையின் "
        "மீது அமர்கின்றன — வலது கையிலுள்ள பூ உண்மையானது, இடது கையிலுள்ளது "
        "செயற்கையானது என்று சாலமன் சொல்கிறான் — ராணி அவனது ஞானத்தால் "
        "வியப்படைகிறாள்.",
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
    tamilSampleStory:
        "சாலமன் அரசன் தன் ஞானத்திற்காக நாடு முழுவதும் பிரபலமானவன். "
        "அவனுடைய புகழைக் கேள்விப்பட்ட சீபா ராணி, தானே நேரில் பார்க்க "
        "அவனது அரசவைக்குப் பயணித்தாள், அவனது செல்வத்தையும் மகிமையையும் "
        "கண்டு வியந்தாள். ஆயினும், ஒரு புதிர் மூலம் அவனது ஞானத்தைச் "
        "சோதிக்க விரும்பினாள். ஒவ்வொரு கையிலும் ஒரு பூமாலையாக இரண்டு "
        "மாலைகளை உயர்த்திக் காட்டினாள் — ஒன்று உண்மையானது, மற்றொன்று "
        "அப்படியே தோன்றும் அளவுக்குத் திறமையாகச் செய்யப்பட்டது — 'எது "
        "உண்மையானது, எது செயற்கையானது?' எனக் கேட்டாள். அரசவை "
        "உறுப்பினர்கள் பார்த்துக்கொண்டே திகைத்து நின்றனர். சாலமன் ஒரு "
        "கணம் எதுவும் பேசவில்லை, பிறகு அமைதியாக மண்டபத்தின் ஜன்னல்களைத் "
        "திறக்கச் சொன்னான். உடனே, வெளியே தோட்டத்திலிருந்து தேனீக்கள் "
        "பறந்து வந்து, ராணியைச் சுற்றி ரீங்காரமிட்டு, அவளுடைய வலது "
        "கையிலுள்ள மாலையின் மீது மட்டும் அமர்ந்தன. 'உன் வலது கையிலுள்ள "
        "பூ உண்மையானது,' என்று சாலமன் கூறினான், 'இடது கையிலுள்ளது "
        "செயற்கையானது — உண்மையான தேனை தேனீக்கள் அறியும்.' ராணி ஆழமாக "
        "வியப்படைந்தாள், ஏனெனில் அவனது ஞானம் ஒரு வார்த்தை ஊகம் கூட "
        "இல்லாமல் வெற்றி பெற்றிருந்தது.",
  ),
];
