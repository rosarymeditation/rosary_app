import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../utils/constants.dart';
import 'placeholder_widget.dart';

class DistressImageWidget extends StatelessWidget {
  String imageUrl;
  DistressImageWidget({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
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
      placeholder: (context, url) => PlaceholderWidget(
        assetImage: "assets/images/solace.jpeg",
        isAvatar: false,
        height: 200.h,
      ),
      errorWidget: (context, url, error) => PlaceholderWidget(
        assetImage: "assets/images/solace.jpeg",
        isAvatar: false,
        height: 200.h,
      ),
    );
  }
}
