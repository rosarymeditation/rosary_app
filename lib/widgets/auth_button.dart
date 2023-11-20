import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../utils/dimensions.dart';
import 'main_text.dart';

class AuthButtonWidget extends StatelessWidget {
  String title;
  AuthButtonWidget({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        left: Dimensions.height20,
        right: Dimensions.height20,
      ),
      height: Dimensions.screenHeight / 13,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          Dimensions.radius30,
        ),
        color: Theme.of(context).colorScheme.secondary,
      ),
      child: Center(
        child: MainText(
          text: title,
          size: 16.sp,
          isBold: true,
          color: Colors.white,
        ),
      ),
    );
  }
}
