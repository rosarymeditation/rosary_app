import 'package:flutter/material.dart';

import '../utils/appColor.dart';
import '../utils/dimensions.dart';

class AuthTextField extends StatelessWidget {
  final TextEditingController textController;
  final String hintText;
  IconData icon;
  final String labelText;
  bool hasPadding;
  bool isObscure;
  bool readOnly;
  bool hasIcon;

  AuthTextField(
      {Key? key,
      required this.textController,
      required this.hintText,
      this.icon = Icons.person,
      this.labelText = "",
      this.hasIcon = true,
      this.readOnly = false,
      this.isObscure = false,
      this.hasPadding = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        left: hasPadding ? Dimensions.height20 : 2,
        right: hasPadding ? Dimensions.height20 : 2,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
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
          enableSuggestions: true,
          readOnly: readOnly,
          obscureText: isObscure,
          controller: textController,
          decoration: InputDecoration(
            floatingLabelBehavior: FloatingLabelBehavior.always,
            labelText: labelText,
            hintText: hintText,
            prefixIcon: Icon(
              icon,
              color: AppColor.primaryColor,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(
                Dimensions.radius20,
              ),
              borderSide: BorderSide(
                width: 1.0,
                color: Colors.white,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(
                Dimensions.radius20,
              ),
              borderSide: BorderSide(
                width: 1.0,
                color: Colors.white,
              ),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(
                Dimensions.radius20,
              ),
            ),
          )),
    );
  }
}
