import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../controllers/main_controller.dart';
import '../route/route_helpers.dart';
import '../utils/appColor.dart';
import 'big_text.dart';

class MainAppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  final String text;
  MainAppBarWidget({super.key, required this.text});
  var _mainController = Get.find<MainController>();
  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      foregroundColor: Colors.white,
      centerTitle: true,
      title: BigText(
        align: TextAlign.center,
        text: text.tr,
        color: Colors.white,
        size: 19.sp,
        isBold: true,
      ),
      backgroundColor: AppColor.primaryColor,
    );
  }
}
