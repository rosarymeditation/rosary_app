import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:rosary/controllers/auth_controller.dart';
import 'package:rosary/model/currency_model.dart';
import 'package:rosary/route/route_helpers.dart';
import 'package:rosary/utils/appColor.dart';
import 'package:rosary/utils/constants.dart';
import 'package:rosary/utils/dimensions.dart';
import 'package:rosary/utils/show_custom_snackbar.dart';
import 'package:rosary/widgets/main_text.dart';

import '../controllers/payment_controller.dart';

class DonationScreen extends StatefulWidget {
  DonationScreen({super.key});

  @override
  State<DonationScreen> createState() => _DonationScreenState();
}

class _DonationScreenState extends State<DonationScreen> {
  var _paymentController = Get.find<PaymentController>();

  var _authController = Get.find<AuthController>();
  var amountController = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _paymentController.getCurrencyList();
  }

  String _selectedValue = "USD";
  @override
  Widget build(BuildContext context) {
    return GetBuilder<PaymentController>(
      builder: (payment) {
        return Scaffold(
          backgroundColor: Theme.of(context).colorScheme.background,
          floatingActionButtonLocation:
              FloatingActionButtonLocation.miniCenterFloat,
          appBar: AppBar(
            title: MainText(
              text: "donate",
              size: 18.sp,
            ),
            automaticallyImplyLeading: false,
            leading: InkWell(
                onTap: () {
                  Get.toNamed(RouteHelpers.home);
                  _authController.setCurrentIndex(2);
                },
                child: Icon(Icons.arrow_back_ios)),
          ),
          body: Stack(
            children: [
              SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 20.sp),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(
                          height: 50.h,
                        ),
                        Html(
                          data: "donate_body".tr,
                          style: {
                            'p': Style(
                                fontSize: FontSize(18.sp),
                                fontFamily: "Georgian"),
                          },
                        ),
                        SizedBox(
                          height: 80.h,
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                left: 10.w,
                right: 10.w,
                child: Container(
                  color: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: SingleChildScrollView(
                      child: Column(
                    children: [
                      Container(
                        color: Colors.grey.shade200,
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          children: [
                            // DropdownButton<String>(
                            //   value: _selectedValue,
                            //   onChanged: (String? newValue) {
                            //     setState(() {
                            //       _selectedValue = newValue!;
                            //     });
                            //   },
                            //   items: _paymentController.currencyList
                            //       .map<DropdownMenuItem<String>>(
                            //           (CurrencyModel value) {
                            //     return DropdownMenuItem<String>(
                            //       value: value.code,
                            //       child: MainText(
                            //         text: value.code!,
                            //         size: 18.sp,
                            //       ),
                            //     );
                            //   }).toList(),
                            //   elevation: 0,
                            // ),
                            MainText(
                              text: "USD",
                              size: 18,
                              isBold: true,
                            ),
                            SizedBox(
                              width: 20.w,
                            ),
                            SizedBox(
                              width: Dimensions.screenWidth * 0.4,
                              child: TextField(
                                controller: amountController,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16.sp,
                                ),
                                keyboardType: TextInputType.numberWithOptions(
                                    decimal: true),
                                inputFormatters: <TextInputFormatter>[
                                  FilteringTextInputFormatter.digitsOnly
                                ],
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "0.00",
                                  hintStyle: TextStyle(fontSize: 20.sp),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Image.asset(
                          AppConstant.getImagePath("secure_payment.png"))
                    ],
                  )),
                ),
              ),
            ],
          ),
          bottomNavigationBar: Container(
            height: Dimensions.screenHeight * 0.26,
            padding: EdgeInsets.symmetric(vertical: 20),
            child: payment.isLoaded
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 10.h,
                      ),
                      InkWell(
                        onTap: () {
                          print(_selectedValue);
                          if (amountController.text == "") {
                            showCustomSnackBar("donation_amount_error".tr,
                                title: "retry".tr,
                                backColor: AppColor.primaryColor);
                            return;
                          }

                          var amount = amountController.text;
                          var amountNum = double.parse(amountController.text);
                          if (amount.isEmpty) {
                            showCustomSnackBar("donation_amount_limit".tr,
                                title: "donation_amount_error".tr,
                                backColor: Colors.orange.shade500);
                            return;
                          } else if (amountNum <= 0) {
                            showCustomSnackBar("donation_amount_limit".tr,
                                title: "donation_amount_error".tr,
                                backColor: Colors.orange.shade500);
                            return;
                          }

                          if (amount.isNum && amount.isNotEmpty) {
                            _paymentController
                                .stripePayment(amount)
                                .then((value) {
                              if (value.isSuccess) {
                                Get.toNamed(RouteHelpers.donationDisplayPage);
                                print("Suceess");
                              }
                            });
                          } else {
                            print("Validation error");
                          }
                        },
                        child: Container(
                          margin: EdgeInsets.symmetric(horizontal: 20),
                          width: double
                              .maxFinite, // Set the width of the container
                          height: 60.h, // Set the height of the container
                          decoration: BoxDecoration(
                              color: AppColor.primaryColor,
                              borderRadius: BorderRadius.circular(20.sp)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              MainText(
                                text: "donate",
                                size: 17.sp,
                                isBold: true,
                                color: Colors.white,
                              ),
                              SizedBox(
                                width: 10.w,
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      InkWell(
                        onTap: () {
                          Clipboard.setData(const ClipboardData(
                              text: AppConstant.PAYPAL_LINK));

                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              backgroundColor: Colors.green,
                              content: MainText(
                                color: Colors.white,
                                text: "copy_text",
                              ),
                              duration: Duration(seconds: 3),
                            ),
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.copy),
                              SizedBox(
                                width: 10.w,
                              ),
                              Flexible(
                                child: MainText(
                                  size: 16.sp,
                                  color: Colors.green,
                                  text: "copy_paypal_link",
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  )
                : Center(child: CircularProgressIndicator()),
          ),
          // floatingActionButton: FloatingActionButton.extended(
          //   onPressed: () {

          //   },
          //   icon: Icon(Icons.copy),
          //   label: Text("Copy PayPal link"),
          // ),
        );
      },
    );
  }
}
