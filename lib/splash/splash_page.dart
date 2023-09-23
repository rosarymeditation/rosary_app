import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:rosary/route/route_helpers.dart';
import 'package:rosary/utils/constants.dart';
import 'package:rosary/widgets/big_text.dart';

import '../controllers/audio_controller.dart';
import '../controllers/feed_controller.dart';
import '../controllers/main_controller.dart';

class SplashSreen extends StatefulWidget {
  const SplashSreen({Key? key}) : super(key: key);

  @override
  State<SplashSreen> createState() => _SplashSreenState();
}

class _SplashSreenState extends State<SplashSreen>
    with TickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController controller;

  @override
  void initState() {
    super.initState();
    _loadResources();
    controller = new AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..forward();
    animation = CurvedAnimation(
      parent: controller,
      curve: Curves.linear,
    );
    Timer(const Duration(seconds: 4), () {
      Get.offAndToNamed(RouteHelpers.home);
    });
  }

  var _feedController = Get.find<FeedController>();
  var _audioController = Get.find<AudioController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: ScaleTransition(
            scale: animation,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 100.h,
                ),
                BigText(
                  text: AppConstant.APP_NAME.tr,
                  size: 23.sp,
                  isBold: true,
                ),
                SizedBox(
                  height: 20.h,
                ),
                CircleAvatar(
                  radius: 120, // Image radius
                  backgroundImage: AssetImage("assets/icon/icon.jpg"),
                ),
              ],
            )),
      ),
    );
  }

  _loadResources() {
    _feedController.getFeedList();
    _audioController.getVideoList();
  }

  @override
  void dispose() {
    // _userController.hasUserSeenIntro();
    super.dispose();
  }
}
