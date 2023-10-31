import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rosary/utils/constants.dart';
import 'package:rosary/utils/dimensions.dart';

import 'placeholder_widget.dart';

class FeedImageWidget extends StatelessWidget {
  String? url;
  FeedImageWidget({super.key, required this.url});

  @override
  Widget build(BuildContext context) {
    if (url == null || url == "") {
      return Container();
    }
    return AspectRatio(
      aspectRatio: 16 / 9,
      child: CachedNetworkImage(
        imageUrl: url ?? AppConstant.DEFAULT_IMG,
        imageBuilder: (context, imageProvider) => Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.contain,
              image: imageProvider,
              onError: (error, stackTrace) {
                print('');
              },
            ),
            color: Colors.black,
          ),
          // width: double.maxFinite,
          // height: 250.h,
        ),
        placeholder: (context, url) => PlaceholderWidget(
          assetImage: AppConstant.DEFAULT_LOCAL_IMG,
          height: 160.h,
        ),
        errorWidget: (context, url, error) => PlaceholderWidget(
          assetImage: AppConstant.DEFAULT_LOCAL_IMG,
          height: 160.h,
        ),
      ),
    );
  }
}
