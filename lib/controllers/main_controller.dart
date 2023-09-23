import 'package:get/get.dart';
import 'package:rosary/model/days_model.dart';
import 'package:rosary/model/mystery_model.dart';
import 'package:rosary/model/prayer_model.dart';
import 'package:rosary/utils/constants.dart';

import '../data/repository/main_repo.dart';
import '../model/mystery_content_model.dart';

class MainController extends GetxController implements GetxService {
  final MainRepo mainRepo;
  MainController({required this.mainRepo});
  List<MysteryModel> mainMysteryList = [
    MysteryModel(
        id: 1,
        name: AppConstant.JOYFUL_MYSTERY,
        days: "",
        img: "",
        mysteryList: [
          MysteryContentModel(
            id: 1,
            imageUrl: "${AppConstant.JOYFUL_IMG_PATH}1.jpg",
            title: "First Joyful Mystery: The Annunciation",
            content: [
              '**Scripture: Luke 1:26-38**',
              "In the sixth month the angel Gabriel was sent from God to a city of Galilee named Nazareth, to a virgin betrothed to a man whose name was Joseph, of the house of David; and the virgin’s name was Mary. And he came to her and said, “Hail, full of grace, the Lord is with you!” But she was greatly troubled at the saying, and considered in her mind what sort of greeting this might be.",
              "And the angel said to her, “Do not be afraid, Mary, for you have found favor with God. And behold, you will conceive in your womb and bear a son, and you shall call his name Jesus.",
              "He will be great, and will be called the Son of the Most High;\nand the Lord God will give to him the throne of his father David,\nand he will reign over the house of Jacob for ever;\nand of his kingdom there will be no end.”",
              "And Mary said to the angel, “How shall this be, since I have no husband?”",
              "And the angel said to her,\n“The Holy Spirit will come upon you,\nand the power of the Most High will overshadow you;\ntherefore the child to be born* will be called holy,\nthe Son of God.",
              "And behold, your kinswoman Elizabeth in her old age has also conceived a son; and this is the sixth month with her who was called barren. For with God nothing will be impossible.” And Mary said, “Behold, I am the handmaid of the Lord; let it be to me according to your word.” And the angel departed from her."
            ],
          ),
          MysteryContentModel(
            id: 2,
            imageUrl: "${AppConstant.JOYFUL_IMG_PATH}2.jpg",
            title: "Second Joyful Mystery: The Visitation",
            content: [
              '**Scripture: Luke 1:39-45**',
              "In those days Mary arose and went with haste into the hill country, to a city of Judah, and she entered the house of Zechariah and greeted Elizabeth.",
              "And when Elizabeth heard the greeting of Mary, the babe leaped in her womb; and Elizabeth was filled with the Holy Spirit and she exclaimed with a loud cry, “Blessed are you among women, and blessed is the fruit of your womb! And why is this granted me, that the mother of my Lord should come to me?",
              "For behold, when the voice of your greeting came to my ears, the babe in my womb leaped for joy. And blessed is she who believed that there would be a fulfillment of what was spoken to her from the Lord.”."
            ],
          ),
          MysteryContentModel(
            id: 3,
            imageUrl: "${AppConstant.JOYFUL_IMG_PATH}3.jpg",
            title: "Third Joyful Mystery: The Nativity",
            content: [
              '**Scripture: Luke 2:1-14**',
              "In those days a decree went out from Caesar Augustus that all the world should be enrolled. This was the first enrollment, when Quirinius was governor of Syria.",
              "And all went to be enrolled, each to his own city. And Joseph also went up from Galilee, from the city of Nazareth, to Judea, to the city of David, which is called Bethlehem, because he was of the house and lineage of David, to be enrolled with Mary, his betrothed, who was with child.",
              "And while they were there, the time came for her to be delivered. And she gave birth to her first-born son and wrapped him in swaddling cloths, and laid him in a manger, because there was no place for them in the inn.",
              "And in that region there were shepherds out in the field, keeping watch over their flock by night. And an angel of the Lord appeared to them, and the glory of the Lord shone around them, and they were filled with fear.",
              "And the angel said to them, 'Be not afraid; for behold, I bring you good news of a great joy which will come to all the people; for to you is born this day in the city of David a Savior, who is Christ the Lord.",
              "And this will be a sign for you: you will find a babe wrapped in swaddling cloths and lying in a manger.'",
              "And suddenly there was with the angel a multitude of the heavenly host praising God and saying,",
              "'Glory to God in the highest,",
              "and on earth peace among men with whom he is pleased!'."
            ],
          ),
          MysteryContentModel(
            id: 4,
            imageUrl: "${AppConstant.JOYFUL_IMG_PATH}4.jpg",
            title: "Fourth Joyful Mystery: The Presentation in the Temple",
            content: [
              '**Scripture: Luke 2:22-38**',
              "And when the time came for their purification according to the law of Moses, they brought him up to Jerusalem to present him to the Lord (as it is written in the law of the Lord, 'Every male that opens the womb shall be called holy to the Lord') and to offer a sacrifice according to what is said in the law of the Lord, 'a pair of turtledoves, or two young pigeons.'",
              "Now there was a man in Jerusalem, whose name was Simeon, and this man was righteous and devout, looking for the consolation of Israel, and the Holy Spirit was upon him. And it had been revealed to him by the Holy Spirit that he should not see death before he had seen the Lord’s Christ. And inspired by the Spirit, he came into the temple; and when the parents brought in the child Jesus, to do for him according to the custom of the law, he took him up in his arms and blessed God and said,",
              "\"Lord, now lettest thou thy servant depart in peace,",
              "according to thy word;",
              "for mine eyes have seen thy salvation",
              "which thou hast prepared in the presence of all peoples,",
              "a light for revelation to the Gentiles,",
              "and for glory to thy people Israel.\"",
              "And his father and his mother marveled at what was said about him; and Simeon blessed them and said to Mary his mother,",
              "\"Behold, this child is set for the fall and rising of many in Israel,",
              "and for a sign that is spoken against",
              "(and a sword will pierce through your own soul also),",
              "that thoughts out of many hearts may be revealed.\"",
              "And there was a prophetess, Anna, the daughter of Phanu-el, of the tribe of Asher; she was of a great age, having lived with her husband seven years from her virginity, and as a widow till she was eighty-four. She did not depart from the temple, worshiping with fasting and prayer night and day. And coming up at that very hour she gave thanks to God, and spoke of him to all who were looking for the redemption of Jerusalem."
            ],
          ),
          MysteryContentModel(
            id: 5,
            imageUrl: "${AppConstant.JOYFUL_IMG_PATH}5.jpg",
            title: "Fifth Joyful Mystery: The Finding in the Temple",
            content: [
              '**Scripture: Luke 2:41-52**',
              "Now his parents went to Jerusalem every year at the feast of the Passover. And when he was twelve years old, they went up according to custom; and when the feast was ended, as they were returning, the boy Jesus stayed behind in Jerusalem. His parents did not know it, but supposing him to be in the company they went a day’s journey, and they sought him among their kinsfolk and acquaintances; and when they did not find him, they returned to Jerusalem, seeking him.",
              "After three days they found him in the temple, sitting among the teachers, listening to them and asking them questions; and all who heard him were amazed at his understanding and his answers. And when they saw him they were astonished; and his mother said to him, 'Son, why have you treated us so? Behold, your father and I have been looking for you anxiously.'",
              "And he said to them, 'How is it that you sought me? Did you not know that I must be in my Father’s house?' And they did not understand the saying which he spoke to them. And he went down with them and came to Nazareth, and was obedient to them; and his mother kept all these things in her heart.",
              "And Jesus increased in wisdom and in stature, and in favor with God and man."
            ],
          ),
        ]),
    MysteryModel(
        id: 2,
        name: AppConstant.SORROWFUL_MYSTERY,
        days: "",
        img: "",
        mysteryList: [
          MysteryContentModel(
            id: 1,
            imageUrl: "${AppConstant.SORROWFUL_IMG_PATH}1.jpg",
            title:
                "First Sorrowful Mystery: The Agony in the Garden", // Replicated title
            content: [
              '**Scripture: Matthew 26:36-46**',
              "Then Jesus went with them to a place called Gethsemane, and he said to his disciples, 'Sit here, while I go yonder and pray.' And taking with him Peter and the two sons of Zebedee, he began to be sorrowful and troubled.",
              "Then he said to them, 'My soul is very sorrowful, even to death; remain here, and watch with me.' And going a little farther he fell on his face and prayed, 'My Father, if it be possible, let this cup pass from me; nevertheless, not as I will, but as thou wilt.'",
              "And he came to the disciples and found them sleeping; and he said to Peter, 'So, could you not watch with me one hour? Watch and pray that you may not enter into temptation; the spirit indeed is willing, but the flesh is weak.'",
              "Again, for the second time, he went away and prayed, 'My Father, if this cannot pass unless I drink it, thy will be done.' And again he came and found them sleeping, for their eyes were heavy.",
              "So, leaving them again, he went away and prayed for the third time, saying the same words. Then he came to the disciples and said to them, 'Are you still sleeping and taking your rest? Behold, the hour is at hand, and the Son of man is betrayed into the hands of sinners.",
              "Rise, let us be going; see, my betrayer is at hand.'"
            ],
          ),
          MysteryContentModel(
            id: 2,
            imageUrl: "${AppConstant.SORROWFUL_IMG_PATH}2.jpg",
            title: "Second Sorrowful Mystery: The Scourging at the Pillar",
            content: [
              '**Scripture: John 19:1-7**',
              'Then Pilate took Jesus and scourged him.',
              'And the soldiers plaited a crown of thorns, and put it on his head, and arrayed him in a purple robe; they came up to him, saying, “Hail, King of the Jews!” and struck him with their hands.',
              'Pilate went out again, and said to them, “See, I am bringing him out to you, that you may know that I find no crime in him.”',
              'So Jesus came out, wearing the crown of thorns and the purple robe. Pilate said to them, “Behold the man!”',
              'When the chief priests and the officers saw him, they cried out, “Crucify him, crucify him!”',
              'Pilate said to them, “Take him yourselves and crucify him, for I find no crime in him.”',
              'The Jews answered him, “We have a law, and by that law he ought to die, because he has made himself the Son of God.”'
            ],
          ),
          MysteryContentModel(
            id: 3,
            imageUrl: "${AppConstant.SORROWFUL_IMG_PATH}3.jpg",
            title: "Third Sorrowful Mystery: The Crowning with Thorns",
            content: [
              '**Scripture: Matthew 27:27-31**',
              'Then the soldiers of the governor took Jesus into the praetorium, and they gathered the whole battalion before him.',
              'And they stripped him and put a scarlet robe upon him, and plaiting a crown of thorns they put it on his head, and put a reed in his right hand.',
              'And kneeling before him they mocked him, saying, “Hail, King of the Jews!” And they spat upon him, and took the reed and struck him on the head.',
              'And when they had mocked him, they stripped him of the robe, and put his own clothes on him, and led him away to crucify him.'
            ],
          ),
          MysteryContentModel(
            id: 4,
            imageUrl: "${AppConstant.SORROWFUL_IMG_PATH}4.jpg",
            title: "Fourth Sorrowful Mystery: The Carrying of the Cross",
            content: [
              '**Scripture: Matthew 27:31-33**',
              'And when they had mocked him, they stripped him of the robe, and put his own clothes on him, and led him away to crucify him.',
              'As they went out, they came upon a man of Cyrene, Simon by name; this man they compelled to carry his cross.',
              'And when they came to a place called Golgotha (which means the place of a skull), they offered him wine to drink, mingled with gall; but when he tasted it, he would not drink it.'
            ],
          ),
          MysteryContentModel(
            id: 5,
            imageUrl: "${AppConstant.SORROWFUL_IMG_PATH}5.jpg",
            title: "Fifth Sorrowful Mystery: The Crucifixion and Death",
            content: [
              '**Scripture: John 19:18-30**',
              'There they crucified him, and with him two others, one on either side, and Jesus between them. Pilate also wrote a title and put it on the cross; it read, “Jesus of Nazareth, the King of the Jews.” Many of the Jews read this title, for the place where Jesus was crucified was near the city; and it was written in Hebrew, in Latin, and in Greek. The chief priests of the Jews then said to Pilate, “Do not write, ‘The King of the Jews,’ but, ‘This man said, I am King of the Jews.’ ” Pilate answered, “What I have written I have written.”',
              'When the soldiers had crucified Jesus they took his garments and made four parts, one for each soldier; also his tunic. But the tunic was without seam, woven from top to bottom; so they said to one another, “Let us not tear it, but cast lots for it to see whose it shall be.” This was to fulfil the scripture,',
              '“They parted my garments among them, and for my clothing they cast lots.”',
              'So the soldiers did this. But standing by the cross of Jesus were his mother, and his mother’s sister, Mary the wife of Clopas, and Mary Magdalene. When Jesus saw his mother, and the disciple whom he loved standing near, he said to his mother, “Woman, behold, your son!” Then he said to the disciple, “Behold, your mother!” And from that hour the disciple took her to his own home.',
              'After this Jesus, knowing that all was now finished, said (to fulfil the scripture), “I thirst.” A bowl full of vinegar stood there; so they put a sponge full of the vinegar on hyssop and held it to his mouth. When Jesus had received the vinegar, he said, “It is finished”; and he bowed his head and gave up his spirit.'
            ],
          ),
        ]),
    MysteryModel(
        id: 3,
        name: AppConstant.GLORIOUS_MYSTERY,
        days: "",
        img: "",
        mysteryList: [
          MysteryContentModel(
            id: 1,
            imageUrl: "${AppConstant.GLORIOUS_IMG_PATH}1.jpg",
            title: "The First Glorious Mystery: The Resurrection",
            content: [
              '**Scripture: Luke 24:1-12**',
              'But on the first day of the week, at early dawn, they went to the tomb, taking the spices which they had prepared. And they found the stone rolled away from the tomb, but when they went in they did not find the body.',
              'While they were perplexed about this, behold, two men stood by them in dazzling apparel; and as they were frightened and bowed their faces to the ground, the men said to them, “Why do you seek the living among the dead? He is not here, but has risen. Remember how he told you, while he was still in Galilee, that the Son of man must be delivered into the hands of sinful men, and be crucified, and on the third day rise.”',
              'And they remembered his words, and returning from the tomb they told all this to the eleven and to all the rest. Now it was Mary Magdalene and Jo-anna and Mary the mother of James and the other women with them who told this to the apostles; but these words seemed to them an idle tale, and they did not believe them.',
              'But Peter rose and ran to the tomb; stooping and looking in, he saw the linen cloths by themselves; and he went home wondering at what had happened.'
            ],
          ),
          MysteryContentModel(
            id: 2,
            imageUrl: "${AppConstant.GLORIOUS_IMG_PATH}2.jpg",
            title: "The Second Glorious Mystery: The Ascension",
            content: [
              "**Scripture: Acts 1:6-11**",
              'So when they had come together, they asked him, “Lord, will you at this time restore the kingdom to Israel?”',
              'He said to them, “It is not for you to know times or seasons which the Father has fixed by his own authority.',
              'But you shall receive power when the Holy Spirit has come upon you; and you shall be my witnesses in Jerusalem and in all Judea and Samaria and to the end of the earth.”',
              'And when he had said this, as they were looking on, he was lifted up, and a cloud took him out of their sight.',
              'And while they were gazing into heaven as he went, behold, two men stood by them in white robes,',
              'And said, “Men of Galilee, why do you stand looking into heaven? This Jesus, who was taken up from you into heaven, will come in the same way as you saw him go into heaven.”'
            ],
          ),
          MysteryContentModel(
            id: 3,
            imageUrl: "${AppConstant.GLORIOUS_IMG_PATH}3.jpg",
            title: "The Third Glorious Mystery: The Descent of the Holy Spirit",
            content: [
              '**Scripture: Acts 2:1-4**',
              'When the day of Pentecost had come, they were all together in one place.',
              'And suddenly a sound came from heaven like the rush of a mighty wind, and it filled all the house where they were sitting. And there appeared to them tongues as of fire, distributed and resting on each one of them.',
              'And they were all filled with the Holy Spirit and began to speak in other tongues, as the Spirit gave them utterance.'
            ],
          ),
          MysteryContentModel(
            id: 4,
            imageUrl: "${AppConstant.GLORIOUS_IMG_PATH}4.jpg",
            title: "The Fourth Glorious Mystery: The Assumption",
            content: [
              '**Dogma of the Assumption**',
              'For which reason, after we have poured forth prayers of supplication again and again to God, and have invoked the light of the Spirit of Truth, for the glory of Almighty God who has lavished his special affection upon the Virgin Mary, for the honor of her Son, the immortal King of the Ages and the Victor over sin and death, for the increase of the glory of that same august Mother, and for the joy and exultation of the entire Church;',
              'By the authority of our Lord Jesus Christ, of the Blessed Apostles Peter and Paul, and by our own authority, we pronounce, declare, and define it to be a divinely revealed dogma: that the Immaculate Mother of God, the ever Virgin Mary, having completed the course of her earthly life, was assumed body and soul into heavenly glory.',
              '(MUNIFICENTISSIMUS DEUS #44)'
            ],
          ),
          MysteryContentModel(
            id: 5,
            imageUrl: "${AppConstant.GLORIOUS_IMG_PATH}5.jpg",
            title: "The Fifth Glorious Mystery: The Coronation of Mary",
            content: [
              '**Scripture: Revelations 12:1-6**',
              'And a great portent appeared in heaven, a woman clothed with the sun, with the moon under her feet, and on her head a crown of twelve stars; she was with child and she cried out in her pangs of birth, in anguish for delivery.',
              'And another portent appeared in heaven; behold, a great red dragon, with seven heads and ten horns, and seven diadems upon his heads. His tail swept down a third of the stars of heaven, and cast them to the earth. And the dragon stood before the woman who was about to bear a child, that he might devour her child when she brought it forth;',
              'She brought forth a male child, one who is to rule all the nations with a rod of iron, but her child was caught up to God and to his throne, and the woman fled into the wilderness, where she has a place prepared by God, in which to be nourished for one thousand two hundred and sixty days.',
            ],
          ),
        ]),
    MysteryModel(
        id: 1,
        name: AppConstant.LUMINIOUS_MYSTERY,
        days: "",
        img: "",
        mysteryList: [
          MysteryContentModel(
            id: 1,
            imageUrl: "${AppConstant.LUMINOUS_IMG_PATH}1.jpeg",
            title:
                "First Luminous Mystery: The Baptism of Christ in the Jordan",
            content: [
              "**Scripture: Matthew 3:13-17**",
              "Then Jesus came from Galilee to the Jordan to John, to be baptized by him. John would have prevented him, saying, 'I need to be baptized by you, and do you come to me?' But Jesus answered him, 'Let it be so now; for thus it is fitting for us to fulfil all righteousness.' Then he consented.",
              "And when Jesus was baptized, he went up immediately from the water, and behold, the heavens were opened and he saw the Spirit of God descending like a dove, and alighting on him; and lo, a voice from heaven, saying, 'This is my beloved Son, with whom I am well pleased.' (Matthew 3:13-17)"
            ],
          ),
          MysteryContentModel(
            id: 2,
            imageUrl: "${AppConstant.LUMINOUS_IMG_PATH}2.jpg",
            title: "Second Luminous Mystery: The Wedding Feast at Cana",
            content: [
              "**Scripture: John 2:1-11**",
              "On the third day there was a marriage at Cana in Galilee, and the mother of Jesus was there; Jesus also was invited to the marriage, with his disciples. When the wine failed, the mother of Jesus said to him, 'They have no wine.' And Jesus said to her, 'O woman, what have you to do with me? My hour has not yet come.'",
              "His mother said to the servants, 'Do whatever he tells you.' Now six stone jars were standing there, for the Jewish rites of purification, each holding twenty or thirty gallons. Jesus said to them, 'Fill the jars with water.' And they filled them up to the brim. He said to them, 'Now draw some out, and take it to the steward of the feast.' So they took it.",
              "When the steward of the feast tasted the water now become wine, and did not know where it came from (though the servants who had drawn the water knew), the steward of the feast called the bridegroom and said to him, 'Every man serves the good wine first; and when men have drunk freely, then the poor wine; but you have kept the good wine until now.'",
              "This, the first of his signs, Jesus did at Cana in Galilee, and manifested his glory; and his disciples believed in him. (John 2:1-11)"
            ],
          ),
          MysteryContentModel(
            id: 3,
            imageUrl: "${AppConstant.LUMINOUS_IMG_PATH}3.jpg",
            title:
                "Third Luminous Mystery: Jesus’ Proclamation of the Coming of the Kingdom of God",
            content: [
              "**Scripture: Matthew 4:12-17**",
              "Now when he heard that John had been arrested, he withdrew into Galilee; and leaving Nazareth he went and dwelt in Caperna-um by the sea, in the territory of Zebulun and Naphtali, that what was spoken by the prophet Isaiah might be fulfilled:",
              "\"The land of Zebulun and the land of Naphtali,",
              "toward the sea, across the Jordan,",
              "Galilee of the Gentiles—",
              "the people who sat in darkness",
              "have seen a great light,",
              "and for those who sat in the region and shadow of death",
              "light has dawned.\"",
              "From that time Jesus began to preach, saying, 'Repent, for the kingdom of heaven is at hand.' (Matthew 4:12-17)"
            ],
          ),
          MysteryContentModel(
            id: 4,
            imageUrl: "${AppConstant.LUMINOUS_IMG_PATH}4.jpg",
            title: "Fourth Luminous Mystery: The Transfiguration",
            content: [
              "**Scripture: Luke 9:28-36**",
              "Now about eight days after these sayings he took with him Peter and John and James, and went up on the mountain to pray. And as he was praying, the appearance of his countenance was altered, and his raiment became dazzling white.",
              "And behold, two men talked with him, Moses and Elijah, who appeared in glory and spoke of his departure, which he was to accomplish at Jerusalem. Now Peter and those who were with him were heavy with sleep, and when they wakened they saw his glory and the two men who stood with him.",
              "And as the men were parting from him, Peter said to Jesus, 'Master, it is well that we are here; let us make three booths, one for you and one for Moses and one for Elijah'—not knowing what he said. As he said this, a cloud came and overshadowed them; and they were afraid as they entered the cloud.",
              "And a voice came out of the cloud, saying, 'This is my Son, my Chosen; listen to him!' And when the voice had spoken, Jesus was found alone. And they kept silence and told no one in those days anything of what they had seen. (Luke 9:28-36)"
            ],
          ),
          MysteryContentModel(
            id: 5,
            imageUrl: "${AppConstant.LUMINOUS_IMG_PATH}5.jpg",
            title: "Fifth Luminous Mystery: The Institution of the Eucharist",
            content: [
              "**Scripture: Matthew 26:26-30**",
              "Now as they were eating, Jesus took bread, and blessed, and broke it, and gave it to the disciples and said, 'Take, eat; this is my body.' And he took a cup, and when he had given thanks he gave it to them, saying, 'Drink of it, all of you; for this is my blood of the covenant, which is poured out for many for the forgiveness of sins.",
              "I tell you I shall not drink again of this fruit of the vine until that day when I drink it new with you in my Father’s kingdom.'",
              "And when they had sung a hymn, they went out to the Mount of Olives. (Matthew 26:26-30)"
            ],
          )
        ]),
  ];

  int _currentBidFocusId = 0;
  int get currentBidFocusId => _currentBidFocusId;

  int _currentIntroBidFocusId = 0;
  int get currentIntroBidFocusId => _currentIntroBidFocusId;

  String _currentMystery = "";
  String get currentMystery => _currentMystery;

  String _staticMystery = "";
  String get staticMystery => _staticMystery;

  String _currentMysterBanner = "";
  String get currentMysterBanner => _currentMysterBanner;

  late MysteryContentModel _singleMystery;
  MysteryContentModel get singleMystery => _singleMystery;

  int _currentMysteryCounter = 1;
  int get currentMyesteryCounter => _currentMysteryCounter;

  String _currentDecade = "";
  String get currentDecade => _currentDecade;

  bool _isContinueRosary = false;
  bool get isContinueRosary => _isContinueRosary;

  late PrayerModel _currentPrayer;
  PrayerModel get currentPrayer => _currentPrayer;

  String _audioCurrentMystery = "";
  String get audioCurrentMystery => _audioCurrentMystery;

  void setAudioCurrentMystery(String mystery) {
    _audioCurrentMystery = mystery;
    update();
  }

  void setMysteryBanner({String banner = "/images/mary.jpeg"}) {
    _currentMysterBanner = banner;
    update();
  }

  void setIsContinueRosary(bool value) {
    _isContinueRosary = value;
  }

  void setBidFocus(int id) {
    _currentBidFocusId = id;
    setCacheCounter(_currentBidFocusId);
    if (id == 12) {
      //setMysteryCounter(1);
    } else {
      update();
    }
  }

  int formatCounter(int counter) {
    if (counter >= 10) {
      return 10;
    }
    if (counter <= 1) {
      return 1;
    }
    return counter;
  }

  void setIntroBidFocus(int id) {
    _currentIntroBidFocusId = id;
    cacheIntroCounter(_currentIntroBidFocusId);
    update();
  }

  void setPrayer(PrayerModel prayer) {
    _currentPrayer = prayer;
    update();
  }

  void setMysteryCounter(int id) {
    var newVal = _currentMysteryCounter += id;
    if (newVal > 5) {
      return;
    }
    _currentMysteryCounter = newVal;

    cacheMysteryCounter(newVal);
    update();
  }

  void setStoredMysteryCounter(int id) {
    _currentMysteryCounter = id;
  }

  void setMysteryCounterDecrement(int id) {
    var newVal = _currentMysteryCounter -= id;
    if (newVal <= 0) {
      return;
    }
    _currentMysteryCounter = newVal;
    cacheMysteryCounter(newVal);
    update();
  }

  void reset() {
    _currentBidFocusId = 0;
    _currentIntroBidFocusId = 0;

    setStoredMysteryCounter(1);
    mainRepo.clearSharedData();
    //marks the caches as empty for deciding the alert box in the start screen
  }

  void getCurrentMystery() {
    DateTime currentDate = DateTime.now();
    int currentDayOfWeek = currentDate.weekday;

    DaysModel currentDayModel = AppConstant.daysList.firstWhere(
      (dayModel) => dayModel.number == currentDayOfWeek,
      orElse: () => DaysModel(id: 0, name: 'Unknown', number: 0, mystery: ''),
    );

    _currentMystery = currentDayModel.mystery;
    //  cacheMysteryName(_currentMystery);
  }

  void getStaticMystery() {
    DateTime currentDate = DateTime.now();
    int currentDayOfWeek = currentDate.weekday;

    DaysModel currentDayModel = AppConstant.daysList.firstWhere(
      (dayModel) => dayModel.number == currentDayOfWeek,
      orElse: () => DaysModel(id: 0, name: 'Unknown', number: 0, mystery: ''),
    );

    _staticMystery = currentDayModel.mystery;
    //  cacheMysteryName(_currentMystery);
  }

  void setMystery(mystery) async {
    _currentMystery = mystery;
    await cacheMysteryName(mystery);
    update();
  }

  void setDecade() {
    if (_currentMysteryCounter == 1) {
      _currentDecade = "First Decade";
    } else if (_currentMysteryCounter == 2) {
      _currentDecade = "Second Decade";
    } else if (_currentMysteryCounter == 3) {
      _currentDecade = "Third Decade";
    } else if (_currentMysteryCounter == 4) {
      _currentDecade = "Fourth Decade";
    } else if (_currentMysteryCounter == 5) {
      _currentDecade = "Fifth Decade";
    }
  }

  void getSingleMystery(
      {String mysteryType = AppConstant.JOYFUL_MYSTERY, int number = 1}) {
    var type = mainMysteryList.firstWhere((value) => value.name == mysteryType,
        orElse: () =>
            MysteryModel(id: 0, name: "Mystery Not Found", days: "", img: ""));

    _singleMystery = type.mysteryList.firstWhere((value) => value.id == number,
        orElse: () =>
            MysteryContentModel(id: 0, title: '', content: null, imageUrl: ""));
  }

  Future<bool> setCacheCounter(counter) {
    setHasCache("true");
    return mainRepo.setCounter(counter.toString());
  }

  Future<String> getCacheCounter() {
    return mainRepo.getCounter();
  }

  Future<bool> cacheIntroCounter(counter) {
    setHasCache("true");
    return mainRepo.setIntroCounter(counter.toString());
  }

  Future<String> getIntroCounter() {
    return mainRepo.getIntroCounter();
  }

  Future<bool> cacheMysteryCounter(counter) {
    setHasCache("true");
    return mainRepo.setCurrentMystery(counter.toString());
  }

  Future<String> getCacheMysteryCounter() {
    return mainRepo.getCurrentMystery();
  }

  Future<bool> cacheLastScreenName(value) {
    setHasCache("true");
    return mainRepo.setLastScreenName(value.toString());
  }

  Future<String> getLastScreenName() {
    return mainRepo.getLastScreenName();
  }

  Future<bool> cacheMysteryName(value) {
    setHasCache("true");
    return mainRepo.setCurrentMysteryName(value.toString());
  }

  Future<String> getCacheMysteryName() {
    return mainRepo.getCurrentMysteryName();
  }

  Future<bool> setHasCache(boolVal) {
    return mainRepo.setHasCache(boolVal);
  }

  bool getHasCache() {
    return mainRepo.getHasCache();
  }

  String getMysteryImage(String name) {
    if (_currentMystery == AppConstant.GLORIOUS_MYSTERY) {
      return "glorious.webp";
    } else if (_currentMystery == AppConstant.SORROWFUL_MYSTERY) {
      return "sorrow.webp";
    } else if (_currentMystery == AppConstant.LUMINIOUS_MYSTERY) {
      return "luminous.jpeg";
    } else if (_currentMystery == AppConstant.JOYFUL_MYSTERY) {
      return "joyful.webp";
    } else {
      return "glorious.webp";
    }
  }

//This is for people running the old version
  String formatMystery(String name) {
    if (name == AppConstant.GLORIOUS_MYSTERY) {
      return AppConstant.GLORIOUS_MYSTERY;
    } else if (name == AppConstant.SORROWFUL_MYSTERY) {
      return AppConstant.SORROWFUL_MYSTERY;
    } else if (name == AppConstant.LUMINIOUS_MYSTERY) {
      return AppConstant.LUMINIOUS_MYSTERY;
    } else if (name == AppConstant.JOYFUL_MYSTERY) {
      return AppConstant.JOYFUL_MYSTERY;
    } else {
      return AppConstant.JOYFUL_MYSTERY;
    }
  }
}
