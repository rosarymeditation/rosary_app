
import 'dart:io';

import 'package:flutter/material.dart' hide ModalBottomSheetRoute;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:rate_my_app/rate_my_app.dart';
import 'package:rosary/main_screens/daily_reading_screen.dart';
import 'controllers/auth_controller.dart';
import 'main_screens/feed.dart';
import 'main_screens/more.dart';
import 'main_screens/start_screen.dart';
import 'utils/appColor.dart';

class TabHomePage extends StatefulWidget {
  const TabHomePage({Key? key}) : super(key: key);

  @override
  State<TabHomePage> createState() => _TabHomePageState();
}

class _TabHomePageState extends State<TabHomePage> {
  var _authController = Get.find<AuthController>();
  
  final RateMyApp rateMyApp = RateMyApp(
    minDays: 1,
    minLaunches: 3,
    remindLaunches: 2,
    remindDays: 20,
    appStoreIdentifier: '6463201997',
    googlePlayIdentifier: 'com.rosarysoftnergy.app',
  );
  List pages = Platform.isIOS
      ? [
          StartScreen(),
          //FeedScreen(),
          // const MarketplaceScreen(),
          DailyReadingScreen(),
          MoreScreen()
        ]
      : [
          StartScreen(),
          DailyReadingScreen(),
          FeedScreen(),

          // const MarketplaceScreen(),
          MoreScreen()
        ];
  @override
  void initState() {
    super.initState();
    // _controller = PersistentTabController(initialIndex: 0);
  }

  void onTapNav(int index) {
    _authController.setCurrentIndex(index);
  }

  @override
  Widget build(BuildContext context) {
    _rateMe();
    return GetBuilder<AuthController>(
      builder: (auth) {
        return Scaffold(
          body: pages[auth.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            selectedItemColor: AppColor.primaryColor,
            unselectedItemColor: AppColor.title,
            showUnselectedLabels: true,
            showSelectedLabels: true,
            selectedFontSize: 14.sp,
            unselectedFontSize: 12.sp,
            currentIndex: auth.currentIndex,
            onTap: onTapNav,
            items: Platform.isIOS
                ? <BottomNavigationBarItem>[
                    BottomNavigationBarItem(
                      icon: Icon(
                        Icons.home,
                        size: 20.sp,
                      ),
                      label: "home".tr,
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(
                        Icons.calendar_today_sharp,
                        size: 20.sp,
                      ),
                      label: "daily_reading".tr,
                    ),
                    // BottomNavigationBarItem(
                    //   icon: Icon(
                    //     Icons.groups_3,
                    //     size: 20.sp,
                    //   ),
                    //   label: "community".tr,
                    // ),

                    BottomNavigationBarItem(
                      icon: Icon(
                        Icons.view_headline_sharp,
                        size: 20.sp,
                      ),
                      label: "more".tr,
                    ),
                  ]
                : <BottomNavigationBarItem>[
                    BottomNavigationBarItem(
                      icon: Icon(
                        Icons.home,
                        size: 20.sp,
                      ),
                      label: "home".tr,
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(
                        Icons.calendar_today_sharp,
                        size: 20.sp,
                      ),
                      label: "daily_reading".tr,
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(
                        Icons.groups_3,
                        size: 20.sp,
                      ),
                      label: "community".tr,
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(
                        Icons.view_headline_sharp,
                        size: 20.sp,
                      ),
                      label: "more".tr,
                    ),
                  ],
          ),
        );
      },
    );
  }

  _rateMe() {
    Future.delayed(Duration(microseconds: 10000), () {
      rateMyApp.init().then((_) {
        if (rateMyApp.shouldOpenDialog) {
          rateMyApp.showStarRateDialog(
            context,
            title: 'Rate this app',
            message:
                'If you like this app, please take a little bit of your time to review it! \n it really helps us and it should not take you more than a minute',
            actionsBuilder: (context, stars) {
              return [
                TextButton(
                    onPressed: () async {
                      stars = stars ?? 0;
                      if (stars! < 4) {
                      } else {
                        Navigator.pop<RateMyAppDialogButton>(
                            context, RateMyAppDialogButton.rate);
                        await rateMyApp
                            .callEvent(RateMyAppEventType.rateButtonPressed);
                        // if (await rateMyApp.isNativeReviewDialogSupported ??
                        //     false) {
                        //   await rateMyApp.launchNativeReviewDialog();
                        // }
                        rateMyApp.launchStore();
                      }
                    },
                    child: const Text('OK'))
              ];
            },
            dialogStyle: const DialogStyle(
              titleAlign: TextAlign.center,
              messageAlign: TextAlign.center,
              messagePadding: EdgeInsets.only(bottom: 20),
            ),
            starRatingOptions: const StarRatingOptions(),
            onDismissed: () => rateMyApp.callEvent(
              RateMyAppEventType.laterButtonPressed,
            ),
          );
        }
      });
    });
  }
}
