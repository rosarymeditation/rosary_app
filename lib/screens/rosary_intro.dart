import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:rosary/controllers/chaplet_template_controller.dart';
import 'package:rosary/route/route_helpers.dart';
import 'package:rosary/utils/appColor.dart';
import 'package:rosary/utils/constants.dart';
import 'package:rosary/utils/dimensions.dart';
import 'package:rosary/widgets/rosary_app_bar_widget.dart';
import 'package:rosary/widgets/app_icon.dart';
import 'package:rosary/widgets/creed_widget.dart';
import 'package:rosary/widgets/our_father_widget.dart';
import '../controllers/main_controller.dart';
import '../model/bid_model.dart';
import '../widgets/bead_number_widget.dart';
import '../widgets/intro_bid.dart';
import '../widgets/main_text.dart';

// ignore: must_be_immutable
class RosaryIntroPage extends StatefulWidget {
  RosaryIntroPage({super.key});

  @override
  State<RosaryIntroPage> createState() => _RosaryIntroPageState();
}

class _RosaryIntroPageState extends State<RosaryIntroPage> {
  final _mainController = Get.find<MainController>();
  final PageController _pageController = PageController();
  final _chapletController = Get.find<ChapletController>();
  @override
  void initState() {
    super.initState();
    _chapletController.getTemplate();
    _mainController.cacheLastScreenName(RouteHelpers.rosaryIntroPage);
  }

  var apostleCreedPrayer = AppConstant.APOSTLE_CREED;

  var ourFather = AppConstant.OUR_FATHER;

  var hailMaryPrayer = AppConstant.HAIL_MARY;

  final ScrollController _scrollController = ScrollController();

  List<BidModel> bidModelList = [
    BidModel(
      id: -1,
      type: AppConstant.END_OR_BEGIN_BID,
      hasSelected: false,
      isCrucifix: true,
    ),
    BidModel(id: 0, type: AppConstant.END_OR_BEGIN_BID, hasSelected: false),
    BidModel(id: 1, type: AppConstant.MAIN_BID, hasSelected: false),
    BidModel(id: 2, type: AppConstant.MAIN_BID, hasSelected: false),
    BidModel(id: 3, type: AppConstant.MAIN_BID, hasSelected: false),
    BidModel(id: 4, type: AppConstant.END_OR_BEGIN_BID, hasSelected: false),
    // Add more instances as needed
  ];

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MainController>(builder: (main) {
      var counter = main.currentIntroBidFocusId;
      return GetBuilder<ChapletController>(builder: (chaplet) {
        return Scaffold(
          backgroundColor: Theme.of(context).colorScheme.background,
          appBar: const RosaryAppBarWidget(text: "opening_bead"),
          body: Container(
            color: Theme.of(context).colorScheme.background,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  margin: EdgeInsets.only(top: 20.h),
                  child: Column(
                    children: [
                      counter == 0
                          ? Column(
                              children: [
                                MainText(
                                  text: "name_of_father",
                                  size: 15.sp,
                                  color: Theme.of(context)
                                      .colorScheme
                                      .inversePrimary,
                                  isBold: true,
                                ),
                                SizedBox(
                                  height: 20.h,
                                ),
                                ApostleCreedWidget(),
                                SizedBox(
                                  height: 20.h,
                                ),
                                OurFatherWidget(),
                              ],
                            )
                          : Container(),
                      counter >= 1 && counter <= 3
                          ? Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: MainText(
                                color: Theme.of(context)
                                    .colorScheme
                                    .inversePrimary,
                                text: 'hail_mary'.tr,
                                size: 15.sp,
                              ),
                            )
                          : Container(),
                      counter > 3
                          ? Column(children: [
                              MainText(
                                color: Theme.of(context)
                                    .colorScheme
                                    .inversePrimary,
                                text: 'glory_to_father'.tr,
                                size: 15.sp,
                              ),
                              Divider(),
                              MainText(
                                color: Theme.of(context)
                                    .colorScheme
                                    .inversePrimary,
                                text: 'oh_my_jesus'.tr,
                                size: 15.sp,
                              ),
                            ])
                          : Container(),
                      counter >= 1 && counter <= 3
                          ? BeadNumberCounterWidget(counter: counter)
                          : Container(),
                    ],
                  ),
                ),
                // SizedBox(
                //   height: 40.h,
                // ),
                SizedBox(
                    height: 200.h,
                    child: chaplet.templateType ==
                                AppConstant.CHAPLET_TEMPLATE_ONE ||
                            chaplet.templateType == ""
                        ? Container(
                            margin: EdgeInsets.only(top: 20.h),
                            child: SizedBox(
                              height: Dimensions.screenHeight * 0.2,
                              child: ListView.builder(
                                shrinkWrap: true,
                                controller: _scrollController,
                                scrollDirection: Axis.horizontal,
                                itemCount: bidModelList.length,
                                itemBuilder: (BuildContext context, int index) {
                                  var item = bidModelList[index];
                                  return InkWell(
                                    onTap: () {
                                      main.setIntroBidFocus(item.id);
                                      AppConstant.vibrator();
                                    },
                                    child: item.isCrucifix
                                        ? Image.asset(
                                            'assets/images/cross.png',
                                            height: 80.h,
                                            width: 80.w,
                                          )
                                        : BidIntroWidget(
                                            id: item.id,
                                            type: item.type,
                                          ),
                                  );
                                },
                              ),
                            ),
                          )
                        : PageView.builder(
                            controller: _pageController,
                            itemCount: 6,
                            scrollDirection: Axis.horizontal,
                            onPageChanged: (index) {
                              print(index);
                              if (index == 5) {
                                Get.toNamed(RouteHelpers.mysteryPage);
                                return;
                              }

                              main.setIntroBidFocus(index);
                              if (index < 4) {
                                AppConstant.vibrator();
                              }
                            },
                            itemBuilder: (context, index) {
                              return Container(
                                padding: const EdgeInsets.all(10),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        InkWell(
                                          onTap: (){
                                             main.setIntroBidFocus(1);
                                             AppConstant.vibrator();
                                          },
                                          child: AppConstant.getBead(counter, 1)),
                                        InkWell(
                                          onTap: (){
                                            main.setIntroBidFocus(2);
                                            AppConstant.vibrator();
                                          },
                                          child: AppConstant.getBead(counter, 2)),
                                        InkWell(
                                          onTap: (){
                                             main.setIntroBidFocus(3);
                                             AppConstant.vibrator();
                                          },
                                          child: AppConstant.getBead(counter, 3)),
                                        Container(),
                                        Container(),
                                      ],
                                    ),
                                  ],
                                ),
                              );
                            }))
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
                    var count = counter;
                    if (count <= 0) {
                      main.setIntroBidFocus(0);
                      main.reset();
                      Get.toNamed(RouteHelpers.home);
                    } else {
                      if (count < 4) {
                        AppConstant.vibrator();
                      }
                      main.setIntroBidFocus(count - 1);
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
                    // Get.toNamed(RouteHelpers.chapletPage);
                    var count = counter;
                    if (count == 4) {
                      Get.toNamed(RouteHelpers.mysteryPage);
                      return;
                    }
                    main.setIntroBidFocus(count + 1);
                   
                    if (count < 3) {
                      AppConstant.vibrator();
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
}
