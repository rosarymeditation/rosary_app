import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rosary/widgets/placeholder_widget.dart';

import '../utils/constants.dart';

class AvatarWidget extends StatelessWidget {
  String? avatarUrl;
  bool isForPicker;
  double size;
  AvatarWidget(
      {super.key,
      required this.size,
      required this.avatarUrl,
      this.isForPicker = false});

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: isForPicker
          ? Image.file(
              File(avatarUrl!),
              height: size,
              width: size,
              fit: BoxFit.cover,
            )
          : avatarUrl != "" && avatarUrl != null
              ? CachedNetworkImage(
                  imageUrl: avatarUrl ?? AppConstant.DEFAULT_AVATAR_ONLINE,
                  imageBuilder: (context, imageProvider) => Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: imageProvider,
                        onError: (error, stackTrace) {
                          print('');
                        },
                      ),
                      color: Colors.grey.shade300,
                    ),
                    width: size,
                    height: size,
                  ),
                  placeholder: (context, url) => PlaceholderWidget(
                    assetImage: AppConstant.DEFAULT_AVATAR,
                    isAvatar: true,
                    avatarSize: size,
                  ),
                  errorWidget: (context, url, error) => PlaceholderWidget(
                    assetImage: AppConstant.DEFAULT_AVATAR,
                    isAvatar: true,
                    avatarSize: size,
                  ),
                )
              : Image.asset(
                  AppConstant.DEFAULT_AVATAR,
                  height: size,
                  width: size,
                  fit: BoxFit.cover,
                ),
    );
  }
}
