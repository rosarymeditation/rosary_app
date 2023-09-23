import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../controllers/main_controller.dart';
import '../route/route_helpers.dart';
import '../utils/constants.dart';
import 'main_text.dart';

class GloryWidget extends StatelessWidget {
  GloryWidget({super.key});
  var gloryPrayer = AppConstant.GLORY_BE_TO_FATHER;
  var _mainController = Get.find<MainController>();
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        _mainController.setPrayer(gloryPrayer);
        Get.toNamed(RouteHelpers.popUpPrayer);
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          MainText(
            text: 'glory_to_father_title'.tr,
            size: 16.sp,
            isBold: true,
          ),
          SizedBox(
            width: 5.w,
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
