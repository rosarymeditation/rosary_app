import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rosary/utils/dimensions.dart';

import '../utils/appColor.dart';
import '../utils/constants.dart';
import 'placeholder_widget.dart';

class BannerWidget extends StatelessWidget {
  String? bannerUrl;
  bool isForPicker;
  BannerWidget({super.key, required this.bannerUrl, this.isForPicker = false});

  @override
  Widget build(BuildContext context) {
    return isForPicker
        ? Image.file(
            File(bannerUrl!),
            width: double.maxFinite,
            height: Dimensions.screenHeight * 0.2,
            fit: BoxFit.cover,
          )
        : CachedNetworkImage(
            imageUrl: bannerUrl ?? AppConstant.DEFAULT_BANNER,
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
              height: Dimensions.screenHeight * 0.2,
            ),
            placeholder: (context, url) => PlaceholderWidget(
              assetImage: AppConstant.DEFAULT_LOCAL_IMG,
              height: Dimensions.screenHeight * 0.2,
            ),
            errorWidget: (context, url, error) => PlaceholderWidget(
              assetImage: AppConstant.DEFAULT_LOCAL_IMG,
              height: Dimensions.screenHeight * 0.2,
            ),
          );
  }
}
