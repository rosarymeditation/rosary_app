import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:rosary/route/route_helpers.dart';
import 'package:rosary/utils/appColor.dart';
import 'package:rosary/utils/constants.dart';
import 'package:rosary/widgets/big_text.dart';
import 'package:rosary/widgets/main_text.dart';

import '../controllers/main_controller.dart';
import '../widgets/app_icon.dart';

class RosaryProgressPrayerScreen extends StatefulWidget {
  @override
  State<RosaryProgressPrayerScreen> createState() =>
      _RosaryProgressPrayerScreenState();
}

class _RosaryProgressPrayerScreenState
    extends State<RosaryProgressPrayerScreen> {
  var gloryPrayer = AppConstant.GLORY_BE_TO_FATHER;

  var myJesus = AppConstant.OH_MY_JESUS;

  var _mainController = Get.find<MainController>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _mainController.cacheLastScreenName(RouteHelpers.progressPrayerPage);
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MainController>(builder: (main) {
      return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        body: SafeArea(
          child: SingleChildScrollView(
            physics: const ScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Container(
                    height: 200.h,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage(AppConstant.IMG_PATH + "glory.webp"),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 50.h,
                  ),
                  Column(
                    children: [
                      InkWell(
                        onTap: () {
                          _mainController.setPrayer(myJesus);
                          Get.toNamed(RouteHelpers.popUpPrayer);
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: MainText(
                                isBold: true,
                                text: 'oh_my_jesus_title'.tr,
                                size: 20.sp,
                              ),
                            ),
                            const CircleAvatar(
                              radius: 15, // Image radius
                              backgroundImage:
                                  AssetImage(AppConstant.IMG_PATH + "tap.gif"),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      MainText(
                        text: 'mary_queen_of_peace'.tr,
                        size: 22.sp,
                        isBold: true,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 30.h,
                  )
                ],
              ),
            ),
          ),
        ),
        bottomNavigationBar: Container(
          padding: EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 30.h),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            InkWell(
              onTap: () {
                if (main.currentMyesteryCounter == 1) {
                  Get.toNamed(RouteHelpers.rosaryIntroPage);
                } else {
                  main.setBidFocus(11);
                  main.setMysteryCounterDecrement(1);
                  Get.toNamed(RouteHelpers.chapletPage);
                }
              },
              child: AppIcon(
                iconColor: Colors.white,
                backgroundColor: AppColor.primaryColor,
                icon: Icons.arrow_back_sharp,
                iconSize: 40.sp,
                size: 60.sp,
              ),
            ),
            InkWell(
              onTap: () {
                Get.toNamed(RouteHelpers.mysteryPage);
              },
              child: AppIcon(
                iconColor: Colors.white,
                backgroundColor: AppColor.primaryColor,
                icon: Icons.arrow_forward_sharp,
                iconSize: 40.sp,
                size: 60.sp,
              ),
            ),
          ]),
        ),
      );
    });
  }
}
