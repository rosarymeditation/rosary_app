import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:rosary/controllers/auth_controller.dart';
import 'package:rosary/route/route_helpers.dart';
import 'package:rosary/utils/appColor.dart';
import 'package:rosary/utils/constants.dart';
import 'package:rosary/utils/dimensions.dart';
import 'package:rosary/widgets/main_text.dart';

class NoNetworkScreen extends StatelessWidget {
  String routeName;
  NoNetworkScreen({super.key, this.routeName = RouteHelpers.home});
  var _authController = Get.find<AuthController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Stack(children: [
        Positioned(
          top: 40.h,
          left: 0,
          right: 0,
          child: Container(
            height: Dimensions.screenHeight * 0.4,
            width: double.maxFinite,
            child: ClipOval(
              child: Image.asset(
                AppConstant.getImagePath("no_network.png"),
                width: 80.sp,
                height: 80.sp,
                fit: BoxFit.contain,
              ),
            ),
          ),
        ),
        Positioned(
          top: 350.h,
          left: 0,
          right: 0,
          child: Container(
              height: Dimensions.screenHeight * 0.4,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.secondary,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40.sp),
                  topRight: Radius.circular(40.sp),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 20.h,
                    ),
                    MainText(
                      text: "No Internet Connection",
                      color: Colors.white,
                      size: 18.sp,
                      isBold: true,
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    MainText(
                      text:
                          "You are not connected to internet, make sure wifi or mobile data is on, Airplane Mode is off and try again",
                      color: Colors.white,
                      isBold: true,
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        _authController.setCurrentIndex(1);
                        Get.toNamed(routeName);
                      },
                      child: MainText(
                        text: "Try again",
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                    ),
                    // SizedBox(
                    //   height: 20.h,
                    // ),
                    // ElevatedButton(
                    //   onPressed: () {
                    //     _authController.setCurrentIndex(0);
                    //     Get.toNamed(RouteHelpers.home);
                    //   },
                    //   child: MainText(
                    //     text: "Home",
                    //     color: AppColor.primaryColor,
                    //   ),
                    // )
                  ],
                ),
              )),
        )
      ]),
    );
  }
}
