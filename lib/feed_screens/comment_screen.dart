import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:rosary/route/route_helpers.dart';
import 'package:rosary/utils/show_custom_snackbar.dart';
import 'package:rosary/widgets/main_app_bar_widget.dart';
import 'package:rosary/widgets/main_text.dart';
import 'package:rosary/widgets/small_avatar.dart';
import '../controllers/auth_controller.dart';
import '../controllers/feedComment_controller.dart';
import '../controllers/user_controller.dart';
import '../utils/appColor.dart';
import '../utils/constants.dart';
import '../widgets/chat_text_field.dart';
import '../widgets/name_widget.dart';

class FeedCommentScreen extends StatefulWidget {
  FeedCommentScreen({super.key});

  @override
  State<FeedCommentScreen> createState() => _FeedCommentScreenState();
}

class _FeedCommentScreenState extends State<FeedCommentScreen> {
  var _commentController = Get.find<FeedCommentController>();
  var _authController = Get.find<AuthController>();
  var textController = TextEditingController();
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  bool canShowButton = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _commentController.getCommentList(_commentController.currentFeedId);
    textController.addListener(_callUpdate);
  }

  void _callUpdate() {
    if (textController.text.length > 0) {
      setState(() {
        canShowButton = true;
      });
    } else {
      setState(() {
        canShowButton = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<FeedCommentController>(builder: (comment) {
      return Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: MainAppBarWidget(text: "Comment"),
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            comment.isLoaded
                ? comment.commentList.length > 0
                    ? SmartRefresher(
                        enablePullUp: true,
                        header: WaterDropHeader(),
                        controller: _refreshController,
                        onRefresh: () async {
                          comment.getCommentList(comment.currentFeedId);
                          await Future.delayed(
                            Duration(seconds: 0, milliseconds: 2000),
                          );
                          if (comment.isLoaded)
                            _refreshController.refreshCompleted();
                          else
                            _refreshController.refreshFailed();
                        },
                        onLoading: () async {
                          comment.loadMore(comment.currentFeedId);

                          // _shopController.setOffset(offset);
                          // _shopController.getRestaurantLoadMoreList(
                          //   offset,
                          //   limit,
                          //   search,
                          //   category,
                          // );
                          await Future.delayed(
                            Duration(seconds: 0, milliseconds: 2000),
                          );
                          if (comment.isMoreLoaded)
                            _refreshController.loadComplete();
                          else
                            _refreshController.loadFailed();
                        },
                        child: SingleChildScrollView(
                          child: Container(
                            child: Column(
                              children: [
                                GetBuilder<FeedCommentController>(
                                  builder: (comment) {
                                    return ListView.builder(
                                      physics: const BouncingScrollPhysics(),
                                      // the number of items in the list
                                      itemCount: comment.commentList.length,
                                      shrinkWrap: true,
                                      // display each item of the product list
                                      itemBuilder: (context, index) {
                                        var item = comment.commentList[index];
                                        return GestureDetector(
                                          onLongPress: () async {
                                            var userId = await _authController
                                                .getUserId();
                                            if (userId == item.author!.id) {
                                              comment.setCommentId(item.id);
                                              comment.setEditingContent(
                                                  item.content!);
                                              showModalPopup(context);
                                            }
                                          },
                                          child: Container(
                                            color: Colors.white,
                                            margin: EdgeInsets.only(top: 20.h),
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Padding(
                                                  padding: EdgeInsets.all(4.sp),
                                                  child: SmallAvatarWidget(
                                                      avatar:
                                                          item.author!.avatar),
                                                ),
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    NameWidget(
                                                      size: 15.sp,
                                                      firstname: item
                                                          .author!.firstname!,
                                                      lastname: item
                                                          .author!.lastname!,
                                                      profileId:
                                                          item.author!.id!,
                                                    ),
                                                    MainText(
                                                      text: item.content!,
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                    );
                                  },
                                )
                              ],
                            ),
                          ),
                        ),
                      )
                    : Container(
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Center(
                                  child: Column(
                                children: [
                                  Icon(
                                    Icons.chat_outlined,
                                    color: AppColor.iconColor,
                                    size: 50.sp,
                                  ),
                                  MainText(
                                    text: "No comment yet",
                                    size: 18.sp,
                                    color: AppColor.iconColor,
                                  )
                                ],
                              ))
                            ]),
                      )
                : const Center(child: CircularProgressIndicator()),
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                padding: EdgeInsets.only(bottom: 10.h, right: 15.w),
                child: Row(
                  children: [
                    Expanded(
                      child: _authController.userLoggedIn()
                          ? ChatTextField(
                              hasPadding: true,
                              textController: textController,
                              hintText: "Type your comment",
                            )
                          : Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    padding:
                                        EdgeInsets.symmetric(vertical: 10.w),
                                    backgroundColor: AppColor.primaryColor,
                                  ),
                                  onPressed: () {
                                    Get.toNamed(RouteHelpers.signInPage);
                                  },
                                  child: MainText(
                                    color: Colors.white,
                                    text: "cancel",
                                    size: 20.sp,
                                  )),
                            ),
                    ),
                    canShowButton
                        ? comment.isLoaded
                            ? InkWell(
                                onTap: () {
                                  comment
                                      .postComment(comment.currentFeedId,
                                          textController.text)
                                      .then((value) {
                                    if (value.isSuccess) {
                                      textController.clear();
                                    }
                                  });
                                },
                                child: Icon(
                                  Icons.send,
                                  size: 30.sp,
                                  color: AppColor.primaryColor,
                                ),
                              )
                            : CircularProgressIndicator()
                        : Text("")
                  ],
                ),
              ),
            )
          ],
        ),
      );
    });
  }

  showModalPopup(BuildContext context) async {
    if (Platform.isIOS) {
      return showCupertinoModalPopup(
        context: context,
        builder: (context) => CupertinoActionSheet(
            actions: [
              CupertinoActionSheetAction(
                onPressed: () {
                  Navigator.pop(context, 'Cancel');
                  Get.toNamed(RouteHelpers.commentEdittPage);
                  // Navigator.of(context).pop(ImageSource.camera);
                },
                child: Center(
                  child: MainText(
                    text: 'Edit',
                    size: 16.sp,
                  ),
                ),
              ),
              CupertinoActionSheetAction(
                onPressed: () {
                  Navigator.pop(context, 'Cancel');
                  _commentController.deleteComment().then((value) {
                    if (value.isSuccess) {
                      showCustomSnackBar("Deleted successfully");
                    } else {
                      showCustomSnackBar("Was not deleted successfully");
                    }
                  });

                  // Navigator.of(context).pop(ImageSource.gallery);
                },
                child: Center(
                  child: MainText(
                    color: Colors.red,
                    text: 'Delete',
                    size: 16.sp,
                  ),
                ),
              ),
            ],
            cancelButton: CupertinoActionSheetAction(
              child: MainText(
                text: 'Cancel',
                size: 16.sp,
              ),
              isDefaultAction: true,
              onPressed: () {
                Navigator.pop(context, 'Cancel');
              },
            )),
      );
    } else {
      return showModalBottomSheet(
        context: context,
        builder: (context) => Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            InkWell(
              onTap: () {
                Navigator.pop(context, 'Cancel');
                Get.toNamed(RouteHelpers.commentEdittPage);
              },
              child: ListTile(
                title: MainText(
                  text: 'Edit',
                  size: 16.sp,
                ),
                onTap: () {
                  Navigator.pop(context, 'Cancel');
                  _commentController.deleteComment().then((value) {
                    if (value.isSuccess) {
                      showCustomSnackBar("Deleted successfully");
                    } else {
                      showCustomSnackBar("Was not deleted successfully");
                    }
                  });
                },
              ),
            ),
            ListTile(
              title: MainText(
                text: 'Delete',
                color: Colors.red,
                size: 16.sp,
              ),
              onTap: () => null,
            ),
            Divider(),
            ListTile(
                title: MainText(
                  text: 'Cancel',
                  size: 16.sp,
                ),
                onTap: () =>
                    null //Navigator.of(context).pop(ImageSource.gallery),
                ),
          ],
        ),
      );
    }
  }
}
