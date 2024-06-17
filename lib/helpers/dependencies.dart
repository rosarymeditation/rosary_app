import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:rosary/controllers/bugFeedback_controller.dart';
import 'package:rosary/controllers/chaplet_template_controller.dart';
import 'package:rosary/controllers/dailyVerse_controller.dart';
import 'package:rosary/controllers/feed_controller.dart';
import 'package:rosary/controllers/langauge_controller.dart';
import 'package:rosary/controllers/network_controller.dart';
import 'package:rosary/controllers/payment_controller.dart';
import 'package:rosary/controllers/prayer_request_controller.dart';
import 'package:rosary/controllers/terms_controller.dart';
import 'package:rosary/data/repository/affirmation_repo.dart';
import 'package:rosary/data/repository/bugFeedback_repo.dart';
import 'package:rosary/data/repository/chaplet_repo.dart';
import 'package:rosary/data/repository/distress_repo.dart';
import 'package:rosary/data/repository/feedComment_repo.dart';
import 'package:rosary/data/repository/feed_repo.dart';
import 'package:rosary/data/repository/payment_repo.dart';
import 'package:rosary/data/repository/prayer_request_repo.dart';
import 'package:rosary/data/repository/terms_repo.dart';
import 'package:rosary/model/language_model.dart';
import 'package:rosary/utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../controllers/affirmation_controller.dart';
import '../controllers/audio_controller.dart';
import '../controllers/auth_controller.dart';
import '../controllers/distress_controller.dart';
import '../controllers/feedComment_controller.dart';
import '../controllers/log_controller.dart';
import '../controllers/main_controller.dart';
import '../controllers/prayer_controller.dart';
import '../controllers/psalm_controller.dart';
import '../controllers/user_controller.dart';
import '../data/api/api_client.dart';
import '../data/repository/audio_repo.dart';
import '../data/repository/auth_repo.dart';
import '../data/repository/dailyVerse_repo.dart';
import '../data/repository/log_repo.dart';
import '../data/repository/main_repo.dart';
import '../data/repository/prayer_repo.dart';
import '../data/repository/psalm_repo.dart';
import '../data/repository/user_repo.dart';

Future<Map<String, Map<String, String>>> init() async {
  final sharePreferences = await SharedPreferences.getInstance();

  Get.lazyPut(() => sharePreferences);
  Get.lazyPut(() => ApiClient(
      appBaseUrl: AppConstant.BASE_URL, sharedPreferences: Get.find()));

  //Repos
  //Get.lazyPut(() => AccountRepo(apiClient: Get.find()));
  // Get.lazyPut(() => PopularProductRepo(apiClient: Get.find()));
  // Get.lazyPut(() => RecommendedProductRepo(apiClient: Get.find()));
  Get.lazyPut(() => LogRepo(apiClient: Get.find()));
  Get.lazyPut(() =>
      AffirmationRepo(apiClient: Get.find(), sharedPreferences: Get.find()));

  Get.lazyPut(
      () => TermsRepo(apiClient: Get.find(), sharedPreferences: Get.find()));
  Get.lazyPut(
      () => PaymentRepo(apiClient: Get.find(), sharedPreferences: Get.find()));
  Get.lazyPut(
      () => DistressRepo(apiClient: Get.find(), sharedPreferences: Get.find()));
  Get.lazyPut(
      () => PsalmRepo(apiClient: Get.find(), sharedPreferences: Get.find()));
  Get.lazyPut(() =>
      DailyVerseRepo(apiClient: Get.find(), sharedPreferences: Get.find()));
  Get.lazyPut(
      () => AuthRepo(apiClient: Get.find(), sharedPreferences: Get.find()));
  Get.lazyPut(() =>
      BugFeedbackRepo(apiClient: Get.find(), sharedPreferences: Get.find()));
  Get.lazyPut(() => UserRepo(apiClient: Get.find()));
  Get.lazyPut(
      () => MainRepo(apiClient: Get.find(), sharedPreferences: Get.find()));
  Get.lazyPut(
      () => FeedRepo(apiClient: Get.find(), sharedPreferences: Get.find()));
  Get.lazyPut(
      () => ChapletRepo(apiClient: Get.find(), sharedPreferences: Get.find()));
  Get.lazyPut(() =>
      PrayerRequestRepo(apiClient: Get.find(), sharedPreferences: Get.find()));
  Get.lazyPut(() =>
      FeedCommentRepo(apiClient: Get.find(), sharedPreferences: Get.find()));
  Get.lazyPut(
      () => PrayerRepo(apiClient: Get.find(), sharedPreferences: Get.find()));
  Get.lazyPut(
      () => AudioRepo(apiClient: Get.find(), sharedPreferences: Get.find()));
  // Get.lazyPut(() => UserRepo(apiClient: Get.find()));
  // Get.lazyPut(() => CourierRepo(apiClient: Get.find()));
  // Get.lazyPut(
  //     () => AuthRepo(apiClient: Get.find(), sharedPreferences: Get.find()));

  //controllers
  // Get.lazyPut(() => PopularProductController(popularProductRepo: Get.find()));
  // Get.lazyPut(
  //     () => RecommendedProductController(recommendedProductRepo: Get.find()));
  Get.lazyPut(() => PsalmController(
        psalmRepo: Get.find(),
      ));
  Get.lazyPut(() => DistressController(
        distressRepo: Get.find(),
      ));
  Get.lazyPut(() => LogController(
        logRepo: Get.find(),
      ));
  Get.lazyPut(() => ChapletController(
        chapletRepo: Get.find(),
      ));
  Get.lazyPut(() => AffirmationController(
      dailyAffirmationRepo: Get.find(), sharedPreferences: Get.find()));
  Get.lazyPut(() => DailyVerseController(
      dailyVerseRepo: Get.find(), sharedPreferences: Get.find()));
  Get.lazyPut(() =>
      FeedController(feedRepo: Get.find(), sharedPreferences: Get.find()));
  Get.lazyPut(() => FeedCommentController(feedCommentRepo: Get.find()));
  Get.lazyPut(() => PrayerController(prayerRepo: Get.find()));
  Get.lazyPut(() => MainController(mainRepo: Get.find()));
  Get.lazyPut(() => PaymentController(
      paymentRepo: Get.find(), sharedPreferences: Get.find()));
  Get.lazyPut(() =>
      TermsController(termsRepo: Get.find(), sharedPreferences: Get.find()));
  Get.lazyPut(() => BugFeedbackController(
      bugFeedbackRepo: Get.find(), sharedPreferences: Get.find()));
  Get.lazyPut(() => PrayerRequestController(prayerRequestRepo: Get.find()));
  Get.lazyPut(() => AudioController(audioRepo: Get.find()));
  Get.lazyPut(() => LocalizationController(sharedPreferences: Get.find()));
  Get.lazyPut(() =>
      UserController(userRepo: Get.find(), sharedPreferences: Get.find()));
  Get.lazyPut(() => AuthController(authRepo: Get.find()));
  Get.lazyPut(() => NetworkController());
  Map<String, Map<String, String>> _languages = Map();
  for (LanguageModel languageModel in AppConstant.languages) {
    String jsonStringValues = await rootBundle
        .loadString('assets/language/${languageModel.languageCode}.json');
    Map<String, dynamic> _mappedJson = json.decode(jsonStringValues);
    Map<String, String> _json = Map();
    _mappedJson.forEach((key, value) {
      print(value);
      print("Mapped json");
      _json[key] = value.toString();
    });
    _languages['${languageModel.languageCode}_${languageModel.countryCode}'] =
        _json;
  }
  return _languages;
}
