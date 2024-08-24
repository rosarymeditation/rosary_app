import 'dart:async';
import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:rosary/controllers/langauge_controller.dart';
import 'package:rosary/route/route_helpers.dart';
import 'package:rosary/widgets/dash_simple_widget.dart';
import 'package:rosary/widgets/main_app_bar_widget.dart';
import 'package:rosary/widgets/start_rosary_widget.dart';
import '../controllers/affirmation_controller.dart';
import '../controllers/dailyVerse_controller.dart';
import '../controllers/log_controller.dart';
import '../controllers/main_controller.dart';
import '../controllers/prayer_controller.dart';
import '../songs/play_list.dart';
import '../utils/appColor.dart';
import '../utils/constants.dart';
import '../widgets/dash_audio_widget.dart';
import '../widgets/dash_round_widget.dart';
import '../widgets/inspiration_widget.dart';
import '../widgets/main_text.dart';
import '../widgets/menu_label.dart';

class StartScreen extends StatefulWidget {
  StartScreen({super.key});

  @override
  State<StartScreen> createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  late int storedBidCounter = 0;
  late String storedScreenName = "";
  var _languageController = Get.find<LocalizationController>();
  var _mainController = Get.find<MainController>();
  var _prayerController = Get.find<PrayerController>();
  var _verseController = Get.find<DailyVerseController>();
  var _affirmationController = Get.find<AffirmationController>();
  var _logController = Get.find<LogController>();
  bool _isVisible = true;

  void toggleVisibility() {
    setState(() {
      _isVisible = !_isVisible;
    });
  }

  @override
  void initState() {
    super.initState();

    _mainController.getStaticMystery();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MainController>(
      builder: (main) {
        return Scaffold(
          backgroundColor: Theme.of(context).colorScheme.background,
          appBar: MainAppBarWidget(text: AppConstant.APP_NAME.tr),
          // AppBar(
          //   centerTitle: true,
          //   automaticallyImplyLeading: false,
          //   title: Text('${AppConstant.APP_NAME.tr}'),
          //   backgroundColor: Theme.of(context).colorScheme.secondary,
          // ),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InkWell(
                    onTap: () {
                      if (_mainController.getHasCache()) {
                        showYesNoAlert();
                      } else {
                        main.setIntroBidFocus(0);
                        Get.toNamed(RouteHelpers.rosaryIntroPage);
                      }
                    },
                    child: const StartRosaryWidget()),
                SizedBox(
                  height: 20.h,
                ),
                SizedBox(
                  height: 120.h,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      SizedBox(
                        width: 10.w,
                      ),
                      InkWell(
                        onTap: () {
                          _verseController
                              .getDailyVerse(_languageController.selectedIndex);
                          _affirmationController.getDailyAffirmation(
                              _languageController.selectedIndex);
                          Get.toNamed(RouteHelpers.affirmationPage);
                        },
                        child: InspirationWidget(
                            title: "affirmation_title",
                            subTitle: _affirmationController.hasAffirmation
                                ? _affirmationController
                                    .dailyAffirmationModel.content!
                                : "daily_affirmation",
                            img: "back1.jpg"),
                      ),
                      SizedBox(
                        width: 10.w,
                      ),
                      InkWell(
                        onTap: () {
                          _verseController
                              .getDailyVerse(_languageController.selectedIndex);
                          _affirmationController.getDailyAffirmation(
                              _languageController.selectedIndex);
                          Get.toNamed(RouteHelpers.dailyVersePage);
                        },
                        child: InspirationWidget(
                          title: "daily_verse_title",
                          subTitle: _verseController.hasVerse
                              ? _verseController.dailyVerseModel.content!
                              : "daily_verse",
                          img: "back2.jpeg",
                        ),
                      ),
                      SizedBox(
                        width: 10.w,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                const Divider(),
                InkWell(
                  onTap: () {
                    _logController.logMystery();
                    Get.toNamed(RouteHelpers.mysterySelectionPage);
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    height: 40.h,
                    width: double.maxFinite,
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.secondary,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        MainText(
                          text: "choose_mystery",
                          color: Colors.white,
                          size: 16.sp,
                        ),
                        Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.grey.shade100,
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                DashLabelWidget(
                  title: "prayer_label",
                ),
                SizedBox(
                  height: 20.h,
                ),
                Column(
                  children: [
                    SizedBox(
                      height: 170.h,
                      child: Container(
                        margin: EdgeInsets.only(left: 10),
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: [
                            InkWell(
                              onTap: () {
                                _prayerController.setPrayerType(
                                    AppConstant.PRAYER_TYPE_CATHOLIC);
                                Get.toNamed(RouteHelpers.prayersPage);
                              },
                              child: DashRoundWidget(
                                title: "catholic_prayers",
                                img: "eucharist.jpg",
                              ),
                            ),
                            SizedBox(
                              width: 10.h,
                            ),
                            InkWell(
                              onTap: () {
                                _prayerController.setPrayerType(
                                    AppConstant.PRAYER_TYPE_OTHERS);
                                Get.toNamed(RouteHelpers.prayersPage);
                              },
                              child: DashRoundWidget(
                                title: "general_prayers",
                                img: "g-prayer.jpg",
                              ),
                            ),
                            SizedBox(
                              width: 10.h,
                            ),
                            InkWell(
                              onTap: () {
                                Get.toNamed(RouteHelpers.psalmListPage);
                              },
                              child: DashRoundWidget(
                                title: "powerful_psalms",
                                img: "bible.webp",
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    SizedBox(
                      height: 170.h,
                      child: Container(
                        margin: EdgeInsets.only(left: 10),
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: [
                            InkWell(
                              onTap: () {
                                Get.toNamed(RouteHelpers.novenaListPage);
                              },
                              child: DashRoundWidget(
                                title: "powerful_novena",
                                img: "powerful_prayer.jpeg",
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            InkWell(
                              onTap: () {
                                Get.toNamed(RouteHelpers.wayOfCross);
                              },
                              child: DashRoundWidget(
                                title: "station_cross",
                                img: "0.jpeg",
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            InkWell(
                              onTap: () {
                                Get.toNamed(RouteHelpers.prayerRequestPage);
                              },
                              child: DashRoundWidget(
                                title: "prayer_intention",
                                img: "intention.webp",
                              ),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 30.h,
                ),
                InkWell(
                  onTap: () {
                    Get.toNamed(RouteHelpers.distressPage);
                  },
                  child: SizedBox(
                    height: 150.h,
                    child: DashSimpleWidget(
                        title: "finding_comfort_long".tr,
                        subTitle: "click_here_to_find_comfort".tr),
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                DashLabelWidget(title: "audio_label"),
                SizedBox(
                  height: 10.h,
                ),
                InkWell(
                  onTap: () {
                    Get.toNamed(RouteHelpers.adioListingPage);
                  },
                  child: DashAudioWidget(
                    title: "listen",
                    subTitle: "rosary_subtitle",
                    icon: Icons.play_circle,
                    img: "rosary.png",
                    iconColor: Colors.orange.shade700,
                    num: AudioPlaylist.songsRosary.length,
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                InkWell(
                  onTap: () {
                    Get.toNamed(RouteHelpers.songsPage);
                  },
                  child: DashAudioWidget(
                    title: "songs",
                    subTitle: "song_subtitle",
                    icon: Icons.play_circle,
                    img: "play.png",
                    iconColor: Colors.orange.shade700,
                    num: AudioPlaylist.audioSource.length,
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                InkWell(
                  onTap: () {
                    _prayerController
                        .setPrayerType(AppConstant.PRAYER_TYPE_OTHERS);
                    Get.toNamed(RouteHelpers.deepSleepPage);
                  },
                  child: DashAudioWidget(
                    title: "deep_sleep_music",
                    subTitle: "sleep_subtitle",
                    icon: Icons.bedtime_rounded,
                    img: "sleeping.png",
                    iconColor: Colors.blue.shade700,
                    num: AudioPlaylist.deepSleepSource.length,
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                DashLabelWidget(title: "prayer_request".tr),
                SizedBox(
                  height: 10.h,
                ),
                InkWell(
                  onTap: () {
                    Get.toNamed(RouteHelpers.publicPrayerRequestPage);
                  },
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 20.w),
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    width: double.maxFinite,
                    height: 80.h,
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.tertiary,
                      borderRadius: BorderRadius.circular(10.sp),
                    ),
                    child: Row(
                      children: [
                        CircleAvatar(
                          backgroundImage: AssetImage(
                              AppConstant.getImagePath("prayer_request.png")),
                        ),
                        SizedBox(
                          width: 10.w,
                        ),
                        Flexible(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              MainText(
                                text: "ask_for_prayers".tr,
                                size: 16.sp,
                                isBold: true,
                                color: AppColor.title,
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Flexible(
                                child: MainText(
                                  align: TextAlign.left,
                                  overflow: TextOverflow.ellipsis,
                                  text: "ask_for_prayers_subtitle".tr,
                                  size: 12.sp,
                                  color: AppColor.subTitle,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 20.h,
                )
              ],
            ),
          ),
        );
      },
    );
  }

  void showYesNoAlert() {
    if (_mainController.getHasCache()) {
      AwesomeDialog(
        context: context,
        keyboardAware: true,
        dismissOnBackKeyPress: false,
        dialogType: DialogType.info,
        animType: AnimType.bottomSlide,
        btnCancelText: "no".tr,
        btnOkText: "yes".tr,
        title: "confirmation".tr,
        // padding: const EdgeInsets.all(5.0),
        desc: "rosary_continue".tr,
        btnCancelOnPress: () {
          _mainController.setIntroBidFocus(0);
          Get.toNamed(RouteHelpers.rosaryIntroPage);

          _mainController.reset();
        },
        btnOkOnPress: () {
          Get.back(); // Close the dialog
          //     // Add your code for the "Yes" action here

          loadCache();
        },
      ).show();
      // Get.defaultDialog(
      //   title: "confirmation".tr,
      //   middleText: "rosary_continue".tr,
      //   textConfirm: "yes".tr,
      //   textCancel: "no".tr,
      //   confirmTextColor: Colors.white,
      //   buttonColor: Colors.blue,
      //   onCancel: () {
      //     //Get.back();
      //     _mainController.setIntroBidFocus(0);
      //     Get.toNamed(RouteHelpers.rosaryIntroPage);
      //     // Handle "No" action
      //     // Close the dialog
      //     _mainController.reset();
      //   },
      //   onConfirm: () {
      //     // Handle "Yes" action
      //     Get.back(); // Close the dialog
      //     // Add your code for the "Yes" action here

      //     loadCache();
      //   },
      // );
    }
  }

  void loadCache() async {
    var mysteryCounter = await _mainController.getCacheMysteryCounter();
    var counter = int.parse(mysteryCounter);

    if (counter <= 0) {
      counter = 1;
    }

    _mainController.setStoredMysteryCounter(counter);
    print("Mystery counter--" + counter.toString());

    var bidCounter = await _mainController.getCacheCounter();
    var counter2 = int.parse(bidCounter);
    _mainController.setBidFocus(counter2);

    var introBidCounter = await _mainController.getIntroCounter();
    var counter3 = int.parse(introBidCounter);
    _mainController.setIntroBidFocus(counter3);

    var mysteryName = await _mainController.getCacheMysteryName();

    if (mysteryName == "") {
      _mainController.getCurrentMystery();
    } else {
      _mainController.setMystery(mysteryName);
    }

    var lastRouter = await _mainController.getLastScreenName();
    if (lastRouter == "" || lastRouter == "/") {
      _mainController.reset();
      Get.toNamed(RouteHelpers.home);
    } else {
      Get.toNamed(lastRouter);
    }
  }
}
