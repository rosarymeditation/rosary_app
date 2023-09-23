import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../controllers/main_controller.dart';
import '../utils/appColor.dart';

class CurrentMysteryWidget extends StatelessWidget {
  CurrentMysteryWidget({super.key});
  var _mainController = Get.find<MainController>();
  @override
  Widget build(BuildContext context) {
    return GetBuilder<MainController>(
      builder: (main) {
        return RichText(
          text: TextSpan(
            text: "todays_mystery".tr + " :",
            style: TextStyle(
                color: Colors.black87,
                fontWeight: FontWeight.bold,
                fontFamily: 'Playfair',
                fontSize: 18.sp),
            children: [
              TextSpan(
                text: _mainController.staticMystery.tr,
                style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w500,
                    color: AppColor.primaryColor),
              ),
            ],
          ),
        );
      },
    );
  }
}
