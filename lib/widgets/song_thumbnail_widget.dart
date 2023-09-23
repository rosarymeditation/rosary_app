import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rosary/utils/dimensions.dart';
import 'package:rosary/widgets/placeholder_widget.dart';

import '../utils/appColor.dart';
import '../utils/constants.dart';

class SongThumbnailWidget extends StatelessWidget {
  String? url;

  SongThumbnailWidget({
    super.key,
    required this.url,
  });

  @override
  Widget build(BuildContext context) {
    if (url == null || url == "") {
      return Container();
    }
    return CachedNetworkImage(
      imageUrl: url ??
          "https://foodengo2.s3.eu-west-2.amazonaws.com/rosary/songs/thumbnails/blank.webp",
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
        width: double.maxFinite,
        height: 200.h,
      ),
      placeholder: (context, url) => PlaceholderWidget(height: 200.h),
      errorWidget: (context, url, error) => PlaceholderWidget(height: 200.h),
    );
  }
}
