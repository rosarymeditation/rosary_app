import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../utils/constants.dart';

class SmallAvatarWidget extends StatelessWidget {
  final String? avatar;
  SmallAvatarWidget({super.key, required this.avatar});

  @override
  Widget build(BuildContext context) {
    return avatar == null
        ? CircleAvatar(
            backgroundImage: NetworkImage(AppConstant.DEFAULT_IMG),
          )
        : CircleAvatar(
            backgroundImage: NetworkImage(avatar!),
          );
  }
}
