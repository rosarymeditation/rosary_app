import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:rosary/controllers/prayer_request_controller.dart';
import 'package:rosary/route/route_helpers.dart';
import 'package:rosary/utils/appColor.dart';
import 'package:rosary/widgets/big_text.dart';
import 'package:rosary/widgets/main_app_bar_widget.dart';
import 'package:rosary/widgets/main_text.dart';

import '../main_screens/ad_mob_banner.dart';
import '../utils/dimensions.dart';
import '../widgets/feed_item_widget.dart';
import '../widgets/prayer_request_item_widget.dart';

class PublicPrayerRequest extends StatefulWidget {
  const PublicPrayerRequest({super.key});

  @override
  State<PublicPrayerRequest> createState() => _PublicPrayerRequestState();
}

class _PublicPrayerRequestState extends State<PublicPrayerRequest> {
  var _prayerRequestController = Get.find<PrayerRequestController>();
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    generateUserToken();
    _prayerRequestController.getPrayerList();

    // _verseController.getDailyVerse();
  }

  void generateUserToken() async {
    //this is a unique key that identifies every user that prays
    await _prayerRequestController.getRandomToken();
    if (_prayerRequestController.deviceToken == "") {
      await _prayerRequestController.setRandomToken();
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PrayerRequestController>(
      builder: (_prayer) {
        return Scaffold(
          backgroundColor: Theme.of(context).colorScheme.tertiary,
          appBar: MainAppBarWidget(text: "prayer_request".tr),
          body: _prayer.isLoaded
              ? SmartRefresher(
                  enablePullUp: true,
                  header: WaterDropHeader(),
                  controller: _refreshController,
                  onRefresh: () async {
                    _prayer.getPrayerList();

                    await Future.delayed(
                      Duration(seconds: 0, milliseconds: 2000),
                    );
                    if (_prayer.isLoaded)
                      _refreshController.refreshCompleted();
                    else
                      _refreshController.refreshFailed();
                  },
                  onLoading: () async {
                    _prayer.loadMore();

                    await Future.delayed(
                      Duration(seconds: 0, milliseconds: 2000),
                    );
                    if (_prayer.isMoreLoaded)
                      _refreshController.loadComplete();
                    else
                      _refreshController.loadFailed();
                  },
                  child: CustomScrollView(
                    slivers: [
                      SliverAppBar(
                        automaticallyImplyLeading: false,
                        toolbarHeight: 100.h,
                        elevation: 0,
                        title: Container(
                          margin: EdgeInsets.only(top: 15.w, bottom: 15.w),
                          padding: EdgeInsets.symmetric(horizontal: 15.w),
                          decoration: BoxDecoration(
                            color: AppColor.title,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 10.h,
                              ),
                              BigText(
                                  size: 14.sp,
                                  color: Colors.white,
                                  align: TextAlign.left,
                                  isBold: true,
                                  text: "unite_in_prayer".tr),
                              SizedBox(
                                height: 10.h,
                              )
                            ],
                          ),
                        ),
                        floating: true,
                        expandedHeight: Dimensions.height80,
                      ),
                      buildImages(),
                    ],
                  ),
                )
              : const Center(
                  child: CircularProgressIndicator(
                      //backgroundColor: AppColor.primaryColor,
                      ),
                ),
          bottomNavigationBar: Container(
            child: AdMobBanner(),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Get.toNamed(RouteHelpers.publicPrayerRequestCreatePage);
            },
            child: Icon(
              Icons.add,
              color: Colors.white,
              size: 29,
            ),
            backgroundColor: Theme.of(context).colorScheme.secondary,
            tooltip: 'Create',
            elevation: 5,
            splashColor: Colors.grey,
          ),
        );
      },
    );
  }

  Widget buildImages() => SliverToBoxAdapter(
        child: GetBuilder<PrayerRequestController>(builder: (_prayer) {
          int itemLength = _prayer.publicRequestList.length;
          return Column(
            children: [
              ListView.builder(
                physics: BouncingScrollPhysics(),
                itemCount: _prayer.publicRequestList.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  var item = _prayer.publicRequestList[index];

                  return PrayerRequestItemWidget(
                    item: item,
                    token: _prayerRequestController.deviceToken,
                  );
                },
              ),
            ],
          );
        }),
      );
}
