import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:rosary/utils/constants.dart';
import 'package:rosary/widgets/main_app_bar_widget.dart';
import 'package:rosary/widgets/main_text.dart';
import '../../route/route_helpers.dart';
import '../../utils/dimensions.dart';
import '../../widgets/big_text.dart';
import '../controllers/auth_controller.dart';
import '../controllers/user_controller.dart';
import '../utils/appColor.dart';
import '../utils/show_custom_snackbar.dart';
import '../widgets/auth_text_field.dart';
import '../widgets/regular_button.dart';

class ForgotPasswordPage extends StatelessWidget {
  const ForgotPasswordPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var passwordController = TextEditingController();
    var _auth = Get.find<AuthController>();
    var _user = Get.find<UserController>();

    void _forgotPassword() async {
      String email = emailController.text.trim();
      if (email.isEmpty) {
        showCustomSnackBar("Typein your email", title: "Email");
      } else {
        _auth.forgotPassword(email).then((status) {
          _auth.setEmail(email);
          Get.toNamed(RouteHelpers.otpPage);
        });
      }
    }

    return Scaffold(
      appBar: MainAppBarWidget(text: ""),
      backgroundColor: Colors.white,
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
                            color: AppColor.primaryColor,
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
                                text: "Forgot Password",
                                size: 18.sp,
                              ),
                              SizedBox(
                                height: 10.h,
                              ),
                              Expanded(
                                child: MainText(
                                  color: Colors.white,
                                  text:
                                      "Please enter the email address you want your password reset link to be sent to",
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
                          child: AuthTextField(
                            textController: emailController,
                            hintText: "Email",
                            icon: Icons.email,
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
          padding: EdgeInsets.only(bottom: 20.h, left: 20.w, right: 20.w),
          child: RegularBtnWidget(
            text: "Send",
            backgroundColor: AppColor.primaryColor,
          ),
        ),
      ),
    );
  }
}
