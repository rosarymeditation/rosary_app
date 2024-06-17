import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:rosary/controllers/chaplet_template_controller.dart';
import 'package:rosary/widgets/main_text.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';

import '../controllers/main_controller.dart';
import '../route/route_helpers.dart';
import '../utils/appColor.dart';
import 'big_text.dart';

class RosaryAppBarWidget extends StatefulWidget implements PreferredSizeWidget {
  final String text;
  const RosaryAppBarWidget({super.key, required this.text});

  @override
  State<RosaryAppBarWidget> createState() => _RosaryAppBarWidgetState();
  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

class _RosaryAppBarWidgetState extends State<RosaryAppBarWidget> {
  List<TargetFocus> targets = [];
  TutorialCoachMark? tutorialCoachMark;
  final _chapletController = Get.find<ChapletController>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Future.delayed(
        const Duration(
          seconds: 1,
        ), () {
      if (!_chapletController.getHasSeenSettings()) {
        _showTutorialCoachMark();
      }
    });
  }

  void loadCoachMark() {}

  void _showTutorialCoachMark() {
    _initTarget();
    tutorialCoachMark = TutorialCoachMark(targets: targets)
      ..show(context: context);
    _chapletController.setHasSeenSettings();
  }

  _initTarget() {
    targets = [
      TargetFocus(
        identify: "profile-key",
        keyTarget: settingsKey,
        contents: [
          TargetContent(
            align: ContentAlign.bottom,
            builder: (context, controller) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  MainText(
                    color: Colors.white,
                    size: 18.sp,
                    text: "select_rosary_theme".tr,
                  ),
                ],
              );
            },
          ),
        ],
      )
    ];
  }
  //late TutorialCoachMark tutorialCoachMark;

  GlobalKey settingsKey = GlobalKey();

  GlobalKey resetKey = GlobalKey();

  GlobalKey cancelKey = GlobalKey();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  final List<String> options = ['Restart', 'Select Template'];

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      leading: InkWell(
        onTap: () {
          Get.offAndToNamed(RouteHelpers.home);
        },
        child: Icon(
          key: cancelKey,
          Icons.close,
          color: Colors.white,
          size: 22.sp,
        ),
      ),
      centerTitle: true,
      title: BigText(
        align: TextAlign.center,
        text: widget.text.tr,
        color: Colors.white,
        size: 19.sp,
        isBold: true,
      ),
      backgroundColor: Theme.of(context).colorScheme.secondary,
      actions: <Widget>[
        IconButton(
          key: resetKey,
          icon: Icon(
            Icons.autorenew_sharp,
            size: 22.sp,
          ),
          onPressed: () {
            Get.toNamed(RouteHelpers.templatePage);
          },
        ),
        IconButton(
          key: settingsKey,
          icon: Icon(
            Icons.settings,
            size: 22.sp,
          ),
          onPressed: () {
            // Action for notifications button
            Get.toNamed(RouteHelpers.templatePage);
          },
        ),
      ],
    );
  }
}
// class RosaryAppBarWidget extends StatefulWidget implements PreferredSizeWidget {
//   final String text;

//   RosaryAppBarWidget({super.key, required this.text});

//   @override
//   State<RosaryAppBarWidget> createState() => _RosaryAppBarWidgetState();
  
//   @override
//   // TODO: implement preferredSize
//   //Size get preferredSize => throw UnimplementedError();

//   @override
//   // TODO: implement preferredSize
//   //Size get preferredSize => throw UnimplementedError();
// }

// class _RosaryAppBarWidgetState extends State<RosaryAppBarWidget> {
//   List<TargetFocus> targets = [];
//   TutorialCoachMark? tutorialCoachMark;
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();

//     Future.delayed(
//         Duration(
//           seconds: 1,
//         ), () {
//       _showTutorialCoachMark();
//     });
//   }

//   void _showTutorialCoachMark() {
//     _initTarget();
//     tutorialCoachMark = TutorialCoachMark(targets: targets)
//       ..show(context: context);
//   }

//   _initTarget() {
//     targets = [
//       TargetFocus(
//         identify: "profile-key",
//         keyTarget: cancelKey,
//         contents: [
//           TargetContent(
//             align: ContentAlign.bottom,
//             builder: (context, controller) {
//               return const Column(
//                 mainAxisSize: MainAxisSize.min,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: <Widget>[
//                   Text(
//                     "Click to end rosary",
//                     style: TextStyle(
//                       color: Colors.white,
//                     ),
//                   ),
//                 ],
//               );
//             },
//           ),
//         ],
//       ),
//       TargetFocus(
//         identify: "profile-key",
//         keyTarget: resetKey,
//         contents: [
//           TargetContent(
//             align: ContentAlign.bottom,
//             builder: (context, controller) {
//               return const Column(
//                 mainAxisSize: MainAxisSize.min,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: <Widget>[
//                   Text(
//                     "Click to restart rosary",
//                     style: TextStyle(
//                       color: Colors.white,
//                     ),
//                   ),
//                 ],
//               );
//             },
//           ),
//         ],
//       ),
//       TargetFocus(
//         identify: "profile-key",
//         keyTarget: settingsKey,
//         contents: [
//           TargetContent(
//             align: ContentAlign.bottom,
//             builder: (context, controller) {
//               return const Column(
//                 mainAxisSize: MainAxisSize.min,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: <Widget>[
//                   Text(
//                     "Click to select rosary theme",
//                     style: TextStyle(
//                       color: Colors.white,
//                     ),
//                   ),
//                 ],
//               );
//             },
//           ),
//         ],
//       )
//     ];
//   }
//   //late TutorialCoachMark tutorialCoachMark;

//   GlobalKey settingsKey = GlobalKey();

//   GlobalKey resetKey = GlobalKey();

//   GlobalKey cancelKey = GlobalKey();

//   @override
//   Size get preferredSize => const Size.fromHeight(kToolbarHeight);

//   final List<String> options = ['Restart', 'Select Template'];

//   @override
//   Widget build(BuildContext context) {
//     return AppBar(
//       automaticallyImplyLeading: false,
//       leading: InkWell(
//         onTap: () {
//           Get.offAndToNamed(RouteHelpers.home);
//         },
//         child: Icon(
//           key: cancelKey,
//           Icons.close,
//           color: Colors.white,
//           size: 22.sp,
//         ),
//       ),
//       centerTitle: true,
//       title: BigText(
//         align: TextAlign.center,
//         text: widget.text.tr,
//         color: Colors.white,
//         size: 19.sp,
//         isBold: true,
//       ),
//       backgroundColor: Theme.of(context).colorScheme.secondary,
//       actions: <Widget>[
//         IconButton(
//           key: resetKey,
//           icon: Icon(Icons.autorenew_sharp),
//           onPressed: () {
//             Get.toNamed(RouteHelpers.templatePage);
//           },
//         ),
//         IconButton(
//           key: settingsKey,
//           icon: Icon(Icons.settings),
//           onPressed: () {
//             // Action for notifications button
//             Get.toNamed(RouteHelpers.templatePage);
//           },
//         ),
//       ],
//     );
//   }
// }
