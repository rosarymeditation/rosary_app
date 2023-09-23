import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rosary/model/online_prayer_model.dart';

import '../utils/constants.dart';
import '../utils/dimensions.dart';
import 'main_text.dart';
import 'placeholder_widget.dart';

class PrayerBannerWidget extends StatelessWidget {
  OnlinePrayerModel item;
  PrayerBannerWidget({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Positioned(
          child: CachedNetworkImage(
            imageUrl: item.url ?? AppConstant.DEFAULT_PRAYER_IMAGE,
            imageBuilder: (context, imageProvider) => Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: imageProvider,
                  onError: (error, stackTrace) {
                    print("edlldll- error");
                    print(error);
                  },
                ),
                color: Colors.grey.shade300,
              ),
              width: double.maxFinite,
              height: 200.h,
            ),
            placeholder: (context, url) => PlaceholderWidget(
              assetImage: AppConstant.getImagePath("hands.jpeg"),
              height: 200.h,
            ),
            errorWidget: (context, url, error) => PlaceholderWidget(
              assetImage: AppConstant.getImagePath("hands.jpeg"),
              height: 200.h,
            ),
          ),
        ),
        Align(
          alignment: Alignment.center,
          child: Container(
            color: const Color.fromARGB(99, 13, 72, 161),
            padding: EdgeInsets.symmetric(
              horizontal: 10.w,
              vertical: 20.h,
            ),
            child: MainText(
              isBold: true,
              size: 20.sp,
              text: item.title!,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}
