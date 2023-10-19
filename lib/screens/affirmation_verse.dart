import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:rosary/widgets/main_text.dart';

import '../controllers/affirmation_controller.dart';
import '../controllers/dailyVerse_controller.dart';

class AffirmationAndVerseScreen extends StatefulWidget {
  const AffirmationAndVerseScreen({super.key});

  @override
  State<AffirmationAndVerseScreen> createState() =>
      _AffirmationAndVerseScreenState();
}

class _AffirmationAndVerseScreenState extends State<AffirmationAndVerseScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          bottom: TabBar(
            tabs: [
              Tab(text: "verse_of_the_day_title".tr),
              Tab(text: "daily_affirmation_title".tr),
            ],
          ),
          title: Text('daily_inspiration'.tr),
        ),
        body: TabBarView(
          children: [
            GetBuilder<DailyVerseController>(builder: (data) {
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
                                text: data.dailyVerseModel.verse!,
                                isBold: true,
                                size: 20.sp,
                              ),
                              SizedBox(
                                height: 10.h,
                              ),
                              MainText(
                                align: TextAlign.left,
                                text: data.dailyVerseModel.content!,
                                size: 20.sp,
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
                            ]),
                ),
              );
            }),
            GetBuilder<AffirmationController>(builder: (data) {
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.w),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 50.h,
                      ),
                      // MainText(
                      //   text: data.dailyAffirmationModel.verse!,
                      //   isBold: true,
                      //   size: 20.sp,
                      // ),
                      // SizedBox(
                      //   height: 10.h,
                      // ),
                      Image(
                        image: AssetImage('assets/images/affirmation.webp'),
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
          ],
        ),
      ),
    );
  }
}
