import 'dart:async';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:rosary/route/route_helpers.dart';
import 'package:rosary/utils/appColor.dart';
import 'package:rosary/widgets/big_text.dart';
import 'package:rosary/widgets/display_button_widget.dart';

import '../controllers/main_controller.dart';
import '../controllers/prayer_controller.dart';
import '../utils/constants.dart';
import '../widgets/current_mystery_widget.dart';
import '../widgets/main_text.dart';

class StartScreen extends StatefulWidget {
  StartScreen({super.key});

  @override
  State<StartScreen> createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  late int storedBidCounter = 0;
  late String storedScreenName = "";
  var _mainController = Get.find<MainController>();
  var _prayerController = Get.find<PrayerController>();

  bool _isVisible = true;

  void toggleVisibility() {
    setState(() {
      _isVisible = !_isVisible;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer.periodic(Duration(seconds: 1), (timer) {
      toggleVisibility();
    });
    _mainController.getStaticMystery();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MainController>(
      builder: (main) {
        return Scaffold(
          appBar: AppBar(
            title: Text('${AppConstant.APP_NAME.tr}'),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage("assets/images/rosary.jpeg"),
                  ),
                ),
                child: Container(
                  color: Colors.white.withOpacity(.85),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 60.h,
                      ),
                      const CircleAvatar(
                        radius: 50, // Image radius
                        backgroundImage: AssetImage("assets/icon/icon.jpg"),
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      BigText(
                        isBold: true,
                        align: TextAlign.center,
                        text: 'welcome_msg'.tr,
                        size: 18.sp,
                      ),
                      SizedBox(
                        height: 40.h,
                      ),
                      CurrentMysteryWidget(),
                      SizedBox(
                        height: 5.h,
                      ),
                      InkWell(
                        onTap: () {
                          if (_mainController.getHasCache()) {
                            showYesNoAlert();
                          } else {
                            main.setIntroBidFocus(0);
                            Get.toNamed(RouteHelpers.rosaryIntroPage);
                          }
                        },
                        child: DisplayButtonWidget(
                          img: "rosary_icon.jpeg",
                          hasIcon: true,
                          text: "start_rosary",
                        ),
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      InkWell(
                        onTap: () {
                          Get.toNamed(RouteHelpers.mysterySelectionPage);
                        },
                        child: DisplayButtonWidget(
                          text: "choose_mystery",
                          img: main.getMysteryImage(main.currentMystery),
                          hasIcon: true,
                          color: Colors.purple.shade300,
                        ),
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      InkWell(
                        onTap: () {
                          Get.toNamed(RouteHelpers.adioListingPage);
                        },
                        child: DisplayButtonWidget(
                          color: Colors.grey,
                          text: "listen",
                          img: "audio.webp",
                          hasIcon: true,
                        ),
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      InkWell(
                        onTap: () {
                          Get.toNamed(RouteHelpers.prayerRequestPage);
                        },
                        child: DisplayButtonWidget(
                          img: "hands.jpeg",
                          color: Colors.green.shade600,
                          text: "prayer_request",
                          hasIcon: true,
                        ),
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      InkWell(
                        onTap: () {
                          _prayerController
                              .setPrayerType(AppConstant.PRAYER_TYPE_CATHOLIC);
                          Get.toNamed(RouteHelpers.prayersPage);
                        },
                        child: DisplayButtonWidget(
                          img: "catholic.jpg",
                          color: Colors.orange,
                          text: "catholic_prayers".tr,
                          hasIcon: true,
                        ),
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      InkWell(
                        onTap: () {
                          _prayerController
                              .setPrayerType(AppConstant.PRAYER_TYPE_OTHERS);
                          Get.toNamed(RouteHelpers.prayersPage);
                        },
                        child: DisplayButtonWidget(
                          img: "g-prayer.jpg",
                          color: Colors.blue,
                          text: "general_prayers".tr,
                          hasIcon: true,
                        ),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                    ],
                  ),
                ),
              ),
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
