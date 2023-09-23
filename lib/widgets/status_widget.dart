import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../model/status_model.dart';
import 'main_text.dart';

class StatusWidget extends StatelessWidget {
  StatusModel? status;
  StatusWidget({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    Color color;
    if (status == null) {
      return Text("");
    }
    if (status!.name! == "Pending") {
      color = Colors.orange.shade400;
    } else if (status!.name == "Approved") {
      color = Colors.green.shade400;
    } else {
      color = Colors.red.shade400;
    }
    return MainText(
      isBold: true,
      size: 15.sp,
      text: status!.name!,
      color: color,
    );
  }
}
