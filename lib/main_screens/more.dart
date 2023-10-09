import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:launch_review/launch_review.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:rosary/controllers/auth_controller.dart';
import 'package:rosary/route/route_helpers.dart';
import 'package:rosary/utils/appColor.dart';
import 'package:rosary/widgets/account_widget.dart';
import 'package:rosary/widgets/big_text.dart';
import 'package:share/share.dart';

import '../controllers/main_controller.dart';
import '../utils/constants.dart';
import '../widgets/main_text.dart';

class MoreScreen extends StatefulWidget {
  MoreScreen({super.key});

  @override
  State<MoreScreen> createState() => _MoreScreenState();
}

class _MoreScreenState extends State<MoreScreen> {
  late int storedBidCounter = 0;
  late String storedScreenName = "";
  var _authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthController>(
      builder: (auth) {
        return Scaffold(
          appBar: AppBar(
            title: Text('${AppConstant.APP_NAME.tr}'),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                children: [
                  SizedBox(
                    height: 30.h,
                  ),
                  InkWell(
                    onTap: () {
                      _shareContent();
                    },
                    child: AccountWidget(
                        iconBackgroundColor: Colors.blue,
                        hasArrow: false,
                        leftIcon: Icons.share,
                        text: "share"),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  InkWell(
                    onTap: () {
                      LaunchReview.launch(
                        androidAppId: "com.rosarysoftnergy.app",
                        iOSAppId: "6463201997",
                      );
                    },
                    child: AccountWidget(
                      iconBackgroundColor: Colors.green,
                      hasArrow: false,
                      leftIcon: Icons.reviews_rounded,
                      text: "rate_us",
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  InkWell(
                    onTap: () {
                      Get.toNamed(RouteHelpers.languagePage);
                    },
                    child: AccountWidget(
                        iconBackgroundColor: Colors.grey,
                        hasArrow: true,
                        leftIcon: Icons.language_rounded,
                        text: "language"),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  InkWell(
                    onTap: () {
                      Get.toNamed(RouteHelpers.rosaryBenefitPage);
                    },
                    child: AccountWidget(
                        iconBackgroundColor: Colors.purple,
                        hasArrow: true,
                        leftIcon: Icons.check_circle,
                        text: "rosary_benefits_title"),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  InkWell(
                    onTap: () {
                      Get.toNamed(RouteHelpers.aboutPage);
                    },
                    child: AccountWidget(
                        iconBackgroundColor: Colors.blue,
                        hasArrow: true,
                        leftIcon: Icons.info_rounded,
                        text: "about"),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  auth.userLoggedIn()
                      ? InkWell(
                          onTap: () {
                            Get.toNamed(RouteHelpers.settingsPage);
                          },
                          child: AccountWidget(
                            iconBackgroundColor: Colors.green,
                            hasArrow: true,
                            leftIcon: Icons.account_box,
                            text: "personal_settings",
                          ),
                        )
                      : InkWell(
                          onTap: () {
                            Get.toNamed(RouteHelpers.signUpPage);
                          },
                          child: AccountWidget(
                              iconBackgroundColor: Colors.green,
                              hasArrow: true,
                              leftIcon: Icons.groups,
                              text: "join_community"),
                        ),
                  SizedBox(
                    height: 20.h,
                  ),
                  InkWell(
                    onTap: () {
                      Get.toNamed(RouteHelpers.bugFeedbackPage);
                    },
                    child: AccountWidget(
                      iconBackgroundColor: Colors.orange.shade600,
                      hasArrow: true,
                      leftIcon: Icons.bug_report_rounded,
                      text: "bug_report",
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  InkWell(
                    onTap: () {
                      Get.toNamed(RouteHelpers.privacyPage);
                    },
                    child: AccountWidget(
                      iconBackgroundColor: Colors.grey.shade600,
                      hasArrow: true,
                      leftIcon: Icons.privacy_tip,
                      text: "privacy_policy".tr,
                    ),
                  ),
                  SizedBox(
                    height: 60.h,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void _shareContent() {
    Share.share("share_content".tr + AppConstant.shareConetent,
        subject: "Rosary Prayer");
    // You can also specify a subject for the shared content:
    // Share.share('Check out this amazing content!', subject: 'Sharing Content');
  }
}
