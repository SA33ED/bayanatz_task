import 'package:flutter/material.dart';

import '../cubit/global_cubit.dart';
import '../services/service_locator.dart';
import '../utils/app_colors.dart';
import '../utils/app_text_styles.dart';

ThemeData getAppTheme() {
  return ThemeData(
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.transparent,
      elevation: 0,
      iconTheme: IconThemeData(color: AppColors.black),
      scrolledUnderElevation: 0,
      centerTitle: true,
    ),
    drawerTheme: const DrawerThemeData(backgroundColor: AppColors.white),
    scaffoldBackgroundColor: Colors.white,
    canvasColor: AppColors.primary,
    fontFamily: getFontName(),
    colorScheme: const ColorScheme(
      primary: AppColors.primary,
      onPrimary: AppColors.white,
      secondary: AppColors.white,
      brightness: Brightness.light,
      onSecondary: AppColors.white,
      error: AppColors.red,
      onError: AppColors.red,
      surface: AppColors.white,
      onSurface: AppColors.black,
    ),
    textTheme: ThemeData.dark().textTheme.apply(
      bodyColor: AppColors.black,
      displayColor: AppColors.black,
      fontFamily: getFontName(),
    ),
    listTileTheme: ListTileThemeData(
      titleTextStyle: CustomTextStyle.font400sized14Black.copyWith(
        color: AppColors.black,
        fontFamily: getFontName(),
      ),
    ),
    datePickerTheme: DatePickerThemeData(
      // dayBackgroundColor: WidgetStateProperty.resolveWith<Color>(
      //   (Set<WidgetState> states) {
      //     if (states.contains(WidgetState.disabled)) {
      //       return AppColors.white; // Color for unclickable days
      //     }
      //     return AppColors.primary; // Default color for clickable days
      //   },
      // ),
      dayForegroundColor: WidgetStateProperty.resolveWith<Color>((
        Set<WidgetState> states,
      ) {
        if (states.contains(WidgetState.selected)) {
          return AppColors.white; // Color for unclickable days
        }
        if (states.contains(WidgetState.disabled)) {
          return AppColors.grey; // Color for unclickable days
        }
        return AppColors.primary; // Default color for clickable days
      }),
      dayStyle: CustomTextStyle.font700sized18Black,
      yearStyle: CustomTextStyle.font400sized14Black,
      weekdayStyle: CustomTextStyle.font400sized14Black.copyWith(
        color: AppColors.grey,
      ),

      rangeSelectionOverlayColor: const WidgetStatePropertyAll(AppColors.black),
      headerHelpStyle: CustomTextStyle.font400sized14Black,
      headerHeadlineStyle: CustomTextStyle.font400sized14Black,
      rangePickerHeaderHeadlineStyle: CustomTextStyle.font400sized14Black,
      rangePickerHeaderHelpStyle: CustomTextStyle.font400sized14Black,
    ),
  );
}

String getFontName({String? language}) {
  final String languageForCheck = language ?? sl<GlobalCubit>().language;
  if (languageForCheck == "en") {
    return "Jost";
  } else {
    return "Beiruti";
  }
}
