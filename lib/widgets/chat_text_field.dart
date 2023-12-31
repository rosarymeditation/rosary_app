import 'package:flutter/material.dart';

import '../utils/appColor.dart';
import '../utils/dimensions.dart';

class ChatTextField extends StatelessWidget {
  final TextEditingController textController;
  final String hintText;
  final String labelText;
  bool hasPadding;
  bool isObscure;
  bool readOnly;

  ChatTextField(
      {Key? key,
      required this.textController,
      required this.hintText,
      this.labelText = "",
      this.readOnly = false,
      this.isObscure = false,
      this.hasPadding = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        left: hasPadding ? Dimensions.height20 : 0,
        right: hasPadding ? Dimensions.height20 : 0,
      ),
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        //  backgroundColor: Theme.of(context).colorScheme.background,
        color: Theme.of(context).colorScheme.tertiary,
        borderRadius: BorderRadius.circular(
          Dimensions.radius20,
        ),
        boxShadow: [
          BoxShadow(
            blurRadius: Dimensions.radius10,
            spreadRadius: 7,
            offset: Offset(1, 10),
            color: Colors.grey.withOpacity(0.2),
          ),
        ],
      ),
      child: TextField(
          cursorColor: AppColor.subTitle,
          enableSuggestions: true,
          readOnly: readOnly,
          obscureText: isObscure,
          maxLines: null,
          controller: textController,
          decoration: InputDecoration(
            border: InputBorder.none,
            floatingLabelBehavior: FloatingLabelBehavior.always,
            labelText: labelText,
            hintText: hintText,
          )),
    );
  }
}
