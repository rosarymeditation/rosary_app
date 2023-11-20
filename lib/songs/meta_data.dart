import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rosary/utils/appColor.dart';
import 'package:rosary/widgets/main_text.dart';

import '../utils/constants.dart';
import '../widgets/placeholder_widget.dart';

class MediaMetadata extends StatelessWidget {
  MediaMetadata(
      {super.key,
      required this.artist,
      required this.imageUrl,
      required this.title,
      this.isForRosary = false});

  final String imageUrl;
  final String title;
  final String artist;
  bool isForRosary;

  Widget build(BuildContext context) {
    return Column(
      children: [
        DecoratedBox(
          decoration: BoxDecoration(boxShadow: [
            BoxShadow(
                color: Colors.black12, offset: Offset(2, 4), blurRadius: 4)
          ], borderRadius: BorderRadius.circular(10)),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: CachedNetworkImage(
              imageUrl: imageUrl,
              imageBuilder: (context, imageProvider) => Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: imageProvider,
                    onError: (error, stackTrace) {
                      print(error);
                    },
                  ),
                  color: Colors.grey.shade300,
                ),
                width: double.maxFinite,
                height: 300.h,
              ),
              placeholder: (context, url) => PlaceholderWidget(
                assetImage: AppConstant.getImagePath("mary.jpeg"),
                height: 300.h,
              ),
              errorWidget: (context, url, error) => PlaceholderWidget(
                assetImage: AppConstant.getImagePath("mary.jpeg"),
                height: 300.h,
              ),
            ),
            // CachedNetworkImage(
            //   imageUrl: imageUrl,
            //   height: 300,
            //   width: 300,
            //   fit: BoxFit.cover,
            // ),
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        MainText(size: 20, isBold: true, text: title, color: AppColor.subTitle),
        SizedBox(
          height: 10,
        ),
        MainText(
          text: artist,
          size: 16.sp,
          color: AppColor.subTitle,
        )
      ],
    );
  }
}
