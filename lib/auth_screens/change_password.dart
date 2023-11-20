import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:quickalert/quickalert.dart';
import 'package:rosary/widgets/auth_button.dart';
import 'package:rosary/widgets/main_text.dart';
import 'package:rosary/widgets/password_text_field.dart';
import '../../route/route_helpers.dart';
import '../../utils/dimensions.dart';
import '../controllers/auth_controller.dart';
import '../controllers/user_controller.dart';
import '../utils/appColor.dart';
import '../utils/show_custom_snackbar.dart';

class ChangePasswordPage extends StatelessWidget {
  const ChangePasswordPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var resetPasswordController = TextEditingController();
    var passwordController = TextEditingController();
    var _auth = Get.find<AuthController>();
    var _user = Get.find<UserController>();

    void _forgotPassword() async {
      String password = passwordController.text.trim();
      String resetPassword = resetPasswordController.text.trim();
      if (password.isEmpty) {
        showCustomSnackBar("Password is required", title: "Password");
      } else if (resetPassword.length < 4) {
        showCustomSnackBar("Password should be more than 3 characters",
            title: "Password Characters");
      } else if (resetPassword.isEmpty) {
        showCustomSnackBar("Confirm password is required",
            title: "Confrim Password");
      } else if (resetPassword != password) {
        showCustomSnackBar("Password and confirm password does not match",
            title: "Mismatch Password");
      } else {
        _auth.resetPassword(password).then((res) {
          if (res.isSuccess) {
            QuickAlert.show(
              headerBackgroundColor: AppColor.primaryLight,
              backgroundColor: Theme.of(context).colorScheme.background,
              context: context,
              title: "success".tr,
              confirmBtnText: "Login",
              onConfirmBtnTap: () {
                Get.offAllNamed(RouteHelpers.signInPage);
              },
              type: QuickAlertType.success,
              text: 'Your password has been successfully changed'.tr,
            );
          } else {
            QuickAlert.show(
              backgroundColor: Theme.of(context).colorScheme.background,
              context: context,
              title: "Error".tr,
              type: QuickAlertType.error,
              text: 'Password could not be changed'.tr,
            );
          }
        });
      }
    }

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: GetBuilder<AuthController>(builder: (auth) {
        return auth.isLoading
            ? Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: SizedBox(
                  height: Dimensions.screenHeight,
                  child: Stack(
                    children: [
                      Positioned(
                        top: 0,
                        left: 0,
                        right: 0,
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 10.w, vertical: 20.h),
                          height: Dimensions.screenHeight * 0.4,
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.secondary,
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(30.sp),
                              bottomRight: Radius.circular(30.sp),
                            ),
                          ),
                          child: Column(
                            children: [
                              SizedBox(
                                height: 100.h,
                              ),
                              MainText(
                                isBold: true,
                                color: Colors.white,
                                text: "Change Password",
                                size: 18.sp,
                              ),
                              SizedBox(
                                height: 10.h,
                              ),
                              Expanded(
                                child: MainText(
                                  color: Colors.white,
                                  text:
                                      "Set a new password to log in to your account.",
                                  size: 15.sp,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        top: Dimensions.screenHeight * 0.45,
                        left: 0,
                        right: 0,
                        child: Container(
                          padding: EdgeInsets.only(top: Dimensions.height20),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topRight:
                                  Radius.circular(Dimensions.radius20 * 3),
                              //topRight: Radius.circular(Dimensions.radius20),
                            ),
                          ),
                          child: Column(
                            children: [
                              PasswordTextField(
                                isObscure: true,
                                textController: passwordController,
                                hintText: "New Password",
                                icon: Icons.password_sharp,
                              ),
                              SizedBox(
                                height: 20.h,
                              ),
                              PasswordTextField(
                                isObscure: true,
                                textController: resetPasswordController,
                                hintText: "Confirm Password",
                                icon: Icons.password_sharp,
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              );
      }),
      bottomNavigationBar: GestureDetector(
        onTap: () {
          _forgotPassword();
        },
        child: Padding(
          padding: EdgeInsets.only(
            bottom: 20.h,
          ),
          child: AuthButtonWidget(title: "Send"),
        ),
      ),
    );
  }
}
