import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../locale/app_locale.dart';
import '../utils/app_colors.dart';
import '../utils/app_strings.dart';
import 'custom_elevated_button.dart';

class CustomDatePicker extends StatefulWidget {
  const CustomDatePicker({
    super.key,
    this.selectedDate,
    required this.firstDate,
  });

  final DateTime? selectedDate;
  final DateTime firstDate;

  @override
  State<CustomDatePicker> createState() => _CustomDatePickerState();
}

class _CustomDatePickerState extends State<CustomDatePicker> {
  late DateTime selectedDate;

  @override
  void initState() {
    selectedDate = widget.selectedDate ?? widget.firstDate;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 8.h, left: 16.w, right: 16.w, bottom: 24.h),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(50.r),
          topRight: Radius.circular(50.r),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: 8.h),
          Container(
            width: 50.w,
            height: 5.h,
            decoration: BoxDecoration(
              color: AppColors.lightGrey,
              borderRadius: BorderRadius.circular(10.r),
            ),
          ),
          SizedBox(height: 6.h),
          Theme(
            data: ThemeData(
              primaryColor: AppColors.primary,
              datePickerTheme: DatePickerThemeData(
                todayBackgroundColor: WidgetStateColor.resolveWith((states) {
                  if (states.contains(WidgetState.selected)) {
                    return AppColors.primary;
                  }
                  return Colors.transparent;
                }),
                todayForegroundColor: WidgetStateColor.resolveWith((states) {
                  if (states.contains(WidgetState.selected)) {
                    return Colors.white;
                  }
                  return AppColors.primary;
                }),
                dayForegroundColor: WidgetStateColor.resolveWith((states) {
                  if (states.contains(WidgetState.disabled)) {
                    return AppColors.grey;
                  }
                  if (states.contains(WidgetState.selected)) {
                    return Colors.white;
                  }
                  return Colors.black;
                }),
                dayBackgroundColor: WidgetStateColor.resolveWith((states) {
                  if (states.contains(WidgetState.selected)) {
                    return AppColors.primary;
                  }
                  return Colors.transparent;
                }),
              ),
            ),
            child: CalendarDatePicker(
              initialDate: selectedDate,
              firstDate: widget.firstDate,
              lastDate: widget.firstDate.add(const Duration(days: 365)),
              onDateChanged: (newDate) {
                selectedDate = newDate;
              },
            ),
          ),
          CustomElevatedButton(
            onPressed: () {
              Navigator.pop(context, selectedDate);
            },
            text: AppStrings.confirm.tr(context),
          ),
        ],
      ),
    );
  }
}
