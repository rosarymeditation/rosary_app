// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
// import 'package:rosary/controllers/auth_controller.dart';
// import 'package:rosary/controllers/main_controller.dart';
// import 'package:rosary/main_screens/feed.dart';
// import 'package:rosary/main_screens/more.dart';
// import 'package:rosary/screens/about.dart';
// import 'package:rosary/main_screens/prayer_list.dart';
// import 'package:rosary/screens/chaplet.dart';
// import 'package:rosary/screens/rosary_intro.dart';
// import 'package:rosary/main_screens/start_screen.dart';
// import 'package:rosary/utils/appColor.dart';

// class TabHomePage extends StatefulWidget {
//   const TabHomePage({Key? key}) : super(key: key);

//   @override
//   State<TabHomePage> createState() => _HomePageState();
// }

// class _HomePageState extends State<TabHomePage> {
//   late PersistentTabController _controller;
//   var _authController = Get.find<AuthController>();
//   int _selectedIndex = 0;
//   List pages = [StartScreen(), FeedScreen(), PrayerScreen(), MoreScreen()];
//   @override
//   void initState() {
//     // Get.find<CategoryController>().getPopularCategory();
//     super.initState();
//   }

//   // void onTapNav(int index) {
//   //   setState(() {
//   //     _authController.setCurrentIndex(index);
//   //   });
//   // }

//   List<Widget> _buildScreens() {
//     return [StartScreen(), FeedScreen(), PrayerScreen(), MoreScreen()];
//   }

//   List<PersistentBottomNavBarItem> _navBarsItems() {
//     return [
//       PersistentBottomNavBarItem(
//         icon: Icon(Icons.home_rounded),
//         title: "home".tr,
//         activeColorPrimary: AppColor.primaryColor,
//         inactiveColorPrimary: AppColor.accentColor,
//       ),
//       PersistentBottomNavBarItem(
//         icon: Icon(Icons.groups_rounded),
//         title: "Community".tr,
//         activeColorPrimary: AppColor.primaryColor,
//         inactiveColorPrimary: AppColor.accentColor,
//       ),
//       PersistentBottomNavBarItem(
//         icon: const Icon(Icons.mediation),
//         title: "prayers".tr,
//         activeColorPrimary: AppColor.primaryColor,
//         inactiveColorPrimary: AppColor.accentColor,
//       ),
//       PersistentBottomNavBarItem(
//         icon: const Icon(Icons.more_horiz_rounded),
//         title: "more".tr,
//         activeColorPrimary: AppColor.primaryColor,
//         inactiveColorPrimary: AppColor.accentColor,
//       ),
//     ];
//   }

//   @override
//   Widget build(BuildContext context) {
//     return GetBuilder<AuthController>(
//       builder: (auth) {
//         _controller =
//             PersistentTabController(initialIndex: _authController.currentIndex);
//         return PersistentTabView(
//           context,
//           controller: _controller,
//           screens: _buildScreens(),
//           items: _navBarsItems(),
//           confineInSafeArea: true,
//           backgroundColor: Colors.white, // Default is Colors.white.
//           handleAndroidBackButtonPress: true, // Default is true.
//           resizeToAvoidBottomInset:
//               true, // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
//           stateManagement: true, // Default is true.
//           hideNavigationBarWhenKeyboardShows:
//               true, // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
//           decoration: NavBarDecoration(
//             borderRadius: BorderRadius.circular(10.0),
//             colorBehindNavBar: Colors.white,
//           ),
//           popAllScreensOnTapOfSelectedTab: true,
//           popActionScreens: PopActionScreensType.all,
//           itemAnimationProperties: const ItemAnimationProperties(
//             // Navigation Bar's items animation properties.
//             duration: Duration(milliseconds: 200),
//             curve: Curves.ease,
//           ),
//           screenTransitionAnimation: const ScreenTransitionAnimation(
//             // Screen transition animation on change of selected tab.
//             animateTabTransition: true,
//             curve: Curves.ease,
//             duration: Duration(milliseconds: 200),
//           ),

//           navBarStyle: NavBarStyle
//               .style6, // Choose the nav bar style with this property.
//         );
//       },
//     );
//   }
// }

import 'dart:io';

import 'package:flutter/material.dart' hide ModalBottomSheetRoute;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:rate_my_app/rate_my_app.dart';
import 'package:rosary/main_screens/daily_reading_screen.dart';
import 'package:rosary/product_screens/market_screen.dart';
import 'package:rosary/songs/song_screen.dart';
import 'controllers/auth_controller.dart';
import 'main_screens/feed.dart';
import 'main_screens/more.dart';
import 'main_screens/prayer_list.dart';
import 'main_screens/start_screen.dart';
import 'utils/appColor.dart';

class TabHomePage extends StatefulWidget {
  const TabHomePage({Key? key}) : super(key: key);

  @override
  State<TabHomePage> createState() => _TabHomePageState();
}

class _TabHomePageState extends State<TabHomePage> {
  var _authController = Get.find<AuthController>();
  int _selectedIndex = 0;
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
                      label: "Daily Reading".tr,
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
                      label: "Daily Reading".tr,
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
