import 'package:flutter/material.dart' hide ModalBottomSheetRoute;
import 'package:get/get.dart';

import '../widgets/big_text.dart';

void showCustomSnackBar(String message,
    {bool isError = true,
    String title = "alert",
    Color backColor = Colors.orange}) {
  Get.snackbar(title, message,
      titleText: BigText(
        text: "alert".tr,
        color: Colors.black,
      ),
      duration: Duration(seconds: 6),
      messageText: Text(
        message,
        style: const TextStyle(color: Colors.black),
      ),
      colorText: Colors.white,
      snackPosition: SnackPosition.TOP,
      backgroundColor: Colors.blue.shade200);
}
