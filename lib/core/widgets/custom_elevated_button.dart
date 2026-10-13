import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../utils/app_colors.dart';
import '../utils/app_text_styles.dart';

class CustomElevatedButton extends StatelessWidget {
  const CustomElevatedButton({
    super.key,
    this.text,
    this.width,
    this.color,
    this.borderColor,
    this.textColor = AppColors.white,
    this.onPressed,
    this.icon,
    this.elevation,
    this.borderRadius,
    this.contentPadding,
    this.style,
  });
  final VoidCallback? onPressed;
  final String? text;
  final Color? textColor;
  final double? width;
  final double? borderRadius;
  final Color? color;
  final Color? borderColor;
  final double? elevation;
  final Widget? icon;
  final EdgeInsetsGeometry? contentPadding;
  final TextStyle? style;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: color ?? AppColors.primary,
        elevation: elevation ?? 0,
        shadowColor: AppColors.lightGrey,
        // fixedSize: Size(width ?? MediaQuery.of(context).size.width, 50.h),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius ?? 12.r),
          side: BorderSide(
            color: onPressed != null
                ? (borderColor ?? AppColors.primary)
                : Colors.transparent,
          ),
        ),
      ),
      child: Padding(
        padding: contentPadding ?? const EdgeInsets.symmetric(vertical: 18),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (text != null)
              icon != null
                  ? Text(
                      text ?? "",
                      style: style ??
                          CustomTextStyle.font600sized16White.copyWith(
                            color: textColor ?? AppColors.white,
                          ),
                      maxLines: 2,
                      textAlign: TextAlign.center,
                    )
                  : Expanded(
                      child: Text(
                        text ?? "",
                        style: style ??
                            CustomTextStyle.font600sized16White.copyWith(
                              color: textColor ?? AppColors.white,
                            ),
                        maxLines: 2,
                        textAlign: TextAlign.center,
                      ),
                    ),
            if (icon != null && text != null) SizedBox(width: 8.w),
            icon ?? const SizedBox(),
          ],
        ),
      ),
    );
  }
}
