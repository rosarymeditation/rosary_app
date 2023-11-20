import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:rosary/utils/appColor.dart';
import 'package:rosary/widgets/main_text.dart';

import '../controllers/auth_controller.dart';
import '../route/route_helpers.dart';

class DonationErrorScreen extends StatelessWidget {
  DonationErrorScreen({super.key});
  var _authController = Get.find<AuthController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 100.h,
              ),
              Center(
                child: AvatarGlow(
                    animate: true,
                    glowColor: Color.fromARGB(255, 35, 142, 74),
                    // ignore: sort_child_properties_last
                    child: Material(
                      elevation: 10,
                      shape: const CircleBorder(),
                      child: CircleAvatar(
                        radius: 40.sp,
                        backgroundColor: Color.fromARGB(255, 187, 20, 37),
                        child:
                            Icon(Icons.close, color: Colors.white, size: 40.sp),
                      ),
                    ),
                    endRadius: 50.sp),
              ),
              SizedBox(
                height: 20.h,
              ),
              MainText(
                text: "donate_error_title",
                size: 19.sp,
                isBold: true,
              ),
              Divider(),
              MainText(
                text: "donate_error",
                size: 18.sp,
              ),
              SizedBox(
                height: 20.h,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                ),
                onPressed: () {
                  Get.offAllNamed(RouteHelpers.donationPage);
                },
                child: MainText(
                  text: "retry",
                  size: 20.sp,
                  color: Colors.white,
                ),
              ),
              SizedBox(
                height: 40.h,
              ),
              ElevatedButton(
                onPressed: () {
                  Get.offAllNamed(RouteHelpers.home);
                  _authController.setCurrentIndex(0);
                },
                child: MainText(
                  text: "return_home",
                  size: 20.sp,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
