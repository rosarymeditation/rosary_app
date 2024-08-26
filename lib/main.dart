import 'dart:io';

import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:rosary/controllers/affirmation_controller.dart';
import 'package:rosary/controllers/chaplet_template_controller.dart';
import 'package:rosary/controllers/dailyVerse_controller.dart';
import 'package:rosary/controllers/distress_controller.dart';
import 'package:rosary/controllers/feed_controller.dart';
import 'package:rosary/controllers/langauge_controller.dart';
import 'package:rosary/controllers/terms_controller.dart';
import 'package:rosary/themes/dark_theme.dart';
import 'package:rosary/themes/light_theme.dart';
import 'package:rosary/utils/constants.dart';
import 'controllers/feedComment_controller.dart';
import 'controllers/log_controller.dart';
import 'controllers/prayer_controller.dart';
import 'controllers/psalm_controller.dart';
import 'helpers/dependencies.dart' as dep;
import 'controllers/main_controller.dart';
import 'route/route_helpers.dart';
import 'utils/messages.dart';

late AudioHandler _audioHandler;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await MobileAds.instance.initialize();

  await JustAudioBackground.init(
    androidNotificationChannelId: "com.ryanheise.bg_demo.channel.audio",
    androidNotificationChannelName: "Rosary Meditation Guide",
    androidNotificationOngoing: true,
  );

  Map<String, Map<String, String>> _languages = await dep.init();

  // await AwesomeNotifications().initialize(null, [
  //   NotificationChannel(
  //     channelKey: 'basic_channel',
  //     channelName: 'Rosary Notifications',
  //     defaultColor: Colors.orange.shade800,
  //     importance: NotificationImportance.High,
  //    // channelShowBadge: true,
  //   ),
  //   NotificationChannel(
  //     channelKey: 'scheduled_channel',
  //     channelName: 'Scheduled Notifications',
  //     defaultColor: Colors.orange.shade800,
  //     locked: true,
  //     importance: NotificationImportance.High,
  //     channelShowBadge: true,
  //     // soundSource: "resource//raw/res_knock"
  //   ),
  // ]);
  runApp(MyApp(
    languages: _languages,
  ));
  // if (Platform.isIOS) {
  //   Firebase.initializeApp();
  // } else {
  //   // await Firebase.initializeApp(
  //   //     options: DefaultFirebaseOptions.currentPlatform);
  // }
}

class MyApp extends StatefulWidget {
  MyApp({required this.languages});
  final Map<String, Map<String, String>> languages;

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    var _termsController = Get.put(
        TermsController(termsRepo: Get.find(), sharedPreferences: Get.find()));
    var _languageController = Get.find<LocalizationController>();
    var _verseController = Get.put(DailyVerseController(
        dailyVerseRepo: Get.find(), sharedPreferences: Get.find()));
    var _affirmationController = Get.put(AffirmationController(
        dailyAffirmationRepo: Get.find(), sharedPreferences: Get.find()));
    var _distressController =
        Get.put(DistressController(distressRepo: Get.find()));
    var _prayerController = Get.put(PrayerController(prayerRepo: Get.find()));
    Get.put(LogController(logRepo: Get.find()));
    var _psalmController = Get.put(PsalmController(psalmRepo: Get.find()));
    Get.put(FeedCommentController(feedCommentRepo: Get.find()));
    Get.put(ChapletController(chapletRepo: Get.find()));
    Get.put(
        FeedController(feedRepo: Get.find(), sharedPreferences: Get.find()));

    final MainController _maincontroller =
        Get.put(MainController(mainRepo: Get.find()));
    _maincontroller.getCurrentMystery();
    _prayerController.getCatholicPrayerList();
    _prayerController.getCatholicPrayerList();
    _prayerController.getNovenaPrayerList();
    _distressController.getDistressList();
    _psalmController.getPsalmList();
    _verseController.getDailyVerse(_languageController.selectedIndex);
    _affirmationController
        .getDailyAffirmation(_languageController.selectedIndex);

    return GetBuilder<LocalizationController>(builder: (localizatonController) {
      return ScreenUtilInit(
        useInheritedMediaQuery: true,
        builder: (context, child) => GestureDetector(
          onTap: () {
            FocusScopeNode currentFocus = FocusScope.of(context);
            if (!currentFocus.hasPrimaryFocus &&
                currentFocus.focusedChild != null) {
              FocusManager.instance.primaryFocus?.unfocus();
            }
          },
          child: GetMaterialApp(
            defaultTransition: Transition.noTransition,
            debugShowCheckedModeBanner: false,
            title: 'Rosary',

            theme: lightTheme,
            darkTheme: darkTheme,

            locale: localizatonController.locale,

            translations: Messages(languages: widget.languages),
            fallbackLocale: Locale(AppConstant.languages[0].languageCode,
                AppConstant.languages[0].countryCode),
            initialRoute: RouteHelpers.initial,
            getPages: RouteHelpers.routes,
            // home: StationPage(),

            // initialRoute: RouteHelpers.endPrayerPage,
            // getPages: RouteHelpers.routes,
          ),
        ),
      );
    });
  }
}
