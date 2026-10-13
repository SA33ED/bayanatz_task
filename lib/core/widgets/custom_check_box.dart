import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../utils/app_colors.dart';
import '../utils/app_text_styles.dart';

class CustomCheckBox extends StatefulWidget {
  const CustomCheckBox({
    super.key,
    required this.onTap,
    required this.value,
    this.title,
  });

  final Function(bool) onTap;
  final bool value;
  final String? title;

  @override
  State<CustomCheckBox> createState() => _CustomCheckBoxState();
}

class _CustomCheckBoxState extends State<CustomCheckBox> {
  late bool value;

  @override
  void initState() {
    super.initState();
    value = widget.value;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          value = !value;
          widget.onTap(value);
        });
      },
      child: Row(
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            height: 20.h,
            width: 20.h,
            decoration: BoxDecoration(
              color: value ? AppColors.primary : AppColors.white,
              borderRadius: BorderRadius.circular(20.r),
              border: Border.all(
                color: value ? AppColors.primary : AppColors.black,
              ),
            ),
            child: value
                ? Icon(
                    Icons.done,
                    color: AppColors.white,
                    size: 16.h,
                  )
                : const SizedBox.shrink(),
          ),
          if (widget.title != null)
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.w),
              child: Text(
                widget.title!,
                style: CustomTextStyle.font400sized12Black,
              ),
            ),
        ],
      ),
    );
  }
}
