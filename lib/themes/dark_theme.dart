import 'package:flutter/material.dart';

ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  appBarTheme: const AppBarTheme(backgroundColor: Colors.black),
  colorScheme: ColorScheme.dark(
    background: Colors.black,
    primary: Colors.grey.shade700,
    tertiary: Colors.grey.shade800,
    secondary: Colors.grey.shade900,
    inversePrimary: Colors.white,
  ),
);
