import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:rosary/controllers/chaplet_template_controller.dart';
import 'package:rosary/model/bid_model.dart';
import 'package:rosary/route/route_helpers.dart';
import 'package:rosary/utils/appColor.dart';
import 'package:rosary/utils/constants.dart';
import 'package:rosary/widgets/app_icon.dart';
import 'package:rosary/widgets/bead_number_widget.dart';
import 'package:rosary/widgets/main_text.dart';

import '../controllers/main_controller.dart';
import '../utils/dimensions.dart';
import '../widgets/bid.dart';
import '../widgets/rosary_app_bar_widget.dart';

// ignore: must_be_immutable
class ChapletPage extends StatefulWidget {
  const ChapletPage({super.key});

  @override
  State<ChapletPage> createState() => _ChapletPageState();
}

class _ChapletPageState extends State<ChapletPage> {
  final _mainController = Get.find<MainController>();

  final _chapletController = Get.find<ChapletController>();
  final PageController _pageController = PageController();

  @override
  void initState() {
    super.initState();
    _chapletController.getTemplate();
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
      return GetBuilder<ChapletController>(builder: (chaplet) {
        return Scaffold(
          backgroundColor: Theme.of(context).colorScheme.background,
          appBar: RosaryAppBarWidget(text: main.currentDecade),
          body: Container(
            color: Theme.of(context).colorScheme.background,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  margin: EdgeInsets.only(top: 20.h),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                SizedBox(
                  height: 15.h,
                ),
                counter >= 10
                    ? ElevatedButton.icon(
                        onPressed: () {
                          // Get.toNamed(RouteHelpers.mysteryPage);
                          main.setMysteryCounter(1);
                          if (main.currentMyesteryCounter == 6) {
                            Get.toNamed(RouteHelpers.endPrayerPage);
                          } else {
                            Get.toNamed(RouteHelpers.mysteryPage);
                            //Get.toNamed(RouteHelpers.progressPrayerPage);
                          }
                        },
                        icon: const Icon(
                            Icons.double_arrow_outlined), // Your desired icon
                        label: Text('continue'.tr), // Your desired text
                        style: ElevatedButton.styleFrom(
                          primary: Theme.of(context)
                              .colorScheme
                              .secondary, // Background color
                          onPrimary: Colors.white, // Text and icon color
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 12),
                          textStyle: TextStyle(fontSize: 16.sp),
                        ),
                      )
                    : Container(),
                counter == 0
                    ? ElevatedButton.icon(
                        onPressed: () {
                          var count = main.currentBidFocusId;

                          if (count <= 0) {
                            // if(main.currentDecade >1)
                            // main.setMysteryCounterDecrement(1);
                            Get.toNamed(RouteHelpers.mysteryPage);
                            return;
                          }
                          main.setBidFocus(count - 1);
                        },
                        icon: const Icon(
                            Icons.double_arrow_outlined), // Your desired icon
                        label: const Text(
                            'Back to Mysteries'), // Your desired text
                        style: ElevatedButton.styleFrom(
                          primary: Theme.of(context)
                              .colorScheme
                              .secondary, // Background color
                          onPrimary: Colors.white, // Text and icon color
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 12),
                          textStyle: const TextStyle(fontSize: 16),
                        ),
                      )
                    : Container(),
                chaplet.templateType == AppConstant.CHAPLET_TEMPLATE_ONE ||
                        chaplet.templateType == ""
                    ? SizedBox(
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
                      )
                    : SizedBox(
                        height: 200.h,
                        child: PageView.builder(
                          controller: _pageController,
                          physics: const PageScrollPhysics(),
                          allowImplicitScrolling: true,
                          onPageChanged: (page) {
                            counter = page;
                            main.setBidFocus(page);
                          },
                          itemCount: 11,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return Container(
                              padding: const EdgeInsets.all(10),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(),
                                      AppConstant.getBead(counter, 1),
                                      AppConstant.getBead(counter, 2),
                                      AppConstant.getBead(counter, 3),
                                      AppConstant.getBead(counter, 4),
                                      AppConstant.getBead(counter, 5)
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      AppConstant.getBead(counter, 6),
                                      AppConstant.getBead(counter, 7),
                                      AppConstant.getBead(counter, 8),
                                      AppConstant.getBead(counter, 9),
                                      AppConstant.getBead(counter, 10)
                                    ],
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
              ],
            ),
          ),
          bottomNavigationBar: Container(
            color: Theme.of(context).colorScheme.tertiary,
            padding: EdgeInsets.only(
                left: 20.w, right: 20.w, bottom: 20.h, top: 20.h),
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
                      if (chaplet.templateType ==
                              AppConstant.CHAPLET_TEMPLATE_ONE ||
                          chaplet.templateType == "") {
                        scrollLeft();
                      }
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
                      _pageController.jumpToPage(
                        counter,
                      );
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
                      if (chaplet.templateType ==
                              AppConstant.CHAPLET_TEMPLATE_ONE ||
                          chaplet.templateType == "") {
                        scrollRight();
                      }
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
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}
