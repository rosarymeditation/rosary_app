import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:rosary/route/route_helpers.dart';
import 'package:rosary/widgets/main_text.dart';

import '../controllers/user_controller.dart';

class NameWidget extends StatelessWidget {
  double size;
  String firstname;
  String lastname;
  String profileId;
  Color color;
  bool hasLink;
  NameWidget(
      {super.key,
      this.size = 16,
      required this.firstname,
      this.hasLink = true,
      required this.lastname,
      required this.profileId,
      this.color = Colors.black});
  var _userController = Get.find<UserController>();
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        if (hasLink) {
          _userController.getProfileData(profileId).then((value) {
            if (value.isSuccess) {
              Get.toNamed(RouteHelpers.profilePage);
            }
          });
          _userController.setUserProfileId(profileId);
        }
      },
      child: MainText(
        isBold: true,
        color: color,
        text: "${firstname} ${lastname}",
        size: size,
      ),
    );
  }
}
