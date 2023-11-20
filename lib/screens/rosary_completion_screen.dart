import 'dart:async';

import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:launch_review/launch_review.dart';
import 'package:rosary/utils/appColor.dart';
import 'package:rosary/utils/constants.dart';
import 'package:rosary/widgets/main_text.dart';
import 'package:share/share.dart';

import '../route/route_helpers.dart';
import '../widgets/big_text.dart';

class RosaryCompletionScreen extends StatefulWidget {
  const RosaryCompletionScreen({super.key});

  @override
  State<RosaryCompletionScreen> createState() => _RosaryCompletionScreenState();
}

class _RosaryCompletionScreenState extends State<RosaryCompletionScreen> {
  bool isPlaying = false;

  final controller = ConfettiController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.play();
    Timer(Duration(seconds: 5), () => controller.stop());
  }

  @override
  void dispose() {
    controller.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Scaffold(
          backgroundColor: Theme.of(context).colorScheme.background,
          body: SafeArea(
            child: SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 15.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 100.h,
                    ),
                    CircleAvatar(
                      radius: 50.sp,
                      backgroundImage:
                          AssetImage(AppConstant.getImagePath("pray.jpg")),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Center(
                      child: MainText(
                        text: "congratulation".tr,
                        size: 25.sp,
                        color: Colors.green.shade800,
                        isBold: true,
                      ),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Center(
                      child: BigText(
                        align: TextAlign.center,
                        text: "congratulation_msg".tr,
                        color: Colors.black,
                        size: 18.sp,
                      ),
                    ),

                    SizedBox(
                      height: 15.h,
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue.shade600,
                      ),
                      onPressed: () {
                        _shareContent();
                      },
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.w),
                        child: MainText(
                          text: "share".tr,
                          color: Colors.white,
                          size: 18.sp,
                          isBold: true,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15.h,
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green.shade600,
                      ),
                      onPressed: () {
                        LaunchReview.launch(
                          androidAppId: "com.rosarysoftnergy.app",
                          iOSAppId: "6463201997",
                        );
                      },
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.w),
                        child: MainText(
                          text: "rate_us".tr,
                          color: Colors.white,
                          size: 18.sp,
                          isBold: true,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColor.primaryColor,
                      ),
                      onPressed: () {
                        Get.offNamed(RouteHelpers.home);
                      },
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.w),
                        child: MainText(
                          text: "finish".tr,
                          color: Colors.white,
                          size: 18.sp,
                          isBold: true,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    // ElevatedButton(
                    //   onPressed: () {},
                    //   child: Padding(
                    //     padding: EdgeInsets.symmetric(horizontal: 20.w),
                    //     child: MainText(
                    //       text: "Finish",
                    //       size: 18.sp,
                    //       isBold: true,
                    //     ),
                    //   ),
                    // )
                  ],
                ),
              ),
            ),
          ),
        ),
        ConfettiWidget(
          confettiController: controller,
          shouldLoop: false,
          blastDirectionality: BlastDirectionality.explosive,
          emissionFrequency: 0.00,
          numberOfParticles: 200,
          minBlastForce: 20,
          maxBlastForce: 100,
          gravity: 0.1,
        )
      ],
    );
  }

  void _shareContent() {
    Share.share("share_content".tr + AppConstant.shareConetent,
        subject: AppConstant.APP_NAME.tr);
    // You can also specify a subject for the shared content:
    // Share.share('Check out this amazing content!', subject: 'Sharing Content');
  }
}
