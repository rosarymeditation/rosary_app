import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:quickalert/quickalert.dart';
import 'package:rosary/controllers/auth_controller.dart';
import 'package:rosary/model/feed_model.dart';
import 'package:rosary/widgets/feed_image_widget.dart';
import 'package:rosary/widgets/name_widget.dart';
import 'package:rosary/widgets/small_avatar.dart';
import 'package:rosary/widgets/status_widget.dart';

import '../controllers/feedComment_controller.dart';
import '../controllers/feed_controller.dart';
import '../route/route_helpers.dart';
import '../utils/appColor.dart';
import '../utils/constants.dart';
import '../utils/dimensions.dart';
import 'expandable_text_widget.dart';
import 'main_text.dart';

class FeedItemWidget extends StatelessWidget {
  FeedModel item;
  bool isForProfile;
  FeedItemWidget({super.key, required this.item, this.isForProfile = false});
  var _commentController = Get.find<FeedCommentController>();
  var _feedController = Get.find<FeedController>();
  var _authController = Get.find<AuthController>();
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      margin: EdgeInsets.only(top: 20.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    SmallAvatarWidget(avatar: item.author!.avatar),
                    SizedBox(
                      width: 5.w,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        NameWidget(
                          size: 15.sp,
                          firstname: item.author!.firstname!,
                          lastname: item.author!.lastname!,
                          profileId: item.author!.id!,
                        ),
                        Row(
                          children: [
                            MainText(
                              text: AppConstant.formatTimeAgo(item.createdAt!),
                            ),
                            SizedBox(
                              width: 20.w,
                            ),
                            isForProfile
                                ? StatusWidget(status: item.status)
                                : Text("")
                          ],
                        )
                      ],
                    ),
                  ],
                ),
                _authController.currentUserId == item.author!.id &&
                        _authController.userLoggedIn()
                    ? InkWell(
                        onTap: () {
                          showPopUp(context, item);
                        },
                        child: const Icon(Icons.more_vert_outlined))
                    : const Text("")
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
            child: ExpandableTextWidget(
              text: item.content!,
            ),
          ),
          FeedImageWidget(url: item.url),
          const Divider(),
          Container(
            padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () {
                    _authController.userLoggedIn()
                        ? _feedController.like(item.id!)
                        : QuickAlert.show(
                            context: context,
                            title: "sign-in_to_react".tr,
                            confirmBtnText: "sign_in".tr,
                            cancelBtnText: "cancel".tr,
                            onConfirmBtnTap: () {
                              Get.offAllNamed(RouteHelpers.signInPage);
                            },
                            type: QuickAlertType.confirm,
                            text: 'sign-in_content'.tr,
                          );
                    ;
                  },
                  child: Row(
                    children: [
                      Icon(
                        Icons.favorite_border_outlined,
                        color: AppColor.iconColor,
                      ),
                      item.likes!.isNotEmpty
                          ? MainText(text: item.likes!.length.toString())
                          : Text(""),
                      SizedBox(
                        width: 2.w,
                      ),
                      MainText(
                        text: 'Love',
                        color: AppColor.iconColor,
                      )
                    ],
                  ),
                ),
                InkWell(
                  onTap: () {
                    _commentController.setFeedId(item.id);
                    _commentController.getCommentList(item.id!);
                    Get.toNamed(RouteHelpers.feedCommentScreenPage);
                  },
                  child: Row(
                    children: [
                      Icon(
                        Icons.comment_outlined,
                        color: AppColor.iconColor,
                      ),
                      SizedBox(
                        width: 2.w,
                      ),
                      MainText(
                        text: 'Comment',
                        color: AppColor.iconColor,
                      ),
                      SizedBox(
                        width: 2.w,
                      ),
                      MainText(
                        text: item.comments!.isEmpty
                            ? ""
                            : item.comments!.length.toString(),
                        color: AppColor.iconColor,
                      ),
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  showPopUp(BuildContext context, FeedModel feed) async {
    if (Platform.isIOS) {
      return showCupertinoModalPopup(
        context: context,
        builder: (context) => CupertinoActionSheet(
          actions: [
            CupertinoActionSheetAction(
                onPressed: () {
                  _feedController.setEditingContent(feed);
                  Navigator.of(context).pop();
                  Get.toNamed(RouteHelpers.feedEdittPage);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.edit,
                      color: AppColor.primaryColor,
                    ),
                    SizedBox(
                      width: 10.w,
                    ),
                    MainText(
                      text: 'Edit',
                    ),
                  ],
                )),
            CupertinoActionSheetAction(
              onPressed: () {
                _feedController.deleteFeed(feed.id!).then((result) {
                  if (result.isSuccess) {
                    print("Delete successfully");
                  } else {
                    print("Not Delete");
                  }
                });
                Navigator.of(context).pop();
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Icon(
                    Icons.delete,
                    color: Colors.red,
                  ),
                  SizedBox(
                    width: 10.w,
                  ),
                  MainText(
                    text: 'Delete',
                  ),
                ],
              ),
            )
          ],
        ),
      );
    } else {
      return showModalBottomSheet(
        context: context,
        builder: (context) => Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            InkWell(
              onTap: () {
                _feedController.setEditingContent(feed);
                Navigator.of(context).pop();
                Get.toNamed(RouteHelpers.feedEdittPage);
              },
              child: ListTile(
                  leading: const Icon(Icons.edit),
                  title: const Text('Edit'),
                  onTap: () {
                    Navigator.of(context).pop();
                  }),
            ),
            InkWell(
              onTap: () {
                _feedController.deleteFeed(feed.id!).then((result) {
                  if (result.isSuccess) {
                    print("Delete successfully");
                  } else {
                    print("Not Delete");
                  }
                });
                Navigator.of(context).pop();
              },
              child: ListTile(
                leading: const Icon(Icons.delete),
                title: const Text('Delete'),
                onTap: () => Navigator.of(context).pop(),
              ),
            )
          ],
        ),
      );
    }
  }
}
