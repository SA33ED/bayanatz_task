import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'custom_loading_indicator.dart';

Widget displayCachedNetworkImage({
  required String imageUrl,
  BoxFit? fit,
  double? height,
  double? width,
}) {
  return CachedNetworkImage(
    imageUrl: imageUrl,
    fit: fit ?? BoxFit.fill,
    placeholder: (context, url) => CustomLoadingIndicator(height: 100.h),
    errorWidget: (context, url, error) => Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [Icon(Icons.image, size: 32.w)],
    ),
    errorListener: (v) {
      log('Error loading image: $imageUrl');
    },
    height: height,
    width: width ?? double.infinity,
  );
}

CachedNetworkImageProvider displayProviderCachedNetworkImage({
  required String imageUrl,
}) {
  return CachedNetworkImageProvider(imageUrl);
}
