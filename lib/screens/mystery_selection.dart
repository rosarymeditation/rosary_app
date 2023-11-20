import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:rosary/route/route_helpers.dart';
import 'package:rosary/utils/appColor.dart';
import 'package:rosary/utils/constants.dart';
import 'package:rosary/widgets/app_icon.dart';
import 'package:rosary/widgets/big_text.dart';
import 'package:rosary/widgets/main_app_bar_widget.dart';
import 'package:rosary/widgets/select_widget.dart';

import '../controllers/main_controller.dart';
import '../model/bid_model.dart';
import '../widgets/bid.dart';
import '../widgets/intro_bid.dart';
import '../widgets/main_text.dart';

// ignore: must_be_immutable
class MysterySelectionPage extends StatelessWidget {
  var _mainController = Get.find<MainController>();
  var apostleCreedPrayer = AppConstant.APOSTLE_CREED;
  var ourFather = AppConstant.OUR_FATHER;
  var mysteryList = AppConstant.mysteryDaysList;
  MysterySelectionPage({super.key});
  @override
  Widget build(BuildContext context) {
    return GetBuilder<MainController>(builder: (main) {
      return SafeArea(
        child: Scaffold(
          backgroundColor: Theme.of(context).colorScheme.background,
          appBar: MainAppBarWidget(text: "Mystery Selection"),
          body: Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.background,
            ),
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            child: SingleChildScrollView(
              child: Container(
                color: Theme.of(context).colorScheme.background,
                child: Column(
                  children: [
                    SizedBox(
                      height: 50.h,
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: mysteryList.length,
                      itemBuilder: (BuildContext context, int index) {
                        var mystery = mysteryList[index];
                        return InkWell(
                          onTap: () {
                            main.setMystery(mystery.name);
                          },
                          child: SelectWidget(item: mystery),
                        );
                      },
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    });
  }
}
