import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:rosary/utils/appColor.dart';
import 'package:rosary/widgets/main_app_bar_widget.dart';
import 'package:rosary/widgets/main_text.dart';

import '../controllers/affirmation_controller.dart';
import '../controllers/dailyVerse_controller.dart';
import '../main_screens/ad_mob_banner.dart';

class DailyVerseScreen extends StatefulWidget {
  const DailyVerseScreen({super.key});

  @override
  State<DailyVerseScreen> createState() => _DailyVerseScreenState();
}

class _DailyVerseScreenState extends State<DailyVerseScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: MainAppBarWidget(text: "verse_of_the_day_title"),
      body: GetBuilder<DailyVerseController>(builder: (data) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w),
          child: Container(
            child: data.hasVerse
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                        SizedBox(
                          height: 50.h,
                        ),
                        MainText(
                          color: AppColor.subTitle,
                          text: data.dailyVerseModel.verse!,
                          isBold: true,
                          size: 20.sp,
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        MainText(
                          color: AppColor.subTitle,
                          align: TextAlign.left,
                          text: data.dailyVerseModel.content!,
                          size: 20.sp,
                        ),
                        SizedBox(
                          height: 80.h,
                        ),
                      ])
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                        SizedBox(
                          height: 50.h,
                        ),
                        MainText(
                          text: "verse",
                          isBold: true,
                          size: 20.sp,
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        MainText(
                          align: TextAlign.left,
                          text: "daily_verse",
                          size: 20.sp,
                        ),
                        SizedBox(
                          height: 80.h,
                        ),
                      ]),
          ),
        );
      }),
      bottomNavigationBar: Container(
        child: AdMobBanner(),
      ),
    );
  }
}
