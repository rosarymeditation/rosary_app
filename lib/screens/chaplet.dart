import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:rosary/model/bid_model.dart';
import 'package:rosary/route/route_helpers.dart';
import 'package:rosary/utils/appColor.dart';
import 'package:rosary/utils/constants.dart';
import 'package:rosary/utils/dimensions.dart';
import 'package:rosary/widgets/app_icon.dart';
import 'package:rosary/widgets/bead_number_widget.dart';
import 'package:rosary/widgets/bid.dart';
import 'package:rosary/widgets/big_text.dart';
import 'package:rosary/widgets/glory_widget.dart';
import 'package:rosary/widgets/hail_mary_widget.dart';
import 'package:rosary/widgets/main_text.dart';
import 'package:rosary/widgets/our_father_widget.dart';

import '../controllers/main_controller.dart';
import '../widgets/rosary_app_bar_widget.dart';

// ignore: must_be_immutable
class ChapletPage extends StatefulWidget {
  ChapletPage({super.key});

  @override
  State<ChapletPage> createState() => _ChapletPageState();
}

class _ChapletPageState extends State<ChapletPage> {
  var _mainController = Get.find<MainController>();
  @override
  void initState() {
    super.initState();
    // Perform initialization tasks here
    _mainController.cacheLastScreenName(RouteHelpers.chapletPage);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Call your method here
      if (_mainController.currentBidFocusId >= 6) {
        scrollRight();
      }
    });
  }

  List<BidModel> bidModelList = [
    BidModel(id: 0, type: AppConstant.END_OR_BEGIN_BID, hasSelected: false),
    BidModel(id: 1, type: AppConstant.MAIN_BID, hasSelected: false),
    BidModel(id: 2, type: AppConstant.MAIN_BID, hasSelected: false),
    BidModel(id: 3, type: AppConstant.MAIN_BID, hasSelected: false),
    BidModel(id: 4, type: AppConstant.MAIN_BID, hasSelected: false),
    BidModel(id: 5, type: AppConstant.MAIN_BID, hasSelected: false),
    BidModel(id: 6, type: AppConstant.MAIN_BID, hasSelected: false),
    BidModel(id: 7, type: AppConstant.MAIN_BID, hasSelected: false),
    BidModel(id: 8, type: AppConstant.MAIN_BID, hasSelected: false),
    BidModel(id: 9, type: AppConstant.MAIN_BID, hasSelected: false),
    BidModel(id: 10, type: AppConstant.MAIN_BID, hasSelected: false),
    BidModel(id: 11, type: AppConstant.END_OR_BEGIN_BID, hasSelected: false),
    // Add more instances as needed
  ];

  final ScrollController _scrollController = ScrollController();

  var gloryPrayer = AppConstant.GLORY_BE_TO_FATHER;

  var hailMaryPrayer = AppConstant.HAIL_MARY;

  var ourFatherPrayer = AppConstant.OUR_FATHER;

  void scrollRight() {
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 100),
      curve: Curves.easeInOut,
    );
  }

  void scrollLeft() {
    _scrollController.animateTo(
      _scrollController.offset -
          400, // Adjust this value for desired scrolling distance
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MainController>(builder: (main) {
      main.setDecade();
      var counter = main.currentBidFocusId;
      return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        appBar: RosaryAppBarWidget(text: main.currentDecade),
        body: Container(
          child: Container(
            color: Theme.of(context).colorScheme.background,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  margin: EdgeInsets.only(top: 20.h),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      counter >= 1 && counter <= 10
                          ? MainText(
                              color:
                                  Theme.of(context).colorScheme.inversePrimary,
                              text: 'hail_mary'.tr,
                              size: 15.sp,
                            )
                          : Container(),
                      counter > 10
                          ? Column(children: [
                              MainText(
                                color: Theme.of(context)
                                    .colorScheme
                                    .inversePrimary,
                                text: 'glory_to_father'.tr,
                                size: 15.sp,
                              ),
                              const Divider(),
                              MainText(
                                color: Theme.of(context)
                                    .colorScheme
                                    .inversePrimary,
                                text: 'oh_my_jesus'.tr,
                                size: 15.sp,
                              ),
                            ])
                          : Container(),
                      counter == 0
                          ? MainText(
                              color:
                                  Theme.of(context).colorScheme.inversePrimary,
                              text: "our_father",
                              size: 15.sp,
                            )
                          : Container(),
                      SizedBox(
                        height: 20.h,
                      ),
                      counter <= 0 || counter > 10
                          ? const Text("")
                          : BeadNumberCounterWidget(counter: counter),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 20.h),
                  child: SizedBox(
                    height: Dimensions.screenHeight * 0.2,
                    child: ListView.builder(
                      controller: _scrollController,
                      scrollDirection: Axis.horizontal,
                      itemCount: bidModelList.length,
                      itemBuilder: (BuildContext context, int index) {
                        var item = bidModelList[index];
                        return InkWell(
                          onTap: () {
                            main.setBidFocus(item.id);
                          },
                          child: BidWidget(
                            id: item.id,
                            type: item.type,
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: Container(
          color: Theme.of(context).colorScheme.tertiary,
          padding:
              EdgeInsets.only(left: 20.w, right: 20.w, bottom: 20.h, top: 20.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                onTap: () {
                  var count = main.currentBidFocusId;
                  if (count <= 0) {
                    // if(main.currentDecade >1)
                    // main.setMysteryCounterDecrement(1);
                    Get.toNamed(RouteHelpers.mysteryPage);
                    return;
                  }
                  main.setBidFocus(count - 1);
                  if (count == 6) {
                    scrollLeft();
                  }
                },
                child: AppIcon(
                  backgroundColor: AppColor.iconColor,
                  iconColor: Colors.white,
                  icon: Icons.arrow_back_sharp,
                  iconSize: 40.sp,
                  size: 60.sp,
                ),
              ),
              InkWell(
                onTap: () {
                  var count = main.currentBidFocusId;
                  if (count == 11) {
                    main.setMysteryCounter(1);
                    if (main.currentMyesteryCounter == 6) {
                      Get.toNamed(RouteHelpers.endPrayerPage);
                    } else {
                      Get.toNamed(RouteHelpers.mysteryPage);
                      //Get.toNamed(RouteHelpers.progressPrayerPage);
                    }
                    return;
                  }

                  main.setBidFocus(count + 1);

                  if (count > 4) {
                    scrollRight();
                  }
                },
                child: AppIcon(
                  backgroundColor: AppColor.iconColor,
                  iconColor: Colors.white,
                  icon: Icons.arrow_forward_sharp,
                  iconSize: 40.sp,
                  size: 60.sp,
                ),
              )
            ],
          ),
        ),
      );
    });
  }
}
