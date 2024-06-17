import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:quickalert/quickalert.dart';
import 'package:rosary/controllers/auth_controller.dart';
import 'package:rosary/model/feed_model.dart';
import 'package:rosary/model/public_prayer_request_model.dart';
import 'package:rosary/utils/show_custom_snackbar.dart';
import 'package:rosary/widgets/feed_image_widget.dart';
import 'package:rosary/widgets/name_widget.dart';
import 'package:rosary/widgets/small_avatar.dart';
import 'package:rosary/widgets/status_widget.dart';

import '../controllers/feedComment_controller.dart';
import '../controllers/feed_controller.dart';
import '../controllers/prayer_request_controller.dart';
import '../route/route_helpers.dart';
import '../utils/appColor.dart';
import '../utils/constants.dart';
import '../utils/dimensions.dart';
import 'expandable_text_widget.dart';
import 'main_text.dart';

class PrayerRequestItemWidget extends StatelessWidget {
  final String token;
  PublicPrayerRequestModel item;
  PrayerRequestItemWidget({super.key, required this.item, required this.token});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PrayerRequestController>(
      builder: (_prayer) {
        return Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.tertiary,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5), // Shadow color and opacity
                spreadRadius: 1, // Spread radius
                blurRadius: 3, // Blur radius
                offset: Offset(0, 1), // Offset of the shadow
              ),
            ],
          ),
          margin: EdgeInsets.only(top: 20.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 10.sp,
                      backgroundImage: AssetImage(
                          AppConstant.getImagePath("praying_icon.png")),
                    ),
                    SizedBox(
                      width: 10.w,
                    ),
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          MainText(
                            color: Theme.of(context).colorScheme.inversePrimary,
                            size: 14.sp,
                            align: TextAlign.left,
                            text: item.content!,
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 10.h),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Flexible(
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Flexible(
                                        child: Text(
                                          "${item.name},",
                                          style: TextStyle(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .inversePrimary,
                                            fontSize: 13.sp,
                                            fontStyle: FontStyle.italic,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 5.w,
                                      ),
                                      Text(
                                        AppConstant.formatTimeAgo(
                                            item.createdAt!),
                                        style: TextStyle(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .inversePrimary,
                                          fontSize: 13.sp,
                                          fontStyle: FontStyle.italic,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        _prayer
                                            .assistPrayer(item.id!, token)
                                            .then((value) {
                                          if (value.isSuccess) {
                                            // showCustomSnackBar("OK");
                                          } else {
                                            // showCustomSnackBar("Not OK");
                                          }
                                        });
                                      },
                                      child: Container(
                                        padding: EdgeInsets.all(5.r),
                                        decoration: BoxDecoration(
                                            color: Colors.grey.shade200,
                                            borderRadius:
                                                BorderRadius.circular(20.r)),
                                        child: Row(
                                          children: [
                                            CircleAvatar(
                                              backgroundColor:
                                                  Colors.grey.shade200,
                                              radius: 10.r,
                                              backgroundImage: const AssetImage(
                                                  "assets/images/prayer_pray.png"),
                                            ),
                                            SizedBox(
                                              width: 2.w,
                                            ),
                                            MainText(text: "pray".tr)
                                          ],
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10.h,
                                    ),
                                    Row(
                                      children: [
                                        SizedBox(
                                          width: 2.w,
                                        ),
                                        item.counter!.isNotEmpty
                                            ? MainText(
                                                text: "prayer".tr +
                                                    ": ${item.counter?.length ?? 1}x")
                                            : SizedBox(
                                                width: 60.w,
                                              )
                                      ],
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
