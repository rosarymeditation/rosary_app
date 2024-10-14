import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:rosary/controllers/chaplet_template_controller.dart';
import 'package:rosary/model/bid_model.dart';
import 'package:rosary/route/route_helpers.dart';
import 'package:rosary/utils/appColor.dart';
import 'package:rosary/utils/constants.dart';
import 'package:rosary/widgets/app_icon.dart';
import 'package:rosary/widgets/bead_number_widget.dart';
import 'package:rosary/widgets/html_widget.dart';
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
  late ScrollController _scrollController;
  final _chapletController = Get.find<ChapletController>();
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _pageController =
        PageController(initialPage: _mainController.currentBidFocusId);
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

  var gloryPrayer = AppConstant.GLORY_BE_TO_FATHER;

  var hailMaryPrayer = AppConstant.HAIL_MARY;

  var ourFatherPrayer = AppConstant.OUR_FATHER;

  void scrollRight() {
    try {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 100),
        curve: Curves.easeInOut,
      );
    } catch (err) {
      print(err);
    }
  }

  void scrollLeft() {
    try {
      _scrollController.animateTo(
        _scrollController.offset -
            400, // Adjust this value for desired scrolling distance
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    } catch (err) {
      print(err);
    }
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
                          ? HtmlWidget(data: 'hail_mary'.tr)
                          : Container(),
                      counter > 10
                          ? Column(children: [
                              HtmlWidget(data: 'glory_to_father'.tr),
                              const Divider(),
                              HtmlWidget(data: 'oh_my_jesus'.tr),
                            ])
                          : Container(),
                      counter == 0
                          ? HtmlWidget(
                              data: "our_father".tr,
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
                  height: 5.h,
                ),
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
                                print(item.id);
                                item.id == 11 ? null : AppConstant.vibrator();
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
                        height: Dimensions.screenHeight * 0.25,
                        child: PageView.builder(
                          controller: _pageController,
                          physics: const PageScrollPhysics(),
                          allowImplicitScrolling: true,
                          onPageChanged: (page) {
                            counter = page;
                            main.setBidFocus(page);

                            if (counter == 0) {
                              Get.toNamed(RouteHelpers.mysteryPage);
                              return;
                            }
                            if (counter <= 10) {
                              AppConstant.vibrator();
                            } else if (counter == 11) {
                              null;
                            } else if (counter == 12) {
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
                          },
                          itemCount: 14,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return Container(
                              padding: const EdgeInsets.all(10),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      InkWell(
                                          onTap: () {
                                            _pageController.jumpToPage(0);
                                            main.setBidFocus(0);
                                            AppConstant.vibrator();
                                          },
                                          child:
                                              AppConstant.getBead(counter, 0)),
                                      InkWell(
                                          onTap: () {
                                            _pageController.jumpToPage(1);
                                            main.setBidFocus(1);
                                            AppConstant.vibrator();
                                          },
                                          child:
                                              AppConstant.getBead(counter, 1)),
                                      InkWell(
                                          onTap: () {
                                            _pageController.jumpToPage(2);
                                            main.setBidFocus(2);
                                            AppConstant.vibrator();
                                          },
                                          child:
                                              AppConstant.getBead(counter, 2)),
                                      InkWell(
                                          onTap: () {
                                            _pageController.jumpToPage(3);
                                            main.setBidFocus(3);
                                            AppConstant.vibrator();
                                          },
                                          child:
                                              AppConstant.getBead(counter, 3)),
                                      InkWell(
                                          onTap: () {
                                            _pageController.jumpToPage(4);
                                            main.setBidFocus(4);
                                            AppConstant.vibrator();
                                          },
                                          child:
                                              AppConstant.getBead(counter, 4)),
                                      InkWell(
                                          onTap: () {
                                            _pageController.jumpToPage(5);
                                            main.setBidFocus(5);
                                            AppConstant.vibrator();
                                          },
                                          child:
                                              AppConstant.getBead(counter, 5))
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      InkWell(
                                          onTap: () {
                                            _pageController.jumpToPage(6);
                                            main.setBidFocus(6);
                                            AppConstant.vibrator();
                                          },
                                          child:
                                              AppConstant.getBead(counter, 6)),
                                      InkWell(
                                          onTap: () {
                                            _pageController.jumpToPage(7);
                                            main.setBidFocus(7);
                                            AppConstant.vibrator();
                                          },
                                          child:
                                              AppConstant.getBead(counter, 7)),
                                      InkWell(
                                          onTap: () {
                                            _pageController.jumpToPage(8);
                                            main.setBidFocus(8);
                                            AppConstant.vibrator();
                                          },
                                          child:
                                              AppConstant.getBead(counter, 8)),
                                      InkWell(
                                          onTap: () {
                                            _pageController.jumpToPage(9);
                                            main.setBidFocus(9);
                                            AppConstant.vibrator();
                                          },
                                          child:
                                              AppConstant.getBead(counter, 9)),
                                      InkWell(
                                          onTap: () {
                                            _pageController.jumpToPage(10);
                                            main.setBidFocus(10);
                                            AppConstant.vibrator();
                                          },
                                          child:
                                              AppConstant.getBead(counter, 10)),
                                      AppConstant.getBead(counter, 11),
                                      AppConstant.getBead(counter, 12),
                                      //AppConstant.getBead(counter, 11)
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
                  onTap: () async {
                    try {
                      var count = main.currentBidFocusId;

                      if (count <= 0) {
                        // if(main.currentDecade >1)
                        // main.setMysteryCounterDecrement(1);
                        Get.toNamed(RouteHelpers.mysteryPage);
                        return;
                      }
                      count == 11 ? null : AppConstant.vibrator();

                      main.setBidFocus(count - 1);

                      if (chaplet.templateType !=
                              AppConstant.CHAPLET_TEMPLATE_ONE &&
                          chaplet.templateType != "") {
                        _pageController.jumpToPage(count - 1);
                      }

                      if (count == 6) {
                        if (chaplet.templateType ==
                                AppConstant.CHAPLET_TEMPLATE_ONE ||
                            chaplet.templateType == "") {
                          scrollLeft();
                        }
                      }
                    } catch (er) {
                      print(er);
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
                  onTap: () async {
                    try {
                      var count = main.currentBidFocusId;

                      if (count >= 11) {
                        // _pageController.jumpToPage(
                        //   counter,
                        // );
                        main.setMysteryCounter(1);
                        if (main.currentMyesteryCounter == 6) {
                          Get.toNamed(RouteHelpers.endPrayerPage);
                        } else {
                          Get.toNamed(RouteHelpers.mysteryPage);
                          //Get.toNamed(RouteHelpers.progressPrayerPage);
                        }
                        return;
                      }
                      AppConstant.vibrator();
                      main.setBidFocus(count + 1);
                      if (chaplet.templateType !=
                              AppConstant.CHAPLET_TEMPLATE_ONE &&
                          chaplet.templateType != "") {
                        _pageController.jumpToPage(count + 1);
                      }

                      if (count > 4) {
                        if (chaplet.templateType ==
                                AppConstant.CHAPLET_TEMPLATE_ONE ||
                            chaplet.templateType == "") {
                          scrollRight();
                        }
                      }
                    } catch (err) {
                      print(err);
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

  // void _vibrator({bool isLast = true}) async {
  //   print("is last: $isLast");
  //   bool? hasVibrator = await Vibration.hasVibrator();
  //   if (hasVibrator!) {
  //     isLast
  //         ? Vibration.vibrate(duration: 1000)
  //         : Vibration.vibrate(duration: 500);
  //   }
  // }

  @override
  void dispose() {
    _pageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }
}
