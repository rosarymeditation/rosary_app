import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:rosary/controllers/auth_controller.dart';
import 'package:rosary/route/route_helpers.dart';
import 'package:rosary/widgets/main_text.dart';

class DonationSuccessScreen extends StatelessWidget {
  DonationSuccessScreen({super.key});
  var _authController = Get.find<AuthController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Container(
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
                      backgroundColor: Color.fromARGB(255, 131, 198, 123),
                      child: Icon(Icons.check_circle_rounded,
                          color: Colors.white, size: 40.sp),
                    ),
                  ),
                  endRadius: 50.sp),
            ),
            SizedBox(
              height: 20.h,
            ),
            MainText(
              text: "donate_success_title",
              size: 19.sp,
              isBold: true,
            ),
            Divider(),
            MainText(
              text: "donate_success",
              size: 18.sp,
            ),
            SizedBox(
              height: 20.h,
            ),
            ElevatedButton(
                onPressed: () {
                  Get.offAllNamed(RouteHelpers.home);
                  _authController.setCurrentIndex(0);
                  // _prayerController.getCatholicPrayerList();
                  // _prayerController.getPrayerList();
                },
                child: MainText(
                  text: "return_home",
                  size: 20.sp,
                ))
          ],
        ),
      ),
    );
  }
}
