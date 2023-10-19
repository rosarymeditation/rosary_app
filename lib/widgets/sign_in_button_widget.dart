import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../route/route_helpers.dart';
import '../utils/appColor.dart';
import 'main_text.dart';

class SignInButtonWidget extends StatelessWidget {
  const SignInButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.symmetric(vertical: 10.w),
            backgroundColor: AppColor.primaryColor,
          ),
          onPressed: () {
            Get.toNamed(RouteHelpers.signInPage);
          },
          child: MainText(
            color: Colors.white,
            text: "sign_in",
            size: 20.sp,
          )),
    );
  }
}
