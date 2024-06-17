import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:focused_menu/focused_menu.dart';
import 'package:focused_menu/modals.dart';
import 'package:get/get.dart';
import 'package:rosary/controllers/prayer_request_controller.dart';
import 'package:rosary/model/prayer_request_model.dart';
import 'package:rosary/route/route_helpers.dart';
import 'package:rosary/utils/appColor.dart';
import 'package:rosary/utils/constants.dart';
import 'package:rosary/widgets/info_box.dart';
import 'package:rosary/widgets/main_app_bar_widget.dart';

import '../controllers/main_controller.dart';
import '../widgets/main_text.dart';

class PrayerRequestScreen extends StatelessWidget {
  PrayerRequestScreen({super.key});
  var _prayerController = Get.find<PrayerRequestController>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PrayerRequestController>(
      builder: (prayer) {
        var prayerList = prayer.prayerRequestList ?? [];

        return Scaffold(
          backgroundColor: Theme.of(context).colorScheme.tertiary,
          appBar: MainAppBarWidget(text: "Prayer Request"),
          body: Container(
            color: Theme.of(context).colorScheme.tertiary,
            child: SingleChildScrollView(
              physics: AlwaysScrollableScrollPhysics(),
              child: Column(
                children: [
                  prayerList.length > 0
                      ? InfoBoxWidget(text: "prayer_request_privacy")
                      : Container(),
                  SizedBox(
                    height: 20.w,
                  ),
                  ListView.builder(
                      shrinkWrap: true,
                      itemCount: prayerList.length == 0 ? 1 : prayerList.length,
                      itemBuilder: (BuildContext context, int index) {
                        return prayerList.length == 0
                            ? MainText(
                                text:
                                    "You have no prayer requests at the Moment",
                                color: Theme.of(context)
                                    .colorScheme
                                    .inversePrimary,
                                size: 18.sp,
                              )
                            : buildCard(context, prayerList[index]);
                      }),
                ],
              ),
            ),
          ),
          floatingActionButton: FloatingActionButton.extended(
            splashColor: Theme.of(context).colorScheme.primary,
            backgroundColor: Theme.of(context).colorScheme.secondary,

            icon: Icon(
              Icons.add,
              size: 20.sp,
              color: Colors.white,
            ), // Icon
            label: MainText(
              text: 'Create',
              size: 15.sp,
              color: Colors.white,
            ), // Text
            onPressed: () {
              prayer.edit(PrayerRequestModel(id: 0, content: ""));
              Get.toNamed(RouteHelpers.prayerRequestAddPage);
            },
          ),
        );
      },
    );
  }

  void showYesNoAlert(id) {
    Get.defaultDialog(
      title: "delete".tr,
      middleText: "delete_question".tr,
      textConfirm: "yes".tr,
      textCancel: "no".tr,
      confirmTextColor: Colors.white,
      buttonColor: Colors.red,
      onCancel: () {
        // Get.back();
      },
      onConfirm: () {
        _prayerController.delete(id);
        Get.back();
      },
    );
  }

  Widget buildCard(BuildContext context, PrayerRequestModel item) =>
      FocusedMenuHolder(
        menuItems: [
          FocusedMenuItem(
            title: Text('edit'.tr),
            trailingIcon: Icon(Icons.edit),
            onPressed: () {
              _prayerController.edit(item);
              Get.toNamed(RouteHelpers.prayerRequestAddPage);
            },
          ),
          FocusedMenuItem(
            title:
                Text('delete'.tr, style: const TextStyle(color: Colors.white)),
            trailingIcon: const Icon(Icons.delete_forever, color: Colors.white),
            backgroundColor: Colors.red,
            onPressed: () {
              showYesNoAlert(item.id);
            },
          ),
        ],
        blurSize: 2,
        blurBackgroundColor: Colors.white,
        menuWidth: MediaQuery.of(context).size.width * 0.5,
        menuItemExtent: 50,
        duration: const Duration(seconds: 0),
        animateMenuItems: false,
        menuOffset: 12,
        openWithTap: false,
        onPressed: () {},
        child: ListTile(
          leading: CircleAvatar(
              backgroundImage:
                  AssetImage(AppConstant.getImagePath("hand.png"))),
          title: MainText(
            text: item.content!,
            color: Theme.of(context).colorScheme.inversePrimary,
            size: 14.sp,
            align: TextAlign.left,
          ),
        ),
      );
}
