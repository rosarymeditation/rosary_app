import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rosary/model/bid_draw_model.dart';
import 'package:rosary/model/language_model.dart';
import 'package:rosary/model/prayer_model.dart';
import 'package:rosary/utils/show_custom_snackbar.dart';
import 'package:timeago/timeago.dart' as timeago;
import '../model/days_model.dart';
import '../model/mystery_model.dart';

class AppConstant {
  //https://rosary-api.onrender.com/api/
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
  //userFeeds
  static const String COMMENTS_BY_FEED_URL = "CommentsByFeed";
  static const String ALL_PRAYERS_URL = "prayers";
  static const String ALL_CATHOLIC_PRAYERS_URL = "catholic-prayers";
  static const String DEFAULT_PRAYER_IMAGE =
      "https://foodengo2.s3.eu-west-2.amazonaws.com/rosary/9690-man-praising-at-sunrise-sunburst-nature-faith.jpg";
  static DELETE_FEED_URL(String id) => "feed/$id";
  static UPDATE_FEED_URL(String id) => "feed/$id";
  static const String POST_COMMENT_URL = "feedComment";
  static const String USER_INFO_URL = "userInfo";
  static const String FORGOT_PASSWORD_URL = "forgot-password";
  static const String PASSWORD_VERIFICATION_URL = "verify-password";
  static const String CHANGE_PASSWORD_URL = "change-password";
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
  static const String USER_PROFILE = "Profile";
  static const int START_ROSARY = -2;
  static const int PAGE_LIMIT = 10;
  static const int APOSTLE = -1;
  static const String MAIN_BID = "main_bid";
  static const String NETWORK_TIMEOUT_MESSAGE = "network_timeout_message";
  static const String PRAYER_REQUEST_KEY = "request_key";
  static const String INTRO_COUNTER = "intro_counter";
  static const String COUNTER = "counter";
  static const String MYSTERY_COUNTER = "mystery_counter";
  static const String MYSTERY_NAME = "mystery_name";
  static const String HAS_CACHE = "has_cache";
  static const String OTHERS_PRAYER_CACHE = "others_prayer_cache";
  static const String CATHOLIC_PRAYER_CACHE = "catholic_prayer_cache";
  static const String PASSWORD_LENGTH_MSG =
      "Password length must not be less than 4 characters";
  static const String SORROWFUL_AUDIO_URL = "url_sorrowful_cache";
  static const String FEEDBACK_URL = "feedback";
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
  static const String USER_ID = "user-id";
  static const String JOYFUL_MYSTERY = "joyful_mystery";
  static const String RESPONSE = "Response";
  static const String SORROWFUL_MYSTERY = "sorrowful_mystery";
  static const String GLORIOUS_MYSTERY = "glorious_mystery";
  static const String LUMINIOUS_MYSTERY = "luminous_mystery";
  static const String IMG_PATH = "assets/images/";
  static const String COUNTRY_CODE = "country_code";
  static const String LANGUAGE_CODE = "language_code";
  static formatTimeAgo(String time) {
    final now = DateTime.now();
    final difference = now.difference(DateTime.parse(time));

    return timeago.format(now.subtract(difference), locale: 'en');
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
}
