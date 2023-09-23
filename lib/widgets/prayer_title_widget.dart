import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:rosary/route/route_helpers.dart';

import '../controllers/main_controller.dart';
import '../model/prayer_model.dart';
import '../utils/constants.dart';
import 'main_text.dart';

class PrayerTitleWidget extends StatelessWidget {
  PrayerModel prayer;
  String title;
  PrayerTitleWidget({super.key, required this.prayer, required this.title});
  var _mainController = Get.find<MainController>();
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        _mainController.setPrayer(prayer);
        Get.toNamed(RouteHelpers.popUpPrayer);
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: MainText(
              isBold: true,
              text: "$title...",
              size: 20.sp,
            ),
          ),
          const CircleAvatar(
            radius: 15, // Image radius
            backgroundImage: AssetImage(AppConstant.IMG_PATH + "tap.gif"),
          ),
        ],
      ),
    );
  }
}
