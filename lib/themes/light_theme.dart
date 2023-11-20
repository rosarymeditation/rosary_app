import 'package:flutter/material.dart';

ThemeData lightTheme = ThemeData(
  colorScheme: ColorScheme.light(
    brightness: Brightness.light,
    background: Colors.grey.shade200,
    primary: Colors.white.withOpacity(.85),
    tertiary: Colors.white,
    secondary: Colors.blue.shade800,
    inversePrimary: Colors.black,
  ),
  brightness: Brightness.light,
);
