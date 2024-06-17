import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:rosary/controllers/chaplet_template_controller.dart';
import 'package:rosary/utils/constants.dart';
import 'package:rosary/widgets/big_text.dart';
import 'package:rosary/widgets/main_text.dart';

class TemplateSelectionScreen extends StatelessWidget {
  const TemplateSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ChapletController>(builder: (template) {
      return Scaffold(
        appBar: AppBar(
          title: BigText(
            text: "rosary_theme".tr,
            size: 18.sp,
            color: Colors.white,
          ),
          backgroundColor: Theme.of(context).colorScheme.secondary,
          automaticallyImplyLeading: false,
          leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            ),
          ),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                Container(
                  height: 50.h,
                ),
                InkWell(
                  onTap: () async {
                    await template
                        .setTemplate(AppConstant.CHAPLET_TEMPLATE_ONE);

                    // ignore: use_build_context_synchronously
                    Navigator.pop(context);
                  },
                  child: Container(
                    padding: const EdgeInsets.all(2),
                    margin: EdgeInsets.all(10.r),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.sp),
                        color: template.templateType ==
                                AppConstant.CHAPLET_TEMPLATE_ONE
                            ? Colors.grey.shade400
                            : Colors.white),
                    width: double.maxFinite,
                    height: 150.h,
                    child: Column(
                      children: [
                        MainText(text: "Sacred Harmony", size: 18.sp),
                        Image.asset(
                          "assets/images/style1.png",
                          height: 100.h,
                          width: double.maxFinite,
                          fit: BoxFit.contain,
                        )
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: () async {
                    await template
                        .setTemplate(AppConstant.CHAPLET_TEMPLATE_TWO);
                    Navigator.pop(context);
                  },
                  child: Container(
                    padding: const EdgeInsets.all(2),
                    margin: EdgeInsets.all(10.r),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.sp),
                      color: template.templateType ==
                              AppConstant.CHAPLET_TEMPLATE_TWO
                          ? Colors.grey.shade400
                          : Colors.white,
                    ),
                    width: double.maxFinite,
                    height: 150.h,
                    child: Column(
                      children: [
                        MainText(text: "Heavenly Radiance", size: 18.sp),
                        Image.asset(
                          "assets/images/style2.png",
                          height: 100.h,
                          fit: BoxFit.contain,
                          width: double.maxFinite,
                        )
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: () async {
                    await template
                        .setTemplate(AppConstant.CHAPLET_TEMPLATE_THREE);
                    Navigator.pop(context);
                  },
                  child: Container(
                    padding: const EdgeInsets.all(2),
                    margin: EdgeInsets.all(10.r),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.sp),
                      color: template.templateType ==
                              AppConstant.CHAPLET_TEMPLATE_THREE
                          ? Colors.grey.shade400
                          : Colors.white,
                    ),
                    width: double.maxFinite,
                    height: 150.h,
                    child: Column(
                      children: [
                        MainText(
                          text: "Divine Serenity",
                          size: 18.sp,
                        ),
                        Image.asset(
                          "assets/images/style3.png",
                          height: 100.h,
                          width: double.maxFinite,
                          fit: BoxFit.contain,
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      );
    });
  }
}
