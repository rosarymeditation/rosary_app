import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:rosary/model/bid_draw_model.dart';
import 'package:rosary/model/language_model.dart';
import 'package:rosary/model/prayer_model.dart';
import 'package:rosary/utils/show_custom_snackbar.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:vibration/vibration.dart';
import '../controllers/chaplet_template_controller.dart';
import '../controllers/main_controller.dart';
import '../model/days_model.dart';
import '../model/mystery_model.dart';

var _chapletController = Get.find<ChapletController>();

class AppConstant {
  // https://rosary-api.onrender.com/api/

  static const String BASE_URL = "https://softnergy.co.uk/api/";
  //static const String BASE_URL = "http://localhost:8001/api/";
  static const String ALL_FEED_URL = "allFeeds";
  static const String AUDIOS_URL = "audios";
  static const String REGISTRATION_URL = "sign-up";
  static const String LIKE_FEED_URL = "likeFeed";
  static const String LOGIN_URL = "sign-in";
  static const String DELETE_USER_URL = "delete-user";
  static const String GET_PROFILE_DATA = "find-Profile-Data";
  static const String GET_USER_FEEDS = "userFeeds";

  static const String CHAPLET_TEMPLATE_ONE = "template_1";
  static const String CHAPLET_TEMPLATE_TWO = "template_2";
  static const String CHAPLET_TEMPLATE_THREE = "template_3";
  //userFeeds
  static const String COMMENTS_BY_FEED_URL = "CommentsByFeed";
  static const String ALL_PRAYERS_URL = "prayers";
  static const String ASSIST_PRAYER_URL = "assist-prayer";
  //assist-prayer
  static const String ALL_DISTRESS_URL = "distressList";
  static const String ALL_PSALMS_URL = "psalms";
  static const String ALL_NOVENA_PRAYERS_URL = "novenas";
  static const String ALL_CATHOLIC_PRAYERS_URL = "catholic-prayers";
  static const String DEFAULT_PRAYER_IMAGE =
      "https://foodengo2.s3.eu-west-2.amazonaws.com/rosary/9690-man-praising-at-sunrise-sunburst-nature-faith.jpg";
  static DELETE_FEED_URL(String id) => "feed/$id";
  static UPDATE_FEED_URL(String id) => "feed/$id";
  static const String POST_COMMENT_URL = "feedComment";
  static const String ALL_PRAYER_REQUEST_URL = "all-prayer-request";
  static const String SUBMIT_PRAYER_REQUEST_URL = "submit-prayer-request";
  static const String USER_INFO_URL = "userInfo";
  static const String TODAYS_VERSE_URL = "todaysVerse";
  static const String TODAYS_AFFIRMATION_URL = "todaysAffirmation";
  static const String TERMS_URL = "findTerm";
  //todaysVerse
  static const String FORGOT_PASSWORD_URL = "forgot-password";
  static const String PASSWORD_VERIFICATION_URL = "verify-password";
  static const String CHANGE_PASSWORD_URL = "change-password";
  static const String LOG_INSPIRATION_URL = "log-inspiration";
  static const String LOG_NOVENA_URL = "log-novena";
  static const String LOG_PSALM_URL = "log-psalm";
  static const String EXECUTE_PAYPAL_URL = "execute-payment";
  static const String STRIPE_PAYMENT_URL = "stripe-payment";
  //execute-payment
  static const String LOG_ROSARY_URL = "log-rosary";
  static const String LOG_MYSTERY_URL = "log-mystery";
  static const String DEFAULT_LOGO = "assets/icon/icon.png";
  static const String PRAY_LOGO = "assets/images/pray.jpg";
  static const String FEED_COMMENT_DELETE = "feedComment_delete";
  static const String FEED_SAVE = "feed";
  static const String FEED_COMMENT_UPDATE = "feedComment_update";
  static const String UPDATE_USER_PROFILE = "update-user-profile";
  static const String PRAYER_TYPE_OTHERS = "others";
  static const String PRAYER_TYPE_CATHOLIC = "catholic";
  static const String DEFAULT_LOCAL_IMG = "assets/images/mary.jpeg";
  static const String DEFAULT_IMG =
      "https://rosaryapp.s3.eu-west-2.amazonaws.com/default.png";
  static const String DEFAULT_AVATAR = "assets/images/avatar.jpg";
  static const String DEFAULT_AVATAR_ONLINE =
      "https://foodengo2.s3.eu-west-2.amazonaws.com/rosary/avatar.jpg";
  static const String APP_NAME = "app_name";
  static const DEFAULT_BANNER =
      "https://rosaryapp.s3.eu-west-2.amazonaws.com/banner.jpg";
  static const String SIGN_IN = "Sign In";
  static const String SIGN_UP = "Sign Up";
  static const String SCREEN_SLEEP_MUSIC = "sleep_music";
  static const String SCREEN_ROSARY = "rosary";
  static const String SCREEN_SONGS = "songs";
  static const String USER_PROFILE = "Profile";
  static const int START_ROSARY = -2;
  static const int PAGE_LIMIT = 10;
  static const int APOSTLE = -1;
  static const String MAIN_BID = "main_bid";
  static const String NETWORK_TIMEOUT_MESSAGE = "network_timeout_message";
  static const String PRAYER_REQUEST_KEY = "request_key";
  static const String AUDIO_CACHE_KEY = "audi_cache_k";
  static const String INTRO_COUNTER = "intro_counter";
  static const String COUNTER = "counter";
  static const String MYSTERY_COUNTER = "mystery_counter";
  static const String MYSTERY_NAME = "mystery_name";
  static const String HAS_CACHE = "has_cache";
  static const String HAS_VIBRATION = "has_vibration";
  static const String HAS_SEEN_SETTINGS = "has_seen_settings";
  static const String RANDOM_TOKEN = "random_token";
  static const String OTHERS_PRAYER_CACHE = "others_prayer_cache";
  static const String PSALM_CACHE = "psalm_cache";
  static const String NOVENA_PRAYER_CACHE = "novena_prayer_cache";
  static const String CATHOLIC_PRAYER_CACHE = "catholic_prayer_cache";
  static const String DISTRESS_LIST_CACHE = "distress_list_cache";
  static const String DAILY_VERSE_CACHE = "daily_verse_cache";
  static const String AFFIRMATION_CACHE = "affirmation_cache";
  static const String TERMS_CACHE = "terms_cache";
  static const String PASSWORD_LENGTH_MSG =
      "Password length must not be less than 4 characters";
  static const String SORROWFUL_AUDIO_URL = "url_sorrowful_cache";
  static const String FEEDBACK_URL = "feedback";
  static const String PAYMENT_URL = "create-payment";
  static const String CURRENCIES_URL = "currency-list";
  //create-payment
  static const String GLORIOUS_AUDIO_URL = "url_glorious_cache";
  static const String JOYFUL_AUDIO_URL = "url_joyful_cache";
  static const String LUMINOUS_AUDIO_URL = "url_luminous_cache";
  static const String LAST_SCREEN_NAME = "";
  static const String CURRENT_MYSTERY = "current_mystery";
  static const String JOYFUL_IMG_PATH = "assets/joyful/";
  static const String SORROWFUL_IMG_PATH = "assets/sorrowful/";
  static const String LUMINOUS_IMG_PATH = "assets/luminous/";
  static const String GLORIOUS_IMG_PATH = "assets/glorious/";
  static const String END_OR_BEGIN_BID = "end_or_begin_bid";
  static const String TOKEN = "login_token";
  static const String TEMPLATE = "template";
  static const String USER_ID = "user-id";
  static const String JOYFUL_MYSTERY = "joyful_mystery";
  static const String RESPONSE = "Response";
  static const String SORROWFUL_MYSTERY = "sorrowful_mystery";
  static const String GLORIOUS_MYSTERY = "glorious_mystery";
  static const String LUMINIOUS_MYSTERY = "luminous_mystery";
  static const String IMG_PATH = "assets/images/";
  static const String PAYPAL_LINK = "https://www.paypal.me/rosaryMG";
  //https://www.paypal.me/rosaryMG
  static const String COUNTRY_CODE = "country_code";
  static const String LANGUAGE_CODE = "language_code";
  static formatTimeAgo(String time) {
    final now = DateTime.now();
    final difference = now.difference(DateTime.parse(time));

    return timeago.format(now.subtract(difference), locale: 'en');
  }

  static int generate12DigitRandomNumber(Random random) {
    int min = 100000000; // 12-digit minimum
    int max = 999999999; // 12-digit maximum
    return min + random.nextInt(max - min + 1);
  }

  static List<LanguageModel> languages = [
    LanguageModel(
        imageUrl: "us.jpeg",
        languageCode: "en",
        countryCode: "US",
        languageName: "English"),
    LanguageModel(
        imageUrl: "spain.webp",
        languageCode: "es",
        countryCode: "ES",
        languageName: "Español"),
  ];

  static void noNetworkSnackbar() {
    showCustomSnackBar('no_network_content'.tr,
        title: 'no_network_title'.tr, isError: true);
  }

  static String getImagePath(String name) {
    return "assets/images/$name";
  }

  static bool hasUnderscore(text) {
    if (text.startsWith('_')) {
      return true;
    } else {
      return false;
    }
  }

  static String removeFirstUnderscore(String text) {
    if (text.startsWith('_')) {
      return text.replaceFirst('_', '');
    }
    return text;
  }

  static PrayerModel GLORY_BE_TO_FATHER = PrayerModel(
      id: 1, title: 'glory_to_father_title'.tr, content: "glory_to_father".tr);

  static PrayerModel OH_MY_JESUS = PrayerModel(
      id: 1, title: 'oh_my_jesus_title'.tr, content: "oh_my_jesus".tr);

  static PrayerModel APOSTLE_CREED = PrayerModel(
      id: 1, title: 'apostle_creed_title'.tr, content: "apostle_creed".tr);

  static PrayerModel OUR_FATHER = PrayerModel(
      id: 1, title: 'our_father_title'.tr, content: "our_father".tr);

  static PrayerModel HAIL_MARY =
      PrayerModel(id: 1, title: 'hail_mary_title'.tr, content: "hail_mary".tr);

  static PrayerModel FATIMA =
      PrayerModel(id: 1, title: 'fatima_title'.tr, content: "fatima_prayer".tr);

  static PrayerModel HAIL_HOLY_QUEEN = PrayerModel(
      id: 1, title: 'hail_holy_queen_title'.tr, content: "hail_holy_queen".tr);

  static PrayerModel LORETO_LITANY = PrayerModel(
      id: 1, title: 'loreto_litany_title'.tr, content: "loreto_litany".tr);

  static List<DaysModel> daysList = [
    DaysModel(
        id: 1, name: "Monday", number: 1, mystery: AppConstant.JOYFUL_MYSTERY),
    DaysModel(
        id: 2,
        name: "Tuesday",
        number: 2,
        mystery: AppConstant.SORROWFUL_MYSTERY),
    DaysModel(
        id: 3,
        name: "Wednesday",
        number: 3,
        mystery: AppConstant.GLORIOUS_MYSTERY),
    DaysModel(
        id: 4,
        name: "Thursday",
        number: 4,
        mystery: AppConstant.LUMINIOUS_MYSTERY),
    DaysModel(
        id: 5,
        name: "Friday",
        number: 5,
        mystery: AppConstant.SORROWFUL_MYSTERY),
    DaysModel(
        id: 6,
        name: "Saturday",
        number: 6,
        mystery: AppConstant.JOYFUL_MYSTERY),
    DaysModel(
        id: 7, name: "Sunday", number: 7, mystery: AppConstant.GLORIOUS_MYSTERY)
  ];

  static List<String> MYSTERY_TYPES = [
    JOYFUL_MYSTERY,
    SORROWFUL_MYSTERY,
    GLORIOUS_MYSTERY,
    LUMINIOUS_MYSTERY
  ];

  static List<MysteryModel> mysteryDaysList = [
    MysteryModel(
      id: 1,
      name: AppConstant.JOYFUL_MYSTERY,
      days: "joyful_days",
      img: "joyful.webp",
    ),
    MysteryModel(
      id: 2,
      name: AppConstant.SORROWFUL_MYSTERY,
      days: "sorrowful_days",
      img: "sorrow.webp",
    ),
    MysteryModel(
      id: 3,
      name: AppConstant.GLORIOUS_MYSTERY,
      days: "glorious_days",
      img: "glorious.webp",
    ),
    MysteryModel(
      id: 4,
      name: AppConstant.LUMINIOUS_MYSTERY,
      days: "luminous_days",
      img: "luminous.jpeg",
    )
  ];

  static List<BidDrawModel> bidDrawList = [
    BidDrawModel(id: 0, x: 20, y: 20, isRegular: false),
    BidDrawModel(id: 1, x: 20, y: 60),
    BidDrawModel(id: 2, x: 20, y: 100),
    BidDrawModel(id: 3, x: 20, y: 140),
    BidDrawModel(id: 4, x: 40, y: 160),
    BidDrawModel(id: 5, x: 20, y: 200),
    BidDrawModel(id: 6, x: 20, y: 240),
    BidDrawModel(id: 7, x: 20, y: 280),
    BidDrawModel(id: 8, x: 20, y: 320),
  ];
  static const appStoreLink =
      "https://apps.apple.com/us/app/rosary-meditation-guide/id6463201997";
  static const playStoreLink =
      "https://play.google.com/store/apps/details?id=com.rosarysoftnergy.app";
  static const shareConetent =
      " \n 👉 Download for iOS(iphone) $appStoreLink  \n 👉 Download for Android:$playStoreLink";
  static getNoInternetAlet() {
    return Get.rawSnackbar(
        messageText: const Text('Finished download',
            style: TextStyle(color: Colors.white, fontSize: 14)),
        isDismissible: false,
        duration: Duration(seconds: 3),
        backgroundColor: Colors.green[400]!,
        icon: const Icon(
          Icons.check,
          color: Colors.white,
          size: 35,
        ),
        margin: EdgeInsets.zero,
        snackStyle: SnackStyle.GROUNDED);
  }

  static void vibrator() async {
    final _mainController = Get.find<MainController>();
    if (_mainController.getHasVibration() == "false") {
      return;
    }
    bool? hasVibrator = await Vibration.hasVibrator();
    if (hasVibrator!) {
      Vibration.vibrate(duration: 500);
    }
  }

  static Widget getBead(
    int counter,
    int currentBead,
  ) {
    if (currentBead >= 11 || currentBead == 0) {
      return Container();
    }

    if (_chapletController.templateType == AppConstant.CHAPLET_TEMPLATE_TWO) {
      return counter >= currentBead
          ? Image.asset(
              "assets/images/circle_1.png",
              height: 60.r,
              width: 60.r,
              fit: BoxFit.contain,
            )
          : Image.asset(
              "assets/images/circle_2.png",
              height: 60.r,
              width: 60.r,
              fit: BoxFit.contain,
            );
    } else if (_chapletController.templateType ==
        AppConstant.CHAPLET_TEMPLATE_THREE) {
      return counter >= currentBead
          ? Image.asset(
              "assets/images/circle_3.png",
              height: 60.r,
              width: 60.r,
              fit: BoxFit.contain,
            )
          : Image.asset(
              "assets/images/circle_4.png",
              height: 60.r,
              width: 60.r,
              fit: BoxFit.contain,
            );
    } else {
      return Container();
    }
  }
}
