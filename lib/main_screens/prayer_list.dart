import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rosary/widgets/main_text.dart';

class PrayerScreen extends StatelessWidget {
  const PrayerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: MainText(text: "Prayers"),
        ),
      ),
    );
  }
}
