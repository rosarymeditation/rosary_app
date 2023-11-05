import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:rosary/widgets/main_app_bar_widget.dart';
import 'package:rosary/widgets/main_text.dart';

import '../controllers/affirmation_controller.dart';
import '../controllers/dailyVerse_controller.dart';

class AffirmationScreen extends StatefulWidget {
  const AffirmationScreen({super.key});

  @override
  State<AffirmationScreen> createState() => _AffirmationScreenState();
}

class _AffirmationScreenState extends State<AffirmationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppBarWidget(text: "daily_affirmation_title"),
      body: GetBuilder<AffirmationController>(builder: (data) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            SizedBox(
              height: 50.h,
            ),
            Image(
              image: const AssetImage('assets/images/affirmation.webp'),
              width: double.maxFinite,
              height: 200.h,
              fit: BoxFit.cover,
            ),
            SizedBox(
              height: 10.h,
            ),
            data.hasAffirmation
                ? MainText(
                    align: TextAlign.left,
                    text: data.dailyAffirmationModel.content!,
                    size: 20.sp,
                  )
                : MainText(
                    text: "daily_affirmation",
                    size: 20.sp,
                  ),
          ]),
        );
      }),
    );
  }
}
