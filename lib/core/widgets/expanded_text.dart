import 'package:flutter/material.dart';

import '../common/common.dart';
import '../locale/app_locale.dart';
import '../theme/app_theme.dart';
import '../utils/app_strings.dart';
import '../utils/app_text_styles.dart';

class ExpandedText extends StatefulWidget {
  const ExpandedText(
      {super.key,
      required this.text,
      this.textColor,
      this.maxLengthIfNotExpanded,
      this.lenghtToKeep});
  final String text;
  final Color? textColor;
  final int? maxLengthIfNotExpanded;
  final int? lenghtToKeep;

  @override
  State<ExpandedText> createState() => _ExpandedTextState();
}

class _ExpandedTextState extends State<ExpandedText> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final String displayText = isExpanded
        ? widget.text
        : widget.text.length > (widget.maxLengthIfNotExpanded ?? 200)
            ? '${widget.text.substring(0, widget.lenghtToKeep ?? 150)}...'
            : widget.text;

    return GestureDetector(
      onTap: () {
        setState(() {
          isExpanded = !isExpanded;
        });
      },
      child: RichText(
        textAlign: getIsArabic(widget.text) ? TextAlign.right : TextAlign.left,
        text: TextSpan(
          children: [
            TextSpan(
              text: displayText,
              style: CustomTextStyle.font400sized14Black.copyWith(
                fontFamily: getFontName(
                    language: getIsArabic(widget.text) ? "ar" : "en"),
                color: widget.textColor,
              ),
            ),
            if (widget.text.length > (widget.maxLengthIfNotExpanded ?? 200))
              TextSpan(
                text: isExpanded
                    ? " ${AppStrings.readLess.tr(context)}"
                    : " ${AppStrings.readMore.tr(context)}",
                style: CustomTextStyle.font500sized14Primary.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
