import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rosary/route/route_helpers.dart';
import 'package:rosary/widgets/app_icon.dart';
import 'package:rosary/widgets/app_text_field.dart';
import 'package:rosary/widgets/auth_button.dart';
import 'package:rosary/widgets/avatar_widget.dart';
import 'package:rosary/widgets/banner_widget.dart';
import 'package:rosary/widgets/regular_button.dart';
import '../../widgets/auth_text_field.dart';
import '../controllers/auth_controller.dart';
import '../controllers/user_controller.dart';
import '../model/signup_body_model.dart';
import '../utils/appColor.dart';
import '../utils/constants.dart';
import '../utils/dimensions.dart';
import '../utils/show_custom_snackbar.dart';
import '../widgets/chat_text_field.dart';
import '../widgets/main_app_bar_widget.dart';
import '../widgets/main_text.dart';

class EditProfilePage extends StatefulWidget {
  EditProfilePage({Key? key}) : super(key: key);

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  File? _bannerImage;

  File? _avatarImage;

  final _picker = ImagePicker();

  PickedFile? _pickedFileAvatar;
  PickedFile? _pickedFileBanner;

  var emailController = TextEditingController();
  var firstnameController = TextEditingController();
  var lastnameController = TextEditingController();
  var bioController = TextEditingController();

  var _userController = Get.find<UserController>();
  var _authController = Get.find<AuthController>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    emailController.text = _userController.userModel.email ?? "";
    bioController.text = _userController.userModel.bio ?? "";
    firstnameController.text = _userController.userModel.firstname ?? "";
    lastnameController.text = _userController.userModel.lastname ?? "";
  }

  @override
  Widget build(BuildContext context) {
    void _update() {
      var _auth = Get.find<AuthController>();

      String firstname = firstnameController.text.trim();
      String lastname = lastnameController.text.trim();
      String email = emailController.text.trim();
      String bio = bioController.text.trim();
      if (firstname.isEmpty) {
        showCustomSnackBar("Type in your first name", title: "First name");
      } else if (firstname.length < 2 || lastname.length < 2) {
        showCustomSnackBar("First name or last name must exceed one character",
            title: "Incomplete");
      } else if (lastname.isEmpty) {
        showCustomSnackBar("Typein your last name", title: "Last name");
      } else if (email.isEmpty) {
        showCustomSnackBar("Typein your email", title: "Email");
      } else if (!GetUtils.isEmail(email)) {
        showCustomSnackBar("Type in a valid email name", title: "Email");
      } else {
        _userController
            .submit(_bannerImage, _avatarImage, firstname, lastname, bio, email)
            .then((status) {
          if (status.isSuccess) {
            showCustomSnackBar("Updated successfully",
                isError: false, title: "Saved");
            // _auth.resetReturnUrl();
          } else {
            showCustomSnackBar(status.message);
          }
        });
      }
    }

    return GetBuilder<AuthController>(builder: (auth) {
      return GetBuilder<UserController>(
        builder: (user) {
          return Scaffold(
            backgroundColor: Theme.of(context).colorScheme.background,
            appBar: MainAppBarWidget(
              text: AppConstant.USER_PROFILE,
            ),
            body: auth.isLoading
                ? Center(child: CircularProgressIndicator())
                : SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: Column(
                      children: [
                        InkWell(
                          onTap: () async {
                            var image = await showImageSource(context);
                            bannerPickImage(image!);
                          },
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              _bannerImage == null
                                  ? BannerWidget(
                                      bannerUrl:
                                          _userController.userModel.banner)
                                  : BannerWidget(
                                      bannerUrl: _bannerImage!.path,
                                      isForPicker: true),
                              Positioned(
                                top: 20.h,
                                right: 10,
                                child: AppIcon(
                                  icon: Icons.camera_alt_rounded,
                                  size: 50.sp,
                                  iconSize: 30.sp,
                                ),
                              ),
                              Positioned(
                                top: 20.h,
                                child: Center(
                                    child: InkWell(
                                  onTap: () async {
                                    var image = await showImageSource(context);
                                    avatarPickImage(image!);
                                  },
                                  child: Stack(
                                    children: [
                                      _avatarImage != null
                                          ? Positioned(
                                              child: AvatarWidget(
                                                size: 120.sp,
                                                avatarUrl: _avatarImage!.path,
                                                isForPicker: true,
                                              ),
                                            )
                                          : Positioned(
                                              child: AvatarWidget(
                                                  size: 120.sp,
                                                  avatarUrl: _userController
                                                      .userModel.avatar),
                                            ),
                                      Positioned(
                                        right: 30.sp,
                                        top: 10.sp,
                                        child: AppIcon(
                                          icon: Icons.camera_alt_sharp,
                                          iconColor: Colors.white,
                                          backgroundColor: Colors.black,
                                        ),
                                      )
                                    ],
                                  ),
                                )),
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: Dimensions.screenHeight * 0.05,
                        ),
                        AuthTextField(
                          textController: firstnameController,
                          hintText: "First name",
                          icon: Icons.account_box,
                        ),
                        SizedBox(
                          height: Dimensions.height20,
                        ),
                        AuthTextField(
                          textController: lastnameController,
                          hintText: "Last name",
                          icon: Icons.account_box,
                        ),
                        SizedBox(
                          height: Dimensions.height20,
                        ),
                        AuthTextField(
                          textController: emailController,
                          hintText: "Email",
                          icon: Icons.email,
                          readOnly: true,
                        ),
                        SizedBox(
                          height: Dimensions.height20,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20.w),
                          child: ChatTextField(
                              textController: bioController, hintText: "Bio"),
                        ),
                        SizedBox(
                          height: Dimensions.height20,
                        ),
                        SizedBox(
                          height: Dimensions.height20,
                        ),
                        SizedBox(
                          height: Dimensions.height10,
                        ),
                      ],
                    ),
                  ),
            bottomNavigationBar: user.isLoading
                ? Container(
                    padding: EdgeInsets.all(20),
                    height: 80.h,
                    width: double.maxFinite,
                    child: Center(child: CircularProgressIndicator()))
                : GestureDetector(
                    onTap: () {
                      _update();
                    },
                    child: Padding(
                        padding: EdgeInsets.only(
                          bottom: 20.h,
                        ),
                        child: AuthButtonWidget(title: "Update")),
                  ),
          );
        },
      );
    });
  }

  Future bannerPickImage(ImageSource source) async {
    try {
      _pickedFileBanner = await _picker.getImage(source: source);

      if (_pickedFileBanner != null) {
        setState(() {
          _bannerImage = File(_pickedFileBanner!.path);
        });
      }
    } on PlatformException catch (e) {
      print("Failed to pick image" + e.toString());
    }
  }

  Future avatarPickImage(ImageSource source) async {
    try {
      _pickedFileBanner = await _picker.getImage(source: source);

      if (_pickedFileBanner != null) {
        setState(() {
          _avatarImage = File(_pickedFileBanner!.path);
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
              title: MainText(text: 'Camera'),
              onTap: () => Navigator.of(context).pop(ImageSource.camera),
            ),
            ListTile(
              leading: Icon(Icons.image),
              title: MainText(text: 'Gallery'),
              onTap: () => Navigator.of(context).pop(ImageSource.gallery),
            )
          ],
        ),
      );
    }
  }
}
