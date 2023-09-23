import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:rosary/utils/appColor.dart';
import 'package:rosary/utils/constants.dart';

import '../controllers/main_controller.dart';

class BidIntroWidget extends StatelessWidget {
  final int id;
  final String type;
  BidIntroWidget({required this.id, required this.type});
  @override
  Widget build(BuildContext context) {
    return GetBuilder<MainController>(
      builder: (main) {
        return Container(
          width: id == main.currentIntroBidFocusId ? 80.sp : 50.sp,
          height: id == main.currentIntroBidFocusId ? 80.sp : 50.sp,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
              image: type == AppConstant.MAIN_BID
                  ? const AssetImage("assets/images/bidColor.webp")
                  : const AssetImage(
                      'assets/images/first_or_last.webp'), // Replace with your image path
              fit: BoxFit.fill, // Adjust the image fitting
            ),
          ),
        );
      },
    );
  }
}
