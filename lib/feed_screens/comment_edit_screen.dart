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

import '../controllers/feedComment_controller.dart';
import '../widgets/app_text_field.dart';

class CommentEditScreen extends StatefulWidget {
  CommentEditScreen({super.key});

  @override
  State<CommentEditScreen> createState() => _CommentEditScreenState();
}

class _CommentEditScreenState extends State<CommentEditScreen> {
  var _commentController = Get.find<FeedCommentController>();
  late TextEditingController _contentController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _contentController =
        TextEditingController(text: _commentController.editingContent);
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<FeedCommentController>(
      builder: (comment) {
        return Scaffold(
          backgroundColor: Theme.of(context).colorScheme.background,
          appBar: MainAppBarWidget(text: 'Edit Comment'),
          body: Column(
            children: [
              SizedBox(
                height: 120.h,
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
          bottomNavigationBar: Padding(
            padding: EdgeInsets.only(left: 10.w, right: 10.w, bottom: 20.h),
            child: InkWell(
                onTap: () {
                  var content = _contentController.value.text;
                  if (content == "") {
                    showCustomSnackBar(
                      "empty post".tr,
                      title: "invalid_content".tr,
                      backColor: Colors.orange.shade800,
                    );
                  } else {
                    comment.updateComment(
                        comment.currentCommentId, _contentController.text);

                    showCustomSnackBar(
                      "saved".tr,
                      title: "",
                      backColor: Colors.green.shade800,
                    );
                    Navigator.pop(context);
                  }
                },
                child: DisplayButtonWidget(text: 'Update')),
          ),
        );
      },
    );
  }
}
