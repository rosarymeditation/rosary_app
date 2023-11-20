import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:rosary/widgets/main_text.dart';

import '../controllers/auth_controller.dart';
import '../controllers/user_controller.dart';
import '../route/route_helpers.dart';
import '../utils/appColor.dart';
import '../utils/show_custom_snackbar.dart';

class OtpScreen extends StatefulWidget {
  @override
  _OtpScreenState createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final digitOne = TextEditingController();
  final digitTwo = TextEditingController();
  final digitThree = TextEditingController();
  final digitFour = TextEditingController();
  var _user = Get.find<UserController>();

  late Timer _timer;
  int _start = 0;
  bool _canResend = true;

  void startTimer() {
    _start = 60;
    _canResend = false;
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_start == 0) {
          _canResend = true;
          setState(() {
            timer.cancel();
          });
        } else {
          setState(() {
            _start--;
          });
        }
      },
    );
  }

  @override
  void initState() {
    startTimer();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthController>(builder: (auth) {
      return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Theme.of(context).colorScheme.background,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 24, horizontal: 32),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Icon(
                        Icons.arrow_back,
                        size: 32,
                        color: AppColor.subTitle,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 18,
                  ),
                  Container(
                    width: 200,
                    height: 200,
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.tertiary,
                      shape: BoxShape.circle,
                    ),
                    child: Image.asset(
                      'assets/images/key.png',
                    ),
                  ),
                  SizedBox(
                    height: 24,
                  ),
                  Text(
                    'Verification',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Please enter the 4-digit code sent to your email.",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: AppColor.subTitle,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 28,
                  ),
                  Container(
                    padding: EdgeInsets.all(28),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.tertiary,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            _textFieldOTP(
                                first: true, last: false, controller: digitOne),
                            _textFieldOTP(
                                first: false,
                                last: false,
                                controller: digitTwo),
                            _textFieldOTP(
                                first: false,
                                last: false,
                                controller: digitThree),
                            _textFieldOTP(
                                first: false,
                                last: true,
                                controller: digitFour),
                          ],
                        ),
                        SizedBox(
                          height: 22,
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: auth.isLoading
                              ? Center(child: CircularProgressIndicator())
                              : ElevatedButton(
                                  onPressed: () {
                                    if (digitOne.text.isNotEmpty &&
                                        digitTwo.text.isNotEmpty &&
                                        digitThree.text.isNotEmpty &&
                                        digitFour.text.isNotEmpty) {
                                      var code = digitOne.text +
                                          digitTwo.text +
                                          digitThree.text +
                                          digitFour.text;
                                      auth.verifyPassword(code).then((value) {
                                        if (value.isSuccess) {
                                          auth.setCode(code);
                                          Get.toNamed(
                                              RouteHelpers.changePasswordPage);

                                          if (auth.returnUrl.isEmpty) {
                                            // Get.offNamed(RouteHelpers.home);
                                          } else {
                                            Get.offNamed(auth.returnUrl);
                                          }
                                          //auth.resetReturnUrl();
                                        } else {
                                          showCustomSnackBar(
                                              "4 digits code could not be verified",
                                              isError: false,
                                              title: "OTP Failed");
                                        }
                                      });
                                    } else {
                                      showCustomSnackBar(
                                          "Please enter required 4 digits code",
                                          isError: true,
                                          title: "OTP Required");
                                    }
                                  },
                                  style: ButtonStyle(
                                    foregroundColor:
                                        MaterialStateProperty.all<Color>(
                                            AppColor.subTitle),
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                      Theme.of(context).colorScheme.secondary,
                                    ),
                                    shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(24.0),
                                      ),
                                    ),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.all(14.0),
                                    child: Text(
                                      'Verify',
                                      style: TextStyle(
                                          fontSize: 16, color: Colors.white),
                                    ),
                                  ),
                                ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 18,
                  ),
                  // Text(
                  //   "Didn't you receive any code?",
                  //   style: TextStyle(
                  //     fontSize: 14,
                  //     fontWeight: FontWeight.bold,
                  //     color: Colors.black38,
                  //   ),
                  //   textAlign: TextAlign.center,
                  // ),
                  // SizedBox(
                  //   height: 18,
                  // ),
                  // InkWell(
                  //   onTap: () {
                  //     if (!_canResend) {
                  //       showCustomSnackBar("You can resend in $_start ",
                  //           title: "OTP timer still on");
                  //       return;
                  //     }
                  //     var phone = auth.phone;
                  //     // auth.loginWithCode(phone).then((value) {
                  //     //   if (value.isSuccess) {
                  //     //     startTimer();
                  //     //     showCustomSnackBar(
                  //     //         "SMS containing 4 digits code has been sent to you",
                  //     //         isError: false,
                  //     //         title: "OTP Sent");
                  //     //   } else {
                  //     //     showCustomSnackBar("OTP could not be sent",
                  //     //         isError: true, title: "OTP Failed");
                  //     //   }
                  //     // });
                  //   },
                  //   child: RichText(
                  //     text: TextSpan(
                  //       style: TextStyle(color: Colors.black, fontSize: 14.sp),
                  //       children: <TextSpan>[
                  //         TextSpan(
                  //           text: 'Did not receive OTP? ',
                  //         ),
                  //         TextSpan(
                  //           text: 'Resend',
                  //           style: TextStyle(
                  //             decoration: TextDecoration.underline,
                  //             color: Colors.blue,
                  //           ),
                  //         ),
                  //       ],
                  //     ),
                  //   ),
                  // ),
                  // _start > 0
                  //     ? Column(
                  //         children: [
                  //           SizedBox(
                  //             height: 15.h,
                  //           ),
                  //           Text(
                  //             " resend in $_start seconds",
                  //             style: TextStyle(
                  //               color: Colors.green.shade600,
                  //             ),
                  //           )
                  //         ],
                  //       )
                  //     : Container(),
                  // SizedBox(
                  //   height: 25.h,
                  // ),
                  // InkWell(
                  //   onTap: () {
                  //     //  Get.offNamed(RouteHelpers.otpWelcome);
                  //   },
                  //   child: MainText(
                  //     text: 'Change phone number',
                  //     color: Colors.blue,
                  //   ),
                  // )
                ],
              ),
            ),
          ),
        ),
      );
    });
  }

  Widget _textFieldOTP({required bool first, last, controller}) {
    return Container(
      height: 85,
      child: AspectRatio(
        aspectRatio: 0.7,
        child: TextField(
          autofocus: true,
          onChanged: (value) {
            if (value.length == 1 && last == false) {
              FocusScope.of(context).nextFocus();
            }
            if (value.length == 0 && first == false) {
              FocusScope.of(context).previousFocus();
            }
          },
          showCursor: false,
          readOnly: false,
          controller: controller,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          keyboardType: TextInputType.number,
          maxLength: 1,
          decoration: InputDecoration(
            counter: Offstage(),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(width: 2, color: Colors.black12),
                borderRadius: BorderRadius.circular(12)),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(width: 2, color: AppColor.iconColor),
                borderRadius: BorderRadius.circular(12)),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }
}
