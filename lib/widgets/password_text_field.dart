import 'package:flutter/material.dart';

import '../utils/appColor.dart';
import '../utils/dimensions.dart';

class PasswordTextField extends StatefulWidget {
  final TextEditingController textController;
  final String hintText;
  IconData icon;
  final String labelText;
  bool hasPadding;
  bool isObscure;
  bool readOnly;
  bool hasIcon;

  PasswordTextField(
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
  State<PasswordTextField> createState() => _PasswordTextFieldState();
}

class _PasswordTextFieldState extends State<PasswordTextField> {
  late bool _passwordVisible;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _passwordVisible = false;
  }

  // @override
  // void initState() {
  //   _passwordVisible = false;
  // }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        left: widget.hasPadding ? Dimensions.height20 : 2,
        right: widget.hasPadding ? Dimensions.height20 : 2,
      ),
      decoration: BoxDecoration(
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
          obscureText: !_passwordVisible,
          controller: widget.textController,
          decoration: InputDecoration(
            floatingLabelBehavior: FloatingLabelBehavior.always,
            labelText: widget.labelText,
            hintText: widget.hintText,
            suffixIcon: InkWell(
              onTap: () {
                setState(() {
                  _passwordVisible = !_passwordVisible;
                });
              },
              child: Icon(
                _passwordVisible ? Icons.visibility : Icons.visibility_off,
                color: AppColor.iconColor,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(
                Dimensions.radius20,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(
                Dimensions.radius20,
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
