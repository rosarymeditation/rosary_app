import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rosary/utils/appColor.dart';
import 'package:rosary/widgets/app_icon.dart';
import 'package:rosary/widgets/auth_button.dart';
import 'package:rosary/widgets/feed_image_widget.dart';
import 'package:rosary/widgets/main_app_bar_widget.dart';
import 'package:rosary/widgets/main_text.dart';
import '../controllers/auth_controller.dart';
import '../controllers/feed_controller.dart';
import '../utils/show_custom_snackbar.dart';
import '../widgets/app_text_field.dart';
import '../widgets/display_button_widget.dart';
import '../widgets/sign_in_button_widget.dart';

class FeedEditFormScreen extends StatefulWidget {
  FeedEditFormScreen({super.key});

  @override
  State<FeedEditFormScreen> createState() => _FeedEditFormScreenState();
}

class _FeedEditFormScreenState extends State<FeedEditFormScreen> {
  var _contentController = TextEditingController();
  var _feedController = Get.find<FeedController>();
  var _authController = Get.find<AuthController>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _contentController =
        TextEditingController(text: _feedController.editingContent.content);
  }

  File? _image;

  PickedFile? _pickedFile;

  final _picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<FeedController>(
      builder: (feed) {
        return Scaffold(
          backgroundColor: Theme.of(context).colorScheme.background,
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
                                iconColor: AppColor.iconColor,
                                icon: Icons.close,
                                iconSize: 20.sp,
                                backgroundColor: AppColor.primaryColor,
                              ),
                            ),
                          ),
                        ],
                      )
                    : Container(),
                _image == null && _feedController.editingContent.url != ""
                    ? Stack(
                        children: [
                          FeedImageWidget(
                            url: _feedController.editingContent.url,
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
                          color: AppColor.iconColor,
                          size: 30.sp,
                        ),
                        SizedBox(
                          width: 10.w,
                        ),
                        MainText(
                          text: "Photo",
                          color: AppColor.subTitle,
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
                    showCustomSnackBar(
                      "empty post".tr,
                      title: "invalid_content".tr,
                      backColor: Colors.orange.shade800,
                    );
                  } else {
                    var value = _image == null
                        ? await feed.uploadWithoutImage(
                            content,
                            id: _feedController.editingContent.id!,
                            isForUpdate: true,
                          )
                        : await feed.uploadWithImage(
                            _image!,
                            content,
                            id: _feedController.editingContent.id!,
                            isForUpdate: true,
                          );
                    if (value.isSuccess) {
                      showCustomSnackBar(
                        "Posted successfully".tr,
                        title: "posted".tr,
                        isError: false,
                      );
                    } else {
                      showCustomSnackBar("Could not be saved successfully".tr,
                          title: "not posted".tr, isError: true);
                    }
                  }
                },
                child: feed.isLoaded
                    ? _authController.userLoggedIn()
                        ? AuthButtonWidget(title: 'Post')
                        : SignInButtonWidget()
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
