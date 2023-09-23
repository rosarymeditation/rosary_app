import 'package:flutter/material.dart' hide ModalBottomSheetRoute;
import 'package:get/get.dart';

import '../widgets/big_text.dart';

void showCustomSnackBar(String message,
    {bool isError = true,
    String title = "Error",
    Color backColor = Colors.orange}) {
  Get.snackbar(title, message,
      titleText: BigText(
        text: title,
        color: Colors.white,
      ),
      messageText: Text(
        message,
        style: const TextStyle(color: Colors.white),
      ),
      colorText: Colors.white,
      snackPosition: SnackPosition.TOP,
      backgroundColor: isError ? backColor : Colors.green.shade300);
}
