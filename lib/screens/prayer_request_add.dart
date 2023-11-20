import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:rosary/controllers/prayer_request_controller.dart';
import 'package:rosary/model/prayer_request_model.dart';
import 'package:rosary/utils/show_custom_snackbar.dart';
import 'package:rosary/widgets/display_button_widget.dart';
import 'package:rosary/widgets/info_box.dart';
import 'package:rosary/widgets/main_app_bar_widget.dart';
import 'package:rosary/widgets/main_text.dart';

import '../widgets/app_text_field.dart';

class PrayerRequestAddScreen extends StatefulWidget {
  PrayerRequestAddScreen({super.key});

  @override
  State<PrayerRequestAddScreen> createState() => _PrayerRequestAddScreenState();
}

class _PrayerRequestAddScreenState extends State<PrayerRequestAddScreen> {
  var _prayerController = Get.find<PrayerRequestController>();
  late TextEditingController _contentController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _contentController =
        TextEditingController(text: _prayerController.editContent.content);
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PrayerRequestController>(
      builder: (prayer) {
        return Scaffold(
          backgroundColor: Theme.of(context).colorScheme.background,
          appBar: MainAppBarWidget(text: 'Add Prayer Request'),
          body: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage("assets/images/pray.jpg"),
              ),
            ),
            child: Container(
              color: Colors.white.withOpacity(.50),
              child: Column(
                children: [
                  SizedBox(
                    height: 120.h,
                  ),
                  InfoBoxWidget(text: "prayer_privacy_message".tr),
                  SizedBox(
                    height: 20.h,
                  ),
                  AppTextField(
                    maxLength: 200,
                    hasIcon: false,
                    minLine: 3,
                    textController: _contentController,
                    hintText: "type_in_request".tr,
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                ],
              ),
            ),
          ),
          bottomNavigationBar: Padding(
            padding: EdgeInsets.only(left: 10.w, right: 10.w, bottom: 20.h),
            child: InkWell(
                onTap: () {
                  var content = _contentController.value.text;
                  if (content == "") {
                    showCustomSnackBar(
                      "prayer_request_empty".tr,
                      title: "invalid_content".tr,
                      backColor: Colors.orange.shade800,
                    );
                  } else {
                    if (_prayerController.editContent.content == "") {
                      prayer.add(_contentController.text);
                    } else {
                      prayer.updateContent(prayer.editContent.id, content);
                    }

                    showCustomSnackBar(
                      "prayer_saved".tr,
                      title: "",
                      backColor: Colors.green.shade800,
                    );
                    Navigator.pop(context);
                  }
                },
                child: DisplayButtonWidget(text: 'submit_request')),
          ),
        );
      },
    );
  }
}
