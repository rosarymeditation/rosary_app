import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../controllers/main_controller.dart';
import 'big_text.dart';

class BeadNumberCounterWidget extends StatelessWidget {
  int counter;
  BeadNumberCounterWidget({super.key, required this.counter});
  var _mainController = Get.find<MainController>();
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        BigText(
          text: "bead_number".tr,
          size: 18.sp,
          isBold: true,
        ),
        const SizedBox(
          width: 2,
        ),
        BigText(
          text: _mainController.formatCounter(counter).toString(),
          size: 18.sp,
          isBold: true,
        )
      ],
    );
  }
}
