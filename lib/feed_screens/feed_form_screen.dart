import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:quickalert/quickalert.dart';
import 'package:rosary/route/route_helpers.dart';
import 'package:rosary/utils/appColor.dart';
import 'package:rosary/widgets/app_icon.dart';
import 'package:rosary/widgets/main_app_bar_widget.dart';
import 'package:rosary/widgets/main_text.dart';
import '../controllers/auth_controller.dart';
import '../controllers/feed_controller.dart';
import '../utils/dimensions.dart';
import '../utils/show_custom_snackbar.dart';
import '../widgets/app_text_field.dart';
import '../widgets/display_button_widget.dart';
import '../widgets/sign_in_button_widget.dart';

class FeedFormScreen extends StatefulWidget {
  FeedFormScreen({super.key});

  @override
  State<FeedFormScreen> createState() => _FeedFormScreenState();
}

class _FeedFormScreenState extends State<FeedFormScreen> {
  var _contentController = TextEditingController();
  var textController = TextEditingController();
  var _authController = Get.find<AuthController>();
  File? _image;

  PickedFile? _pickedFile;

  final _picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<FeedController>(
      builder: (feed) {
        return Scaffold(
          appBar: MainAppBarWidget(text: "Make a post"),
          body: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 10.h,
                ),
                _image != null
                    ? Stack(
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 20.w),
                            width: double.maxFinite,
                            height: 160.h,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Image.file(
                              File(_image!.path),
                              width: double.maxFinite,
                              height: 160.h,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Positioned(
                            top: 10.h,
                            right: 30.w,
                            child: InkWell(
                              onTap: () {
                                setState(() {
                                  _image = null;
                                });
                              },
                              child: AppIcon(
                                iconColor: Colors.white,
                                icon: Icons.close,
                                iconSize: 20.sp,
                                backgroundColor: AppColor.primaryColor,
                              ),
                            ),
                          ),
                        ],
                      )
                    : Container(),
                SizedBox(
                  height: 20.h,
                ),
                AppTextField(
                  maxLength: 1000,
                  hasIcon: false,
                  minLine: 6,
                  textController: _contentController,
                  hintText: "",
                ),
                SizedBox(
                  height: 20.h,
                ),
                InkWell(
                  onTap: () async {
                    var image = await showImageSource(context);
                    pickImage(image!);
                  },
                  child: Padding(
                    padding: EdgeInsets.only(left: 10.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.image_rounded,
                          color: Colors.green,
                          size: 30.sp,
                        ),
                        SizedBox(
                          width: 10.w,
                        ),
                        MainText(
                          text: "Photo",
                          size: 14.sp,
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
              ],
            ),
          ),
          bottomNavigationBar: Padding(
            padding: EdgeInsets.only(left: 10.w, right: 10.w, bottom: 20.h),
            child: InkWell(
                onTap: () async {
                  var content = _contentController.value.text;

                  if (content == "") {
                    showCustomSnackBar("empty post".tr,
                        title: "invalid_content".tr, isError: true);
                  } else {
                    var value = _image == null
                        ? await feed.uploadWithoutImage(content)
                        : await feed.uploadWithImage(_image!, content);
                    if (value.isSuccess) {
                      QuickAlert.show(
                        barrierDismissible: false,
                        context: context,
                        title: "Waiting for Approval".tr,
                        type: QuickAlertType.success,
                        onConfirmBtnTap: () {
                          Navigator.pop(context);
                          _authController.setCurrentIndex(1);
                          Get.offAndToNamed(RouteHelpers.home);
                        },
                        confirmBtnText: "Dismiss",
                        text:
                            "Thank you for your recent post submission! We've received it and it's now in line for approval. Our team will review it promptly."
                                .tr,
                      );
                    } else {
                      showCustomSnackBar(
                        "Could not be saved successfully".tr,
                        title: "not posted".tr,
                        isError: true,
                      );
                    }
                  }
                },
                child: feed.isLoaded
                    ? _authController.userLoggedIn()
                        ? DisplayButtonWidget(text: 'Post')
                        : const SignInButtonWidget()
                    : Center(
                        child: CircularProgressIndicator(),
                      )),
          ),
        );
      },
    );
  }

  Future pickImage(ImageSource source) async {
    try {
      _pickedFile = await _picker.getImage(source: source);

      if (_pickedFile != null) {
        setState(() {
          _image = File(_pickedFile!.path);
        });
      }
    } on PlatformException catch (e) {
      print("Failed to pick image" + e.toString());
    }
  }

  Future<ImageSource?> showImageSource(BuildContext context) async {
    if (Platform.isIOS) {
      return showCupertinoModalPopup(
        context: context,
        builder: (context) => CupertinoActionSheet(
          actions: [
            CupertinoActionSheetAction(
                onPressed: () {
                  Navigator.of(context).pop(ImageSource.camera);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.photo_camera,
                      color: AppColor.primaryColor,
                    ),
                    SizedBox(
                      width: 10.w,
                    ),
                    MainText(
                      text: 'Camera',
                    ),
                  ],
                )),
            CupertinoActionSheetAction(
              onPressed: () {
                Navigator.of(context).pop(ImageSource.gallery);
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(
                    Icons.photo_library,
                    color: AppColor.primaryColor,
                  ),
                  SizedBox(
                    width: 10.w,
                  ),
                  MainText(
                    text: 'Gallery',
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
            ListTile(
              leading: Icon(Icons.camera_alt),
              title: Text('Camera'),
              onTap: () => Navigator.of(context).pop(ImageSource.camera),
            ),
            ListTile(
              leading: Icon(Icons.image),
              title: Text('Gallery'),
              onTap: () => Navigator.of(context).pop(ImageSource.gallery),
            )
          ],
        ),
      );
    }
  }
}
