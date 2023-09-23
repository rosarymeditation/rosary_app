import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:rosary/utils/constants.dart';

import '../controllers/main_controller.dart';
import '../model/mystery_model.dart';
import '../utils/appColor.dart';
import 'main_text.dart';

class SelectWidget extends StatelessWidget {
  MysteryModel item;
  SelectWidget({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MainController>(
      builder: (main) {
        var hasSelected = main.currentMystery == item.name;

        return Container(
          margin: EdgeInsets.symmetric(vertical: 10.h),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.sp),
            color: hasSelected ? AppColor.primaryColor : Colors.grey,
          ),
          height: 120.h,
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 10.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 2.w,
                  ),
                  CircleAvatar(
                    radius: 40,
                    backgroundImage:
                        AssetImage(AppConstant.getImagePath(item.img)),
                  ),
                  Row(
                    children: [
                      MainText(
                        text: item.name.tr,
                        color: Colors.white,
                        isBold: true,
                        size: 18.sp,
                      ),
                      SizedBox(
                        width: 10.w,
                      ),
                      Icon(
                        hasSelected
                            ? Icons.check_circle
                            : Icons.radio_button_off,
                        color: Colors.white,
                        size: 20.sp,
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 15.w,
                  ),
                ],
              ),
              MainText(
                text: item.days,
                color: Colors.white,
              )
            ],
          ),
        );
      },
    );
  }
}
