import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:rosary/route/route_helpers.dart';
import 'package:rosary/widgets/password_text_field.dart';
import '../../widgets/auth_text_field.dart';
import '../controllers/auth_controller.dart';
import '../model/signup_body_model.dart';
import '../utils/appColor.dart';
import '../utils/constants.dart';
import '../utils/dimensions.dart';
import '../utils/show_custom_snackbar.dart';
import '../widgets/main_app_bar_widget.dart';
import '../widgets/main_text.dart';

class SignUpPage extends StatelessWidget {
  SignUpPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var passwordController = TextEditingController();
    var firstnameController = TextEditingController();
    var lastnameController = TextEditingController();

    void _registration() {
      var _auth = Get.find<AuthController>();

      String firstname = firstnameController.text.trim();
      String lastname = lastnameController.text.trim();
      String email = emailController.text.trim();
      String password = passwordController.text.trim();
      if (firstname.isEmpty) {
        showCustomSnackBar("Type in your first name", title: "First name");
      } else if (firstname.length < 2 || lastname.length < 2) {
        showCustomSnackBar("First name or last name must exceed one character",
            title: "Incomplete");
      } else if (lastname.isEmpty) {
        showCustomSnackBar("Typein your last name", title: "Last name");
      } else if (email.isEmpty) {
        showCustomSnackBar("Typein your email", title: "Email");
      } else if (!GetUtils.isEmail(email)) {
        showCustomSnackBar("Type in a valid email name", title: "Email");
      } else if (password.isEmpty) {
        showCustomSnackBar("Type in your password", title: "Password");
      } else if (password.length < 4) {
        showCustomSnackBar(AppConstant.PASSWORD_LENGTH_MSG,
            title: "Invalid Password Length");
      } else {
        SignUpBody signUpBody = SignUpBody(
          firstname: firstname,
          lastname: lastname,
          password: password,
          email: email,
        );
        _auth.registration(signUpBody).then((status) {
          if (status.isSuccess) {
            if (_auth.returnUrl.isEmpty) {
              _auth.setCurrentIndex(1);
              Get.offAllNamed(RouteHelpers.home);
            } else {
              Get.offNamed(_auth.returnUrl);
            }
            // _auth.resetReturnUrl();
          } else {
            showCustomSnackBar(status.message);
          }
        });
      }
    }

    return GetBuilder<AuthController>(
      builder: (auth) {
        return Scaffold(
          appBar: MainAppBarWidget(
            text: AppConstant.SIGN_UP,
          ),
          backgroundColor: Colors.white,
          body: auth.isLoading
              ? Center(child: CircularProgressIndicator())
              : SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
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
                        color: Colors.grey.shade800,
                        size: 16.sp,
                        text: "Sign up to join our community.",
                      ),
                      SizedBox(
                        height: 15.h,
                      ),
                      AuthTextField(
                        textController: firstnameController,
                        hintText: "First name",
                        icon: Icons.account_box,
                      ),
                      SizedBox(
                        height: Dimensions.height20,
                      ),
                      AuthTextField(
                        textController: lastnameController,
                        hintText: "Last name",
                        icon: Icons.account_box,
                      ),
                      SizedBox(
                        height: Dimensions.height20,
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
                      SizedBox(
                        height: Dimensions.height20,
                      ),
                      GestureDetector(
                        onTap: () {
                          _registration();
                        },
                        child: Container(
                          margin: EdgeInsets.only(
                            left: Dimensions.height20,
                            right: Dimensions.height20,
                          ),
                          height: Dimensions.screenHeight / 13,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                Dimensions.radius30,
                              ),
                              color: AppColor.primaryColor),
                          child: Center(
                            child: MainText(
                              text: AppConstant.SIGN_UP,
                              size: Dimensions.font20 + Dimensions.font20 / 4,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: Dimensions.height10,
                      ),
                      InkWell(
                        onTap: () {
                          Get.toNamed(RouteHelpers.signInPage);
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            RichText(
                              text: TextSpan(
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () =>
                                      Get.toNamed(RouteHelpers.signInPage),
                                text: "Have an account already?",
                                style: TextStyle(
                                    color: Colors.grey[500],
                                    fontSize: Dimensions.font15),
                              ),
                            ),
                            MainText(
                              size: 16.sp,
                              text: ' Sign In',
                              color: Colors.blue,
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: Dimensions.screenHeight * 0.05,
                      ),
                    ],
                  ),
                ),
        );
      },
    );
  }
}
