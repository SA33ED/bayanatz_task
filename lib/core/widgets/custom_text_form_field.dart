import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../utils/app_colors.dart';
import '../utils/app_text_styles.dart';

class CustomTextFormField extends StatefulWidget {
  const CustomTextFormField({
    super.key,
    this.hintText,
    this.labelText,
    this.controller,
    this.maxLines,
    this.validator,
    this.obscureText,
    this.prefixIcon,
    this.suffixIcon,
    this.suffixIconColor,
    this.prefixIconColor,
    this.keyboardType,
    this.autofocus,
    this.contentPadding,
    this.textInputAction,
    this.hintStyle,
    this.enabled,
    this.borderRadius,
    this.floatingLabelBehavior,
    this.borderColor,
    this.onFieldSubmitted,
    this.onChanged,
    this.onFinishTyping,
    this.debounceDelay,
    this.filled,
    this.fillColor,
    this.style,
    this.inputFormatters,
    this.focusNode,
    this.readOnly,
    this.onTap,
  });
  final String? hintText;
  final String? labelText;
  final bool? obscureText;
  final bool? filled;
  final int? maxLines;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final Color? suffixIconColor;
  final Color? prefixIconColor;
  final Color? borderColor;
  final Color? fillColor;
  final TextInputType? keyboardType;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final bool? autofocus;
  final TextStyle? style;
  final EdgeInsetsGeometry? contentPadding;
  final TextStyle? hintStyle;
  final TextInputAction? textInputAction;
  final bool? enabled;
  final double? borderRadius;
  final FloatingLabelBehavior? floatingLabelBehavior;
  final Function(String)? onFieldSubmitted;
  final Function(String)? onChanged;
  final Function(String)? onFinishTyping;
  final Duration? debounceDelay;
  final List<TextInputFormatter>? inputFormatters;
  final FocusNode? focusNode;
  final bool? readOnly;
  final VoidCallback? onTap;

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  Timer? _debounceTimer;

  @override
  void dispose() {
    _debounceTimer?.cancel();
    super.dispose();
  }

  void _onTextChanged(String value) {
    // Call the original onChanged if provided
    widget.onChanged?.call(value);

    // Handle the debounce logic for onFinishTyping
    if (widget.onFinishTyping != null) {
      _debounceTimer?.cancel();
      _debounceTimer = Timer(
        widget.debounceDelay ?? const Duration(milliseconds: 500),
        () {
          widget.onFinishTyping?.call(value);
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      inputFormatters: widget.inputFormatters,
      autofocus: widget.autofocus ?? false,
      keyboardType: widget.keyboardType,
      maxLines: widget.maxLines,
      validator: widget.validator,
      focusNode: widget.focusNode,
      readOnly: widget.readOnly ?? false,
      onTap: widget.onTap,
      onChanged: _onTextChanged,
      style: widget.style ?? CustomTextStyle.font400sized14Black,
      cursorColor: AppColors.primary,
      obscureText: widget.obscureText ?? false,
      controller: widget.controller,
      enabled: widget.enabled,
      textInputAction: widget.textInputAction,
      onFieldSubmitted: widget.onFieldSubmitted,
      decoration: InputDecoration(
        floatingLabelBehavior:
            widget.floatingLabelBehavior ?? FloatingLabelBehavior.auto,
        contentPadding: widget.contentPadding ?? EdgeInsets.all(16.w),
        border: getBorderStyle(
          context,
          widget.borderRadius,
          widget.borderColor,
        ),
        enabledBorder: getBorderStyle(
          context,
          widget.borderRadius,
          widget.borderColor,
        ),
        focusedBorder: getBorderStyle(
          context,
          widget.borderRadius,
          widget.borderColor,
        ),
        errorBorder: getBorderStyle(
          context,
          widget.borderRadius,
          widget.borderColor,
        ),
        disabledBorder: getBorderStyle(
          context,
          widget.borderRadius,
          widget.borderColor,
        ),
        focusedErrorBorder: getBorderStyle(
          context,
          widget.borderRadius,
          widget.borderColor,
        ),
        errorMaxLines: 5,
        labelText: widget.labelText,
        hintText: widget.hintText,
        fillColor: widget.fillColor,
        filled: widget.filled,
        labelStyle: CustomTextStyle.font400sized14LightGrey,
        hintStyle: widget.hintStyle ?? CustomTextStyle.font400sized12Grey,
        prefixIcon: widget.prefixIcon,
        suffixIcon: widget.suffixIcon,
        suffixIconColor: widget.suffixIconColor ?? AppColors.grey,
        prefixIconColor: widget.prefixIconColor ?? AppColors.grey,
      ),
    );
  }
}

OutlineInputBorder getBorderStyle(
  BuildContext context,
  borderRadius,
  borderColor,
) {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(borderRadius ?? 8),
    borderSide: BorderSide(
      color: borderColor ?? AppColors.lightGrey,
      width: 0.5.w,
    ),
  );
}
