import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:quickalert/quickalert.dart';
import 'package:rosary/controllers/prayer_request_controller.dart';
import 'package:rosary/utils/appColor.dart';
import 'package:rosary/utils/show_custom_snackbar.dart';
import 'package:rosary/widgets/app_text_field.dart';
import 'package:rosary/widgets/auth_button.dart';
import 'package:rosary/widgets/main_app_bar_widget.dart';
import 'package:rosary/widgets/main_text.dart';

import '../widgets/prayer_request_text_field.dart';

class PublicPrayerRequestCreate extends StatefulWidget {
  const PublicPrayerRequestCreate({super.key});

  @override
  State<PublicPrayerRequestCreate> createState() =>
      _PublicPrayerRequestCreateState();
}

class _PublicPrayerRequestCreateState extends State<PublicPrayerRequestCreate> {
  var contentController = TextEditingController();
  var nameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return GetBuilder<PrayerRequestController>(builder: (_prayer) {
      return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.tertiary,
        appBar: MainAppBarWidget(text: "share_prayer_request".tr),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 40.h,
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 10.w),
                padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 20.h),
                decoration: BoxDecoration(
                  color: AppColor.title,
                  borderRadius: BorderRadius.circular(10.sp),
                ),
                child: Column(
                  children: [
                    MainText(
                      align: TextAlign.left,
                      color: Colors.white,
                      text: "prayer_request_box".tr,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    //"prayer_disappear_note"
                    MainText(
                      align: TextAlign.left,
                      color: Colors.white,
                      text: "prayer_disappear_note".tr,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              PrayerRequestTextField(
                minLine: 4,
                hasIcon: false,
                maxLength: 400,
                textController: contentController,
                hintText: "prayer_request".tr,
              ),
              SizedBox(
                height: 20.h,
              ),
              AppTextField(
                hasIcon: false,
                maxLength: 2,
                textController: nameController,
                hintText: "op_name".tr,
              )
            ],
          ),
        ),
        bottomNavigationBar: Container(
          margin: EdgeInsets.only(bottom: 40.h),
          child: _prayer.isLoaded
              ? InkWell(
                  onTap: () {
                    String content = contentController.text.trim();
                    String name = nameController.text.trim();
                    if (content.isEmpty) {
                      showCustomSnackBar("prayer_request_empty".tr,
                          title: "invalid_content".tr);
                      return;
                    }
                    _prayer.submitPublicRequest(content, name).then((res) {
                      if (res.isSuccess) {
                        showCustomSnackBar("prayer_request_success".tr,
                            title: "success".tr, isError: false);
                        Navigator.of(context).pop();
                      } else {
                        showCustomSnackBar("error_msg".tr,
                            title: "Prayer Submission Error");
                      }
                    });
                  },
                  child: AuthButtonWidget(title: "submit".tr))
              : Container(
                  height: 40.h,
                  child: Center(
                      child: CircularProgressIndicator(color: Colors.blue))),
        ),
      );
    });
  }
}
