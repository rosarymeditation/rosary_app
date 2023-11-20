import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:quickalert/quickalert.dart';
import 'package:rosary/utils/appColor.dart';
import 'package:rosary/utils/constants.dart';
import 'package:rosary/widgets/main_app_bar_widget.dart';

import '../controllers/langauge_controller.dart';

class LanguageScreen extends StatelessWidget {
  const LanguageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LocalizationController>(
      builder: (_languageController) {
        return Scaffold(
          backgroundColor: Theme.of(context).colorScheme.background,
          appBar: MainAppBarWidget(text: "select_language"),
          body: SafeArea(
              child: Column(
            children: [
              SizedBox(
                height: 50.h,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w),
                child: ListView.builder(
                    itemCount: AppConstant.languages.length,
                    shrinkWrap: true,
                    itemBuilder: (BuildContext context, int index) {
                      return InkWell(
                        onTap: () {
                          if (AppConstant.languages[index].languageCode ==
                              "es") {
                            QuickAlert.show(
                              backgroundColor:
                                  Theme.of(context).colorScheme.background,
                              confirmBtnText: "ok".tr,
                              context: context,
                              type: QuickAlertType.info,
                              text:
                                  'Hemos traducido con éxito todas nuestras oraciones al español. Ahora estamos trabajando en hacer lo mismo para el resto de nuestra aplicación.'
                                      .tr,
                            );
                          }
                          print(AppConstant.languages[index].languageName);
                          _languageController.setLanguage(
                            Locale(AppConstant.languages[index].languageCode,
                                AppConstant.languages[index].countryCode),
                          );
                          _languageController.setSelectedIndex(index);
                        },
                        child: Container(
                          padding: EdgeInsets.only(
                            bottom: 10.h,
                          ),
                          child: ListTile(
                            leading: CircleAvatar(
                                radius: 20.sp,
                                backgroundImage: AssetImage(
                                    "assets/flags/${AppConstant.languages[index].imageUrl}") //Text
                                ),
                            trailing: _languageController.selectedIndex == index
                                ? const Icon(
                                    Icons.check_circle_rounded,
                                    color: Colors.green,
                                  )
                                : Text(""),
                            title: Text(
                              AppConstant.languages[index].languageName,
                              style: TextStyle(
                                  color: AppColor.subTitle, fontSize: 18.sp),
                            ),
                          ),
                        ),
                      );
                    }),
              )
            ],
          )),
        );
      },
    );
  }
}
