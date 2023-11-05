import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../controllers/main_controller.dart';
import '../route/route_helpers.dart';
import '../utils/appColor.dart';
import 'big_text.dart';

class RosaryAppBarWidget extends StatelessWidget
    implements PreferredSizeWidget {
  final String text;

  RosaryAppBarWidget({super.key, required this.text});
  var _mainController = Get.find<MainController>();
  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      leading: InkWell(
        onTap: () {
          Get.offAndToNamed(RouteHelpers.home);
        },
        child: Icon(
          Icons.close,
          color: Colors.black,
          size: 28.sp,
        ),
      ),
      centerTitle: true,
      title: BigText(
        align: TextAlign.center,
        text: text.tr,
        color: Colors.black,
        size: 19.sp,
        isBold: true,
      ),
      backgroundColor: Colors.white,
      actions: [
        InkWell(
          onTap: () {
            _mainController.reset();
            Get.toNamed(RouteHelpers.home);
          },
          child: Icon(
            Icons.restart_alt,
            color: Colors.black,
            size: 28.sp,
          ),
        )
      ],
    );
  }
}
