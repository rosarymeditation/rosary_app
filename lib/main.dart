import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:rosary/controllers/feed_controller.dart';
import 'package:rosary/controllers/langauge_controller.dart';
import 'package:rosary/utils/constants.dart';
import 'controllers/feedComment_controller.dart';
import 'controllers/prayer_controller.dart';
import 'helpers/dependencies.dart' as dep;
import 'controllers/main_controller.dart';
import 'route/route_helpers.dart';
import 'utils/appColor.dart';
import 'utils/messages.dart';

late AudioHandler _audioHandler;
Future<void> main() async {
  await JustAudioBackground.init(
    androidNotificationChannelId: "com.ryanheise.bg_demo.channel.audio",
    androidNotificationChannelName: "Rosary Meditation Guide",
    androidNotificationOngoing: true,
  );

  WidgetsFlutterBinding.ensureInitialized();

  Map<String, Map<String, String>> _languages = await dep.init();
  runApp(MyApp(
    languages: _languages,
  ));
}

class MyApp extends StatelessWidget {
  MyApp({required this.languages});
  final Map<String, Map<String, String>> languages;
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Get.put(PrayerController(prayerRepo: Get.find()));
    Get.put(FeedCommentController(feedCommentRepo: Get.find()));
    Get.put(
        FeedController(feedRepo: Get.find(), sharedPreferences: Get.find()));
    Get.put(
        FeedController(feedRepo: Get.find(), sharedPreferences: Get.find()));
    final MainController _maincontroller =
        Get.put(MainController(mainRepo: Get.find()));
    _maincontroller.getCurrentMystery();
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
            theme: ThemeData(
              colorScheme:
                  ColorScheme.fromSeed(seedColor: AppColor.primaryColor),
              useMaterial3: true,
            ),
            locale: localizatonController.locale,

            translations: Messages(languages: languages),
            fallbackLocale: Locale(AppConstant.languages[0].languageCode,
                AppConstant.languages[0].countryCode),
            initialRoute: RouteHelpers.initial,
            getPages: RouteHelpers.routes,
            //home: AudioPlayerScreen(),
            //home: SignUpPage(),
            // initialRoute: RouteHelpers.endPrayerPage,
            // getPages: RouteHelpers.routes,
          ),
        ),
      );
    });
  }
}
