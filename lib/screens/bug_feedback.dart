import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:image_picker/image_picker.dart';
import 'package:quickalert/quickalert.dart';
import 'package:rosary/controllers/bugFeedback_controller.dart';
import 'package:rosary/route/route_helpers.dart';
import 'package:rosary/widgets/app_icon.dart';
import 'package:rosary/widgets/app_text_field.dart';
import 'package:rosary/widgets/auth_button.dart';
import 'package:rosary/widgets/avatar_widget.dart';
import 'package:rosary/widgets/banner_widget.dart';
import 'package:rosary/widgets/chat_text_field.dart';
import 'package:rosary/widgets/regular_button.dart';
import '../../widgets/auth_text_field.dart';
import '../controllers/auth_controller.dart';
import '../controllers/user_controller.dart';
import '../model/signup_body_model.dart';
import '../utils/appColor.dart';
import '../utils/constants.dart';
import '../utils/dimensions.dart';
import '../utils/show_custom_snackbar.dart';
import '../widgets/main_app_bar_widget.dart';
import '../widgets/main_text.dart';

class BugFeedbackPage extends StatefulWidget {
  BugFeedbackPage({Key? key}) : super(key: key);

  @override
  State<BugFeedbackPage> createState() => _BugFeedbackPageState();
}

class _BugFeedbackPageState extends State<BugFeedbackPage> {
  var descController = TextEditingController();
  var titleController = TextEditingController();

  var _bugController = Get.find<BugFeedbackController>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  String selectedValue = '';
  @override
  Widget build(BuildContext context) {
    void _update() {
      var _auth = Get.find<AuthController>();

      String title = titleController.text.trim();
      String desc = descController.text.trim();

      if (title.isEmpty) {
        showCustomSnackBar("title_require".tr, title: "title".tr);
      } else if (selectedValue.isEmpty) {
        showCustomSnackBar("reason_require".tr, title: "reason".tr);
      } else if (desc.isEmpty) {
        showCustomSnackBar("desc_require".tr, title: "description".tr);
      } else {
        _bugController.submit(title, desc, selectedValue).then((status) {
          if (status.isSuccess) {
            QuickAlert.show(
              backgroundColor: Theme.of(context).colorScheme.background,
              context: context,
              title: "success".tr,
              onConfirmBtnTap: () {
                titleController.clear();
                descController.clear();
                Navigator.pop(context);
                setState(() {
                  selectedValue = "";
                });
                Get.toNamed(RouteHelpers.home);
              },
              type: QuickAlertType.success,
              text: 'feeback_submit_msg'.tr,
            );
            // _auth.resetReturnUrl();
          } else {
            QuickAlert.show(
              backgroundColor: Theme.of(context).colorScheme.background,
              context: context,
              type: QuickAlertType.error,
              title: 'Oops...',
              text: 'error_msg'.tr,
            );
          }
        });
      }
    }

    return GetBuilder<AuthController>(builder: (auth) {
      return GetBuilder<UserController>(
        builder: (user) {
          return Scaffold(
            backgroundColor: Theme.of(context).colorScheme.background,
            appBar: MainAppBarWidget(
              text: "feedbak_screen_title".tr,
            ),
            body: auth.isLoading
                ? Center(child: CircularProgressIndicator())
                : SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 30.h,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20.w),
                          child: ChatTextField(
                            textController: titleController,
                            hintText: "Title",
                          ),
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20.w),
                          child: DropdownButton(
                            hint: selectedValue == ""
                                ? MainText(text: 'reason'.tr, size: 18.sp)
                                : MainText(text: selectedValue, size: 18.sp),
                            isExpanded: true,
                            iconSize: 30.sp,
                            style: TextStyle(color: Colors.blue),
                            items: ['suggestion'.tr, 'Error'].map(
                              (val) {
                                return DropdownMenuItem<String>(
                                  value: val,
                                  child: MainText(
                                    text: val,
                                    size: 18.sp,
                                  ),
                                );
                              },
                            ).toList(),
                            onChanged: (val) {
                              setState(
                                () {
                                  selectedValue = val!;
                                },
                              );
                            },
                          ),
                        ),
                        SizedBox(
                          height: Dimensions.height20,
                        ),
                        AppTextField(
                          textController: descController,
                          hintText: "description".tr,
                          hasIcon: false,
                          minLine: 3,
                          maxLength: 300,
                        ),
                        SizedBox(
                          height: Dimensions.height20,
                        ),
                        SizedBox(
                          height: Dimensions.height10,
                        ),
                      ],
                    ),
                  ),
            bottomNavigationBar: user.isLoading
                ? Container(
                    padding: EdgeInsets.all(20),
                    height: 80.h,
                    width: double.maxFinite,
                    child: Center(child: CircularProgressIndicator()))
                : GestureDetector(
                    onTap: () {
                      _update();
                    },
                    child: Padding(
                      padding: EdgeInsets.only(bottom: 20.h),
                      child: AuthButtonWidget(
                        title: "submit".tr,
                      ),
                    ),
                  ),
          );
        },
      );
    });
  }
}
