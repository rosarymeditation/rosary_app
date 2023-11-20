import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../utils/appColor.dart';

class AppTextField extends StatelessWidget {
  final TextEditingController textController;
  final TextInputType keyboardType;
  final String hintText;
  final int maxLength;
  IconData icon;
  final String labelText;
  bool hasPadding;
  bool isObscure;
  int minLine;
  bool readOnly;
  bool hasIcon;
  AppTextField(
      {Key? key,
      required this.textController,
      required this.hintText,
      this.icon = Icons.person,
      this.keyboardType = TextInputType.text,
      this.labelText = "",
      this.hasIcon = true,
      this.minLine = 1,
      this.readOnly = false,
      this.isObscure = false,
      this.maxLength = 2000,
      this.hasPadding = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        left: hasPadding ? 20.w : 2,
        right: hasPadding ? 20.w : 2,
      ),
      padding: EdgeInsets.all(3),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.tertiary,
        borderRadius: BorderRadius.circular(
          20.sp,
        ),
        boxShadow: [
          BoxShadow(
            blurRadius: 10.sp,
            spreadRadius: 7,
            offset: Offset(1, 10),
            color: Colors.grey.withOpacity(0.2),
          ),
        ],
      ),
      child: TextField(
        cursorColor: AppColor.subTitle,
        enableSuggestions: true,
        minLines: minLine,
        maxLines: null,
        readOnly: readOnly,
        obscureText: isObscure,
        controller: textController,
        decoration: hasIcon
            ? InputDecoration(
                floatingLabelBehavior: FloatingLabelBehavior.always,
                labelText: labelText,
                hintText: hintText,
                prefixIcon: Icon(
                  icon,
                  color: AppColor.primaryColor,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(
                    20.sp,
                  ),
                  borderSide: BorderSide(
                    width: 1.0,
                    color: Colors.white,
                  ),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(
                    20.sp,
                  ),
                ),
              )
            : InputDecoration(
                border: InputBorder.none,
                floatingLabelBehavior: FloatingLabelBehavior.always,
                labelText: labelText,
                hintText: hintText,
              ),
      ),
    );
  }
}
