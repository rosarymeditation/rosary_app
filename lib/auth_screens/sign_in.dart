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
import '../../widgets/big_text.dart';
import '../controllers/auth_controller.dart';
import '../controllers/user_controller.dart';
import '../utils/appColor.dart';
import '../utils/show_custom_snackbar.dart';
import '../widgets/auth_text_field.dart';
import '../widgets/regular_button.dart';

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
      backgroundColor: Colors.white,
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
                  child: Stack(
                    children: [
                      Positioned(
                        top: 0,
                        left: 0,
                        right: 0,
                        bottom: Dimensions.height80 * 5,
                        child: Container(
                          decoration: BoxDecoration(
                            color: AppColor.primaryColor,
                            borderRadius: BorderRadius.only(
                              bottomLeft:
                                  Radius.circular(Dimensions.radius20 * 3),
                              //topRight: Radius.circular(Dimensions.radius20),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        top: 0,
                        left: 0,
                        right: 0,
                        bottom: Dimensions.height80 * 5,
                        child: Center(
                          child: CircleAvatar(
                            radius: Dimensions.radius20 * 2,
                            backgroundColor: Colors.white,
                            backgroundImage: const AssetImage(
                              AppConstant.PRAY_LOGO,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                          top: Dimensions.height80 * 4,
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
                                    Get.toNamed(
                                        RouteHelpers.forgotPasswordPage);
                                  },
                                  child: MainText(
                                    size: 16.sp,
                                    text: 'Forgot Password?',
                                    color: Colors.blue,
                                  ),
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    _login();
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20),
                                    child: RegularBtnWidget(
                                      text: AppConstant.SIGN_IN,
                                      backgroundColor: AppColor.primaryColor,
                                    ),
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
                                              color: Colors.grey[500],
                                              fontSize: 16.sp),
                                        ),
                                      ),
                                      MainText(
                                        size: 16.sp,
                                        text: ' Sign Up',
                                        color: Colors.blue,
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ))
                    ],
                  ),
                ),
              );
      }),
    );
  }
}
