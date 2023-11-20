import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:quickalert/quickalert.dart';
import 'package:rosary/utils/show_custom_snackbar.dart';
import 'package:rosary/widgets/main_app_bar_widget.dart';
import 'package:rosary/widgets/main_text.dart';

import '../controllers/auth_controller.dart';
import '../controllers/user_controller.dart';
import '../route/route_helpers.dart';
import '../widgets/account_widget.dart';

class SettingsScreen extends StatelessWidget {
  SettingsScreen({super.key});
  var _userController = Get.find<UserController>();
  var _authController = Get.find<AuthController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: MainAppBarWidget(text: "Settings"),
      body: GetBuilder<AuthController>(
        builder: (auth) {
          return SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              child: auth.isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : Column(
                      children: [
                        SizedBox(
                          height: 30.h,
                        ),
                        InkWell(
                          onTap: () {
                            _userController.getUserInfo().then((value) {
                              if (value.isSuccess) {
                                Get.toNamed(RouteHelpers.editProfilePage);
                              }
                            });
                          },
                          child: AccountWidget(
                              iconBackgroundColor: Colors.grey,
                              hasArrow: true,
                              leftIcon: Icons.edit,
                              text: "Edit Profile"),
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        InkWell(
                          onTap: () async {
                            _authController.setCurrentUserId();
                            // auth.clearSharedData();
                            _authController.setCurrentIndex(0);
                            Get.toNamed(RouteHelpers.userFeedPage);
                          },
                          child: AccountWidget(
                              iconBackgroundColor: Colors.blue,
                              hasArrow: false,
                              leftIcon: Icons.feed_outlined,
                              text: "My Posts"),
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        InkWell(
                          onTap: () {
                            auth.clearSharedData();
                            auth.setCurrentIndex(0);
                            Get.toNamed(RouteHelpers.home);
                          },
                          child: AccountWidget(
                              iconBackgroundColor: Colors.orange,
                              hasArrow: false,
                              leftIcon: Icons.logout_outlined,
                              text: "Logout"),
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        InkWell(
                          onTap: () async {
                            QuickAlert.show(
                              backgroundColor:
                                  Theme.of(context).colorScheme.background,
                              context: context,
                              confirmBtnText: 'Delete',
                              cancelBtnText: 'Cancel',
                              confirmBtnColor: Colors.red,
                              onConfirmBtnTap: () {
                                Navigator.pop(context);
                                _authController.deleteUserAccount().then(
                                  (value) {
                                    if (value.isSuccess) {
                                      auth.clearSharedData();

                                      Get.offAndToNamed(
                                          RouteHelpers.signInPage);
                                    } else {
                                      showCustomSnackBar("error_msg".tr,
                                          title: "", isError: true);
                                    }
                                  },
                                );
                              },
                              type: QuickAlertType.confirm,
                              text:
                                  'Are you sure you want to delete your account?'
                                      .tr,
                            );
                          },
                          child: AccountWidget(
                              iconBackgroundColor: Colors.red,
                              hasArrow: false,
                              leftIcon: Icons.delete,
                              text: "Delete Account"),
                        ),
                      ],
                    ),
            ),
          );
        },
      ),
    );
  }
}
