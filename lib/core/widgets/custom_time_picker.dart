import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../common/common.dart';
import '../locale/app_locale.dart';
import '../utils/app_colors.dart';
import '../utils/app_strings.dart';
import '../utils/app_text_styles.dart';
import 'custom_elevated_button.dart';

class CustomTimePicker extends StatefulWidget {
  const CustomTimePicker({
    super.key,
    this.selectedTime,
    this.firstTime,
    this.lastTime,
  });
  final TimeOfDay? selectedTime;
  final TimeOfDay? firstTime;
  final TimeOfDay? lastTime;

  @override
  State<CustomTimePicker> createState() => _CustomTimePickerState();
}

class _CustomTimePickerState extends State<CustomTimePicker> {
  late TimeOfDay selectedTime;
  late FixedExtentScrollController hourController;
  late FixedExtentScrollController minuteController;

  @override
  void initState() {
    selectedTime = widget.selectedTime ?? TimeOfDay.now();
    hourController = FixedExtentScrollController(
      initialItem: _getValidHourIndex(selectedTime.hour),
    );
    minuteController = FixedExtentScrollController(
      initialItem: selectedTime.minute,
    );
    super.initState();
  }

  @override
  void dispose() {
    hourController.dispose();
    minuteController.dispose();
    super.dispose();
  }

  int _getValidHourIndex(int hour) {
    final validHours = _getValidHours();
    final index = validHours.indexOf(hour);
    return index >= 0 ? index : 0;
  }

  List<int> _getValidHours() {
    final hours = <int>[];
    for (int h = 0; h < 24; h++) {
      final candidate = TimeOfDay(hour: h, minute: selectedTime.minute);
      if (_isWithinRange(candidate)) {
        hours.add(h);
      }
    }
    return hours.isEmpty ? [selectedTime.hour] : hours;
  }

  List<int> _getValidMinutes() {
    final minutes = <int>[];
    for (int m = 0; m < 60; m++) {
      final candidate = TimeOfDay(hour: selectedTime.hour, minute: m);
      if (_isWithinRange(candidate)) {
        minutes.add(m);
      }
    }
    return minutes.isEmpty ? [selectedTime.minute] : minutes;
  }

  bool _isAfterOrEqual(TimeOfDay a, TimeOfDay b) =>
      a.hour > b.hour || (a.hour == b.hour && a.minute >= b.minute);

  bool _isBeforeOrEqual(TimeOfDay a, TimeOfDay b) =>
      a.hour < b.hour || (a.hour == b.hour && a.minute <= b.minute);

  bool _isWithinRange(TimeOfDay newTime) {
    if (widget.firstTime != null &&
        !_isAfterOrEqual(newTime, widget.firstTime!)) {
      return false;
    }
    if (widget.lastTime != null &&
        !_isBeforeOrEqual(newTime, widget.lastTime!)) {
      return false;
    }
    return true;
  }

  void _onHourChanged(int index) {
    final validHours = _getValidHours();
    if (index >= 0 && index < validHours.length) {
      setState(() {
        selectedTime = TimeOfDay(
          hour: validHours[index],
          minute: selectedTime.minute,
        );
      });
      // Refresh minutes if needed
      final validMinutes = _getValidMinutes();
      if (!validMinutes.contains(selectedTime.minute)) {
        setState(() {
          selectedTime = TimeOfDay(
            hour: selectedTime.hour,
            minute: validMinutes.isNotEmpty ? validMinutes.first : 0,
          );
        });
        minuteController.jumpToItem(0);
      }
    }
  }

  void _onMinuteChanged(int index) {
    final validMinutes = _getValidMinutes();
    if (index >= 0 && index < validMinutes.length) {
      setState(() {
        selectedTime = TimeOfDay(
          hour: selectedTime.hour,
          minute: validMinutes[index],
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
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
        SizedBox(height: 12.h),
        Text(
          AppStrings.selectTime.tr(context),
          style: CustomTextStyle.font400sized16Black,
        ),
        SizedBox(height: 24.h),
        Directionality(
          textDirection: TextDirection.ltr,
          child: SizedBox(
            height: 180.h,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Hour Wheel
                SizedBox(
                  width: 60.w,
                  child: ListWheelScrollView.useDelegate(
                    controller: hourController,
                    itemExtent: 50.h,
                    perspective: 0.005,
                    diameterRatio: 1.2,
                    physics: const FixedExtentScrollPhysics(),
                    onSelectedItemChanged: _onHourChanged,
                    childDelegate: ListWheelChildBuilderDelegate(
                      childCount: _getValidHours().length,
                      builder: (context, index) {
                        final validHours = _getValidHours();
                        final hour = validHours[index];
                        final displayHour = getHourFromTimeOfDay(
                          TimeOfDay(hour: hour, minute: 0),
                        );
                        final isSelected = hour == selectedTime.hour;
                        return Center(
                          child: Text(
                            displayHour.toString().padLeft(2, '0'),
                            style: CustomTextStyle.font400sized18Black.copyWith(
                              fontSize: isSelected ? 24.sp : 18.sp,
                              fontWeight: isSelected
                                  ? FontWeight.w600
                                  : FontWeight.w400,
                              color: isSelected
                                  ? AppColors.black
                                  : AppColors.grey,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                SizedBox(width: 16.w),
                Text(
                  ":",
                  style: CustomTextStyle.font400sized18Black.copyWith(
                    fontSize: 24.sp,
                  ),
                ),
                SizedBox(width: 16.w),
                // Minute Wheel
                SizedBox(
                  width: 60.w,
                  child: ListWheelScrollView.useDelegate(
                    controller: minuteController,
                    itemExtent: 50.h,
                    perspective: 0.005,
                    diameterRatio: 1.2,
                    physics: const FixedExtentScrollPhysics(),
                    onSelectedItemChanged: _onMinuteChanged,
                    childDelegate: ListWheelChildBuilderDelegate(
                      childCount: _getValidMinutes().length,
                      builder: (context, index) {
                        final validMinutes = _getValidMinutes();
                        final minute = validMinutes[index];
                        final isSelected = minute == selectedTime.minute;
                        return Center(
                          child: Text(
                            minute.toString().padLeft(2, '0'),
                            style: CustomTextStyle.font400sized18Black.copyWith(
                              fontSize: isSelected ? 24.sp : 18.sp,
                              fontWeight: isSelected
                                  ? FontWeight.w600
                                  : FontWeight.w400,
                              color: isSelected
                                  ? AppColors.black
                                  : AppColors.grey,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                SizedBox(width: 16.w),
                Text(
                  getPeriodFromTimeOfDay(selectedTime).toString(),
                  style: CustomTextStyle.font400sized18Black,
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 24.h),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: CustomElevatedButton(
            onPressed: () {
              Navigator.pop(context, selectedTime);
            },
            text: AppStrings.confirm.tr(context),
          ),
        ),
        SizedBox(height: 16.h),
      ],
    );
  }
}
