import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../theme/app_theme.dart';
import 'app_colors.dart';

abstract class CustomTextStyle {
  static String get fontFamily => getFontName();

  static TextStyle get font900sized22Orange => TextStyle(
        fontFamily: fontFamily,
        fontWeight: FontWeight.w900,
        fontSize: 22.sp,
        color: AppColors.orange,
        overflow: TextOverflow.ellipsis,
      );

  static TextStyle get font400sized14Black => TextStyle(
        fontFamily: fontFamily,
        fontWeight: FontWeight.w400,
        fontSize: 14.sp,
        color: AppColors.black,
        overflow: TextOverflow.ellipsis,
      );

  static TextStyle get font400sized12Black => TextStyle(
        fontFamily: fontFamily,
        fontWeight: FontWeight.w400,
        fontSize: 12.sp,
        color: AppColors.black,
        overflow: TextOverflow.ellipsis,
      );

  static TextStyle get font400sized16Grey => TextStyle(
        fontFamily: fontFamily,
        fontWeight: FontWeight.w400,
        fontSize: 16.sp,
        color: AppColors.grey,
        overflow: TextOverflow.ellipsis,
      );

  static TextStyle get font400sized20Black => TextStyle(
        fontFamily: fontFamily,
        fontWeight: FontWeight.w400,
        fontSize: 20.sp,
        color: AppColors.black,
        overflow: TextOverflow.ellipsis,
      );

  static TextStyle get font400sized20Primary => TextStyle(
        fontFamily: fontFamily,
        fontWeight: FontWeight.w400,
        fontSize: 20.sp,
        color: AppColors.primary,
        overflow: TextOverflow.ellipsis,
      );

  static TextStyle get font400sized16Primary => TextStyle(
        fontFamily: fontFamily,
        fontWeight: FontWeight.w400,
        fontSize: 16.sp,
        color: AppColors.primary,
        overflow: TextOverflow.ellipsis,
      );

  static TextStyle get font400sized16Black => TextStyle(
        fontFamily: fontFamily,
        fontWeight: FontWeight.w400,
        fontSize: 16.sp,
        color: AppColors.black,
        overflow: TextOverflow.ellipsis,
      );

  static TextStyle get font400sized18Black => TextStyle(
        fontFamily: fontFamily,
        fontWeight: FontWeight.w400,
        fontSize: 18.sp,
        color: AppColors.black,
        overflow: TextOverflow.ellipsis,
      );

  static TextStyle get font400sized18Grey => TextStyle(
        fontFamily: fontFamily,
        fontWeight: FontWeight.w400,
        fontSize: 18.sp,
        color: AppColors.grey,
        overflow: TextOverflow.ellipsis,
      );

  static TextStyle get font400sized18Primary => TextStyle(
        fontFamily: fontFamily,
        fontWeight: FontWeight.w400,
        fontSize: 18.sp,
        color: AppColors.primary,
        overflow: TextOverflow.ellipsis,
      );

  static TextStyle get font600sized16Grey => TextStyle(
        fontFamily: fontFamily,
        fontWeight: FontWeight.w600,
        fontSize: 16.sp,
        color: AppColors.grey,
        overflow: TextOverflow.ellipsis,
      );

  static TextStyle get font400sized10Black => TextStyle(
        fontFamily: fontFamily,
        fontWeight: FontWeight.w400,
        fontSize: 10.sp,
        color: AppColors.black,
        overflow: TextOverflow.ellipsis,
      );

  static TextStyle get font400sized10Grey => TextStyle(
        fontFamily: fontFamily,
        fontWeight: FontWeight.w400,
        fontSize: 10.sp,
        color: AppColors.grey,
        overflow: TextOverflow.ellipsis,
      );

  static TextStyle get font700sized10Black => TextStyle(
        fontFamily: fontFamily,
        fontWeight: FontWeight.w700,
        fontSize: 10.sp,
        color: AppColors.black,
        overflow: TextOverflow.ellipsis,
      );

  static TextStyle get font400sized14Primary => TextStyle(
        fontFamily: fontFamily,
        fontWeight: FontWeight.w400,
        fontSize: 14.sp,
        color: AppColors.primary,
        overflow: TextOverflow.ellipsis,
      );

  static TextStyle get font400sized8Black => TextStyle(
        fontFamily: fontFamily,
        fontWeight: FontWeight.w400,
        fontSize: 8.sp,
        color: AppColors.black,
        overflow: TextOverflow.ellipsis,
      );

  static TextStyle get font400sized8Grey => TextStyle(
        fontFamily: fontFamily,
        fontWeight: FontWeight.w400,
        fontSize: 8.sp,
        color: AppColors.grey,
        overflow: TextOverflow.ellipsis,
      );

  static TextStyle get font600sized8Black => TextStyle(
        fontFamily: fontFamily,
        fontWeight: FontWeight.w600,
        fontSize: 8.sp,
        color: AppColors.black,
        overflow: TextOverflow.ellipsis,
      );

  static TextStyle get font600sized8Grey => TextStyle(
        fontFamily: fontFamily,
        fontWeight: FontWeight.w600,
        fontSize: 8.sp,
        color: AppColors.grey,
        overflow: TextOverflow.ellipsis,
      );

  static TextStyle get font600sized12Grey => TextStyle(
        fontFamily: fontFamily,
        fontWeight: FontWeight.w600,
        fontSize: 12.sp,
        color: AppColors.grey,
        overflow: TextOverflow.ellipsis,
      );

  static TextStyle get font600sized16Black => TextStyle(
        fontFamily: fontFamily,
        fontWeight: FontWeight.w600,
        fontSize: 16.sp,
        color: AppColors.black,
        overflow: TextOverflow.ellipsis,
      );

  static TextStyle get font600sized20Black => TextStyle(
        fontFamily: fontFamily,
        fontWeight: FontWeight.w600,
        fontSize: 20.sp,
        color: AppColors.black,
        overflow: TextOverflow.ellipsis,
      );
  static TextStyle get font600sized30Black => TextStyle(
        fontFamily: fontFamily,
        fontWeight: FontWeight.w600,
        fontSize: 30.sp,
        color: AppColors.black,
        overflow: TextOverflow.ellipsis,
      );

  static TextStyle get font600sized18Black => TextStyle(
        fontFamily: fontFamily,
        fontWeight: FontWeight.w600,
        fontSize: 18.sp,
        color: AppColors.black,
        overflow: TextOverflow.ellipsis,
      );

  static TextStyle get font600sized14Black => TextStyle(
        fontFamily: fontFamily,
        fontWeight: FontWeight.w600,
        fontSize: 14.sp,
        color: AppColors.black,
        overflow: TextOverflow.ellipsis,
      );

  static TextStyle get font600sized12Black => TextStyle(
        fontFamily: fontFamily,
        fontWeight: FontWeight.w600,
        fontSize: 12.sp,
        color: AppColors.black,
        overflow: TextOverflow.ellipsis,
      );

  static TextStyle get font600sized12White => TextStyle(
        fontFamily: fontFamily,
        fontWeight: FontWeight.w600,
        fontSize: 12.sp,
        color: AppColors.white,
        overflow: TextOverflow.ellipsis,
      );

  static TextStyle get font600sized16Primary => TextStyle(
        fontFamily: fontFamily,
        fontWeight: FontWeight.w600,
        fontSize: 16.sp,
        color: AppColors.primary,
        overflow: TextOverflow.ellipsis,
      );

  static TextStyle get font700sized14Primary => TextStyle(
        fontFamily: fontFamily,
        fontWeight: FontWeight.w700,
        fontSize: 14.sp,
        color: AppColors.primary,
        overflow: TextOverflow.ellipsis,
      );

  static TextStyle get font600sized12Primary => TextStyle(
        fontFamily: fontFamily,
        fontWeight: FontWeight.w600,
        fontSize: 12.sp,
        color: AppColors.primary,
        overflow: TextOverflow.ellipsis,
      );

  static TextStyle get font600sized14Primary => TextStyle(
        fontFamily: fontFamily,
        fontWeight: FontWeight.w600,
        fontSize: 14.sp,
        color: AppColors.primary,
        overflow: TextOverflow.ellipsis,
      );

  static TextStyle get font400sized14White => TextStyle(
        fontFamily: fontFamily,
        fontWeight: FontWeight.w400,
        fontSize: 14.sp,
        color: AppColors.white,
        overflow: TextOverflow.ellipsis,
      );
  static TextStyle get font600sized14White => TextStyle(
        fontFamily: fontFamily,
        fontWeight: FontWeight.w600,
        fontSize: 14.sp,
        color: AppColors.white,
        overflow: TextOverflow.ellipsis,
      );

  static TextStyle get font400sized10White => TextStyle(
        fontFamily: fontFamily,
        fontWeight: FontWeight.w400,
        fontSize: 10.sp,
        color: AppColors.white,
        overflow: TextOverflow.ellipsis,
      );

  static TextStyle get font400sized12Grey => TextStyle(
        fontFamily: fontFamily,
        fontWeight: FontWeight.w400,
        fontSize: 12.sp,
        color: AppColors.grey,
        overflow: TextOverflow.ellipsis,
      );

  static TextStyle get font400sized12White => TextStyle(
        fontFamily: fontFamily,
        fontWeight: FontWeight.w400,
        fontSize: 12.sp,
        color: AppColors.white,
        overflow: TextOverflow.ellipsis,
      );

  static TextStyle get font400sized12Primary => TextStyle(
        fontFamily: fontFamily,
        fontWeight: FontWeight.w400,
        fontSize: 12.sp,
        color: AppColors.primary,
        overflow: TextOverflow.ellipsis,
      );

  static TextStyle get font400sized12Orange => TextStyle(
        fontFamily: fontFamily,
        fontWeight: FontWeight.w400,
        fontSize: 12.sp,
        color: AppColors.orange,
        overflow: TextOverflow.ellipsis,
      );

  static TextStyle get font700sized12Orange => TextStyle(
        fontFamily: fontFamily,
        fontWeight: FontWeight.w700,
        fontSize: 12.sp,
        color: AppColors.orange,
        overflow: TextOverflow.ellipsis,
      );

  static TextStyle get font700sized12Primary => TextStyle(
        fontFamily: fontFamily,
        fontWeight: FontWeight.w700,
        fontSize: 12.sp,
        color: AppColors.primary,
        overflow: TextOverflow.ellipsis,
      );

  static TextStyle get font400sized14Grey => TextStyle(
        fontFamily: fontFamily,
        fontWeight: FontWeight.w400,
        fontSize: 14.sp,
        color: AppColors.grey,
        overflow: TextOverflow.ellipsis,
      );

  static TextStyle get font400sized14LightGrey => TextStyle(
        fontFamily: fontFamily,
        fontWeight: FontWeight.w400,
        fontSize: 14.sp,
        color: AppColors.lightGrey,
        overflow: TextOverflow.ellipsis,
      );

  static TextStyle get font500sized14Grey => TextStyle(
        fontFamily: fontFamily,
        fontWeight: FontWeight.w500,
        fontSize: 14.sp,
        color: AppColors.grey,
        overflow: TextOverflow.ellipsis,
      );

  static TextStyle get font500sized18Grey => TextStyle(
        fontFamily: fontFamily,
        fontWeight: FontWeight.w500,
        fontSize: 18.sp,
        color: AppColors.grey,
        overflow: TextOverflow.ellipsis,
      );

  static TextStyle get font400sized12Secoundry => TextStyle(
        fontFamily: fontFamily,
        fontWeight: FontWeight.w400,
        fontSize: 12.sp,
        color: AppColors.secoundry,
        overflow: TextOverflow.ellipsis,
      );

  static TextStyle get font600sized12Secoundry => TextStyle(
        fontFamily: fontFamily,
        fontWeight: FontWeight.w600,
        fontSize: 12.sp,
        color: AppColors.secoundry,
        overflow: TextOverflow.ellipsis,
      );

  static TextStyle get font500sized16Primary => TextStyle(
        fontFamily: fontFamily,
        fontWeight: FontWeight.w500,
        fontSize: 16.sp,
        color: AppColors.primary,
        overflow: TextOverflow.ellipsis,
      );

  static TextStyle get font600sized16White => TextStyle(
        fontFamily: fontFamily,
        fontWeight: FontWeight.w600,
        fontSize: 16.sp,
        color: AppColors.white,
        overflow: TextOverflow.ellipsis,
      );

  static TextStyle get font500sized16Black => TextStyle(
        fontFamily: fontFamily,
        fontWeight: FontWeight.w500,
        fontSize: 16.sp,
        color: AppColors.black,
        overflow: TextOverflow.ellipsis,
      );

  static TextStyle get font500sized16White => TextStyle(
        fontFamily: fontFamily,
        fontWeight: FontWeight.w500,
        fontSize: 16.sp,
        color: AppColors.white,
        overflow: TextOverflow.ellipsis,
      );

  static TextStyle get font500sized18White => TextStyle(
        fontFamily: fontFamily,
        fontWeight: FontWeight.w500,
        fontSize: 18.sp,
        color: AppColors.white,
        overflow: TextOverflow.ellipsis,
      );

  static TextStyle get font500sized20Black => TextStyle(
        fontFamily: fontFamily,
        fontWeight: FontWeight.w500,
        fontSize: 20.sp,
        color: AppColors.black,
        overflow: TextOverflow.ellipsis,
      );

  static TextStyle get font500sized24Black => TextStyle(
        fontFamily: fontFamily,
        fontWeight: FontWeight.w500,
        fontSize: 24.sp,
        color: AppColors.black,
        overflow: TextOverflow.ellipsis,
      );

  static TextStyle get font500sized12Primary => TextStyle(
        fontFamily: fontFamily,
        fontWeight: FontWeight.w500,
        fontSize: 12.sp,
        color: AppColors.primary,
        overflow: TextOverflow.ellipsis,
      );

  static TextStyle get font500sized14Primary => TextStyle(
        fontFamily: fontFamily,
        fontWeight: FontWeight.w500,
        fontSize: 14.sp,
        color: AppColors.primary,
        overflow: TextOverflow.ellipsis,
      );

  static TextStyle get font500sized12Black => TextStyle(
        fontFamily: fontFamily,
        fontWeight: FontWeight.w500,
        fontSize: 12.sp,
        color: AppColors.black,
        overflow: TextOverflow.ellipsis,
      );

  static TextStyle get font500sized12White => TextStyle(
        fontFamily: fontFamily,
        fontWeight: FontWeight.w500,
        fontSize: 12.sp,
        color: AppColors.white,
        overflow: TextOverflow.ellipsis,
      );

  static TextStyle get font500sized12Grey => TextStyle(
        fontFamily: fontFamily,
        fontWeight: FontWeight.w500,
        fontSize: 12.sp,
        color: AppColors.grey,
        overflow: TextOverflow.ellipsis,
      );

  static TextStyle get font300sized12Black => TextStyle(
        fontFamily: fontFamily,
        fontWeight: FontWeight.w300,
        fontSize: 12.sp,
        color: AppColors.black,
        overflow: TextOverflow.ellipsis,
      );

  static TextStyle get font500sized14Black => TextStyle(
        fontFamily: fontFamily,
        fontWeight: FontWeight.w500,
        fontSize: 14.sp,
        color: AppColors.black,
        overflow: TextOverflow.ellipsis,
      );

  static TextStyle get font500sized14White => TextStyle(
        fontFamily: fontFamily,
        fontWeight: FontWeight.w500,
        fontSize: 14.sp,
        color: AppColors.white,
        overflow: TextOverflow.ellipsis,
      );

  static TextStyle get font700sized16Black => TextStyle(
        fontFamily: fontFamily,
        fontWeight: FontWeight.w700,
        fontSize: 16.sp,
        color: AppColors.black,
        overflow: TextOverflow.ellipsis,
      );

  static TextStyle get font700sized14Black => TextStyle(
        fontFamily: fontFamily,
        fontWeight: FontWeight.w700,
        fontSize: 14.sp,
        color: AppColors.black,
        overflow: TextOverflow.ellipsis,
      );

  static TextStyle get font700sized16Primary => TextStyle(
        fontFamily: fontFamily,
        fontWeight: FontWeight.w700,
        fontSize: 16.sp,
        color: AppColors.primary,
        overflow: TextOverflow.ellipsis,
      );

  static TextStyle get font700sized18Black => TextStyle(
        fontFamily: fontFamily,
        fontWeight: FontWeight.w700,
        fontSize: 18.sp,
        color: AppColors.black,
        overflow: TextOverflow.ellipsis,
      );

  static TextStyle get font700sized14Grey => TextStyle(
        fontFamily: fontFamily,
        fontWeight: FontWeight.w700,
        fontSize: 14.sp,
        color: AppColors.grey,
        overflow: TextOverflow.ellipsis,
      );

  static TextStyle get font700sized14White => TextStyle(
        fontFamily: fontFamily,
        fontWeight: FontWeight.w700,
        fontSize: 14.sp,
        color: AppColors.white,
        overflow: TextOverflow.ellipsis,
      );

  static TextStyle get font700sized22Black => TextStyle(
        fontFamily: fontFamily,
        fontWeight: FontWeight.w700,
        fontSize: 22.sp,
        color: AppColors.black,
        overflow: TextOverflow.ellipsis,
      );

  static TextStyle get font700sized30Black => TextStyle(
        fontFamily: fontFamily,
        fontWeight: FontWeight.w700,
        fontSize: 30.sp,
        color: AppColors.black,
        overflow: TextOverflow.ellipsis,
      );

  static TextStyle get fontBoldsized28Primary => TextStyle(
        fontFamily: fontFamily,
        fontWeight: FontWeight.bold,
        fontSize: 28.sp,
        color: AppColors.primary,
        overflow: TextOverflow.ellipsis,
      );

  static TextStyle get font300sized14Black => TextStyle(
        fontFamily: fontFamily,
        fontWeight: FontWeight.w300,
        fontSize: 14.sp,
        color: AppColors.black,
        overflow: TextOverflow.ellipsis,
      );

  static TextStyle get font700sized20Black => TextStyle(
        fontFamily: fontFamily,
        fontWeight: FontWeight.w700,
        fontSize: 20.sp,
        color: AppColors.black,
        overflow: TextOverflow.ellipsis,
      );
}
