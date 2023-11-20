import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:rosary/route/route_helpers.dart';
import 'package:rosary/utils/constants.dart';
import 'package:rosary/utils/dimensions.dart';
import 'package:rosary/widgets/avatar_widget.dart';
import 'package:rosary/widgets/banner_widget.dart';
import 'package:rosary/widgets/main_app_bar_widget.dart';
import 'package:rosary/widgets/main_text.dart';
import 'package:rosary/widgets/name_widget.dart';

import '../controllers/auth_controller.dart';
import '../controllers/user_controller.dart';
import '../utils/appColor.dart';
import '../widgets/expandable_text_widget.dart';

class ProfileScreen extends StatefulWidget {
  ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  var _userController = Get.find<UserController>();
  var _authController = Get.find<AuthController>();
  String currentuserId = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: MainAppBarWidget(text: ""),
      body: GetBuilder<UserController>(
        builder: (user) {
          return CustomScrollView(
            slivers: [
              SliverAppBar(
                automaticallyImplyLeading: false,
                expandedHeight: 200.0, // Max height when fully expanded
                floating: true, // Doesn't float above content
                pinned: true,
                backgroundColor:
                    AppColor.primaryColor, // Stays pinned to the top
                flexibleSpace: FlexibleSpaceBar(
                  title: NameWidget(
                    color: Colors.white,
                    firstname: user.userModel.firstname!,
                    lastname: user.userModel.lastname!,
                    profileId: "",
                    hasLink: false,
                    size: 15.sp,
                  ),
                  background: Stack(
                    alignment: Alignment.center,
                    children: [
                      Positioned(
                          top: 0,
                          left: 0,
                          right: 0,
                          bottom: 0,
                          child:
                              BannerWidget(bannerUrl: user.userModel.banner)),
                      Positioned(
                        top: 30.h,
                        child: AvatarWidget(
                          avatarUrl: user.userModel.avatar,
                          size: 120.sp,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    // Build your news article content here
                    return Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 15.w, vertical: 20.h),
                          child: ExpandableTextWidget(
                              text: user.userModel.bio ?? ""),
                        ),
                        _authController.currentUserId == user.userModel.id
                            ? ElevatedButton(
                                onPressed: () {
                                  Get.toNamed(RouteHelpers.editProfilePage);
                                },
                                child: Text("Edit Profile"),
                              )
                            : Text("")
                      ],
                    );
                  },
                  childCount: 1, // Number of news articles
                ),
              ),
            ],
          );
          // Stack(
          //   alignment: Alignment.center,
          //   children: [
          //     Positioned(
          //       top: 0,
          //       left: 0,
          //       right: 0,
          //       child: BannerWidget(bannerUrl: user.userModel.banner),
          //     ),
          //     Positioned(
          //       top: Dimensions.screenHeight * 0.1,
          //       bottom: 0,
          //       left: 0,
          //       right: 0,
          //       child: Column(
          //         children: [
          //           AvatarWidget(
          //             avatarUrl: user.userModel.avatar,
          //             size: 120.sp,
          //           ),
          //           SizedBox(
          //             height: 20.h,
          //           ),
          //           NameWidget(
          //             firstname: user.userModel.firstname!,
          //             lastname: user.userModel.lastname!,
          //             profileId: "",
          //             hasLink: false,
          //             size: 20.sp,
          //           ),
          //           SizedBox(
          //             height: 10.h,
          //           ),
          //           user.userModel.bio != ""
          //               ? Padding(
          //                   padding: EdgeInsets.symmetric(horizontal: 15.w),
          //                   child: ExpandableTextWidget(
          //                       text: user.userModel.bio ?? ""),
          //                 )
          //               : Text(""),
          //           SizedBox(
          //             height: 20.h,
          //           ),
          //           _authController.currentUserId == user.userModel.id
          //               ? ElevatedButton(
          //                   onPressed: () {
          //                     Get.toNamed(RouteHelpers.editProfilePage);
          //                   },
          //                   child: Text("Edit Profile"),
          //                 )
          //               : Text("")
          //         ],
          //       ),
          //     ),
          //   ],
          // );
        },
      ),
    );
  }
}
