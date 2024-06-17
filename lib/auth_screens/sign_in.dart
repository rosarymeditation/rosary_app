import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:rosary/utils/constants.dart';
import 'package:rosary/widgets/main_app_bar_widget.dart';
import 'package:rosary/widgets/main_text.dart';
import 'package:rosary/widgets/password_text_field.dart';
import '../../route/route_helpers.dart';
import '../../utils/dimensions.dart';
import '../controllers/auth_controller.dart';
import '../controllers/user_controller.dart';
import '../utils/appColor.dart';
import '../utils/show_custom_snackbar.dart';
import '../widgets/auth_button.dart';
import '../widgets/auth_text_field.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var passwordController = TextEditingController();
    var _auth = Get.find<AuthController>();
    var _user = Get.find<UserController>();

    void _login() async {
      String email = emailController.text.trim();
      String password = passwordController.text.trim();
      if (email.isEmpty) {
        showCustomSnackBar("Typein your email", title: "Email");
      } else if (!GetUtils.isEmail(email)) {
        showCustomSnackBar("Typein a valid email", title: "Email");
      } else if (password.isEmpty) {
        showCustomSnackBar("Typein your password", title: "Password");
      } else {
        _auth.login(password, email).then((status) {
          if (status.isSuccess) {
            _user.getUserInfo();
            if (_auth.returnUrl.isEmpty) {
              _auth.setCurrentIndex(1);
              Get.offAllNamed(RouteHelpers.home);
            } else {
              Get.offNamed(_auth.returnUrl);
            }
            //  _auth.resetReturnUrl();
          } else {
            showCustomSnackBar("Invalid login credentials");
          }
        });
        // var user = Get.find<AccountController>().user;
        //sharedPreferences.setString(AppConstants.USER_KEY, user.toString());

        //Get.toNamed(RouteHelpers.home);
      }
    }

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: MainAppBarWidget(
        text: AppConstant.SIGN_IN,
      ),
      body: GetBuilder<AuthController>(builder: (auth) {
        return auth.isLoading
            ? Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: SizedBox(
                  height: Dimensions.screenHeight,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 30.h,
                      ),
                      CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 30.sp,
                        backgroundImage: AssetImage(AppConstant.DEFAULT_LOGO),
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      MainText(
                        color: AppColor.subTitle,
                        size: 16.sp,
                        text: "Welcome back! Sign in to continue with us.",
                      ),
                      SizedBox(
                        height: 15.h,
                      ),
                      AuthTextField(
                        textController: emailController,
                        hintText: "Email",
                        icon: Icons.email,
                      ),
                      SizedBox(
                        height: Dimensions.height20,
                      ),
                      PasswordTextField(
                        textController: passwordController,
                        hintText: "Password",
                        icon: Icons.password_sharp,
                        isObscure: true,
                      ),
                      SizedBox(
                        height: Dimensions.height20,
                      ),
                      InkWell(
                        onTap: () {
                          Get.toNamed(RouteHelpers.forgotPasswordPage);
                        },
                        child: MainText(
                          size: 16.sp,
                          text: 'Forgot Password?',
                          color: AppColor.subTitle,
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      GestureDetector(
                        onTap: () {
                          _login();
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: AuthButtonWidget(title: AppConstant.SIGN_IN),
                        ),
                      ),
                      SizedBox(
                        height: Dimensions.height10,
                      ),
                      InkWell(
                        onTap: () {
                          Get.toNamed(RouteHelpers.signUpPage);
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            RichText(
                              text: TextSpan(
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    // Get.toNamed(RouteHelpers.signUp);
                                  },
                                text: "Have no account yet?",
                                style: TextStyle(
                                    color: Colors.grey[500], fontSize: 16.sp),
                              ),
                            ),
                            MainText(
                              size: 16.sp,
                              text: ' Sign Up',
                              color: AppColor.subTitle,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 15.h,
                      ),
                      // Row(
                      //   children: [
                      //     Expanded(child: Divider()),
                      //     MainText(text: "OR"),
                      //     Expanded(child: Divider())
                      //   ],
                      // ),
                      // SizedBox(
                      //   height: 20.h,
                      // ),
                      // Padding(
                      //   padding: EdgeInsets.symmetric(horizontal: 10.w),
                      //   child: ElevatedButton(
                      //     style: ElevatedButton.styleFrom(
                      //       padding: EdgeInsets.all(
                      //           16.0), // Padding around the button content
                      //       shape: RoundedRectangleBorder(
                      //         borderRadius: BorderRadius.circular(
                      //             8.0), // Button border radius
                      //       ),
                      //       textStyle: TextStyle(
                      //         fontSize: 18.0, // Text size
                      //         fontWeight: FontWeight.bold, // Text weight
                      //       ),
                      //     ),
                      //     onPressed: () {
                      //       // AuthService().signInWithGoogle();
                      //     },
                      //     child: Row(
                      //       children: [
                      //         CircleAvatar(
                      //           backgroundColor: Colors.white,
                      //           radius: 20.sp,
                      //           backgroundImage:
                      //               AssetImage("assets/images/google.webp"),
                      //         ),
                      //         SizedBox(
                      //           width: 10.w,
                      //         ),
                      //         MainText(
                      //           color: Colors.black,
                      //           text: "Continue with Google",
                      //           size: 18.sp,
                      //         )
                      //       ],
                      //     ),
                      //   ),
                      // ),
                      // SizedBox(
                      //   height: 40.h,
                      // )
                    ],
                  ),
                ),
              );
      }),
    );
  }
}
