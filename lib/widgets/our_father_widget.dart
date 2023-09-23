import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../controllers/main_controller.dart';
import '../route/route_helpers.dart';
import '../utils/constants.dart';
import 'main_text.dart';

class OurFatherWidget extends StatelessWidget {
  OurFatherWidget({super.key});
  var ourFatherPrayer = AppConstant.OUR_FATHER;
  var _mainController = Get.find<MainController>();
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        _mainController.setPrayer(ourFatherPrayer);
        Get.toNamed(RouteHelpers.popUpPrayer);
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          MainText(
            isBold: true,
            text: "our_father_title".tr,
            size: 20.sp,
          ),
          const CircleAvatar(
            radius: 15, // Image radius
            backgroundImage: AssetImage(AppConstant.IMG_PATH + "tap.gif"),
          )
        ],
      ),
    );
  }
}
