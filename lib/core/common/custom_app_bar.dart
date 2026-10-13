import 'package:flutter/material.dart';

import '../utils/app_colors.dart';
import '../utils/app_text_styles.dart';

AppBar customAppBar(
  BuildContext context, {
  title,
  onPressed,
  backgroundColor,
  titleColor,
  actions,
  showBackButton = true,
}) {
  return AppBar(
    title: title != null
        ? Text(
            title,
            style: CustomTextStyle.font400sized20Black.copyWith(
              color: titleColor,
            ),
          )
        : null,
    centerTitle: true,
    backgroundColor: backgroundColor ?? AppColors.white,
    elevation: 0,
    actions: actions,
    leading: showBackButton == true
        ? GestureDetector(
            onTap: onPressed ?? () => Navigator.of(context).pop(),
            child: Icon(
              Icons.arrow_back_ios,
              color: titleColor ?? AppColors.black,
            ),
          )
        : const SizedBox.shrink(),
  );
}
