import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../connection/network_info.dart';
import '../locale/app_locale.dart';
import '../services/service_locator.dart';
import '../utils/app_strings.dart';
import '../widgets/custom_loading_indicator.dart';

// Future<bool> requestLocationPermission(BuildContext context) async {
//   final Location location = Location();

//   showLoadingDialog(context);

//   try {
//     // 1️⃣ Check if location service is enabled
//     bool serviceEnabled = await location.serviceEnabled();
//     if (!serviceEnabled) {
//       serviceEnabled = await location.requestService();
//       if (!serviceEnabled) {
//         Navigator.pop(context);
//         return false;
//       }
//     }

//     // 2️⃣ Check permission status
//     PermissionStatus permissionStatus = await location.hasPermission();

//     if (permissionStatus == PermissionStatus.denied) {
//       permissionStatus = await location.requestPermission();
//     }

//     // 3️⃣ Handle permission result
//     if (permissionStatus == PermissionStatus.granted ||
//         permissionStatus == PermissionStatus.grantedLimited) {
//       await context.read<GlobalCubit>().getCurrentLocation();
//       Navigator.pop(context);
//       return true;
//     }

//     // 4️⃣ Permission denied forever
//     if (permissionStatus == PermissionStatus.deniedForever) {
//       Navigator.pop(context);
//       _showPermissionDeniedDialog(context);
//       return false;
//     }

//     Navigator.pop(context);
//     return false;
//   } catch (e) {
//     Navigator.pop(context);
//     log('Location permission error: $e');
//     return false;
//   }
// }

// void _showPermissionDeniedDialog(BuildContext context) {
//   showDialog(
//     context: context,
//     builder: (_) => AlertDialog(
//       insetPadding: EdgeInsets.symmetric(horizontal: 16.w),
//       title: Text(AppStrings.locationPermissionRequired.tr(context)),
//       content: Text(
//         AppStrings.locationPermissionRequiredDescription.tr(context),
//       ),
//       actions: [
//         TextButton(
//           onPressed: () => Navigator.pop(context),
//           child: Text(AppStrings.cancel.tr(context)),
//         ),
//         TextButton(
//           onPressed: () async {
//             Navigator.pop(context);
//             await permission_handler.openAppSettings();
//           },
//           child: Text(
//             AppStrings.settings.tr(context),
//           ),
//         ),
//       ],
//     ),
//   );
// }

//! Check Network Connectivity
Future<bool> checkNetworkConnectivity() async {
  try {
    final bool isConnected = await sl<NetworkInfoImpl>().isConnected;
    return isConnected;
  } catch (e) {
    log("Network check failed: $e");
    return false;
  }
}

//! Show a loading dialog
Future<void> showLoadingDialog(BuildContext context, {String? message}) async {
  return showDialog(
    context: context,
    barrierDismissible: false,
    builder: (_) => Dialog(
      insetPadding: EdgeInsets.symmetric(horizontal: 150.w),
      child: const CustomLoadingIndicator(),
    ),
  );
}

// Future<MultipartFile?> uploadFileToAPI(
//   XFile? file, {
//   String fallbackMimeType = 'application/octet-stream',
// }) async {
//   if (file == null) {
//     return null;
//   }
//   final String? mimeType = lookupMimeType(file.path);
//   return MultipartFile.fromFile(
//     file.path,
//     filename: file.path.split('/').last,
//     contentType: MediaType.parse(
//       mimeType ?? fallbackMimeType,
//     ), // defaulting to image/jpeg if not found
//   );
// }

// //! Upload Image To API
// Future<MultipartFile?> uploadImageToAPI(XFile? image) async {
//   return uploadFileToAPI(
//     image,
//     fallbackMimeType: 'image/jpeg',
//   );
// }

// //! Upload Video To API
// Future<MultipartFile?> uploadVideoToAPI(XFile? video) async {
//   return uploadFileToAPI(
//     video,
//     fallbackMimeType: 'video/mp4',
//   );
// }

// //! Format Dates and Times
// String? displayDate(DateTime? dateTime) {
//   if (dateTime == null) {
//     return null;
//   }
//   return DateFormat('yyyy-MM-dd').format(dateTime);
// }

int getHourFromTimeOfDay(TimeOfDay? time) {
  return time?.hourOfPeriod ?? 0;
}

int getMinuteFromTimeOfDay(TimeOfDay time) {
  return time.minute;
}

String getPeriodFromTimeOfDay(TimeOfDay time) {
  return time.period == DayPeriod.am ? 'AM' : 'PM';
}

// String timeAgo(String input, String locale) {
//   final dateTime = parseTime(input);
//   final now = DateTime.now();
//   final diff = now.difference(dateTime);

//   if (diff.inSeconds < 60) return locale == 'ar' ? 'الآن' : 'Just now';
//   if (diff.inMinutes < 60) {
//     return locale == 'ar'
//         ? 'منذ ${diff.inMinutes} دقيقة'
//         : '${diff.inMinutes} min ago';
//   }
//   if (diff.inHours < 24) {
//     return locale == 'ar'
//         ? 'منذ ${diff.inHours} ساعة'
//         : '${diff.inHours} hour${diff.inHours == 1 ? '' : 's'} ago';
//   }
//   if (diff.inDays == 1) return locale == 'ar' ? 'أمس' : 'Yesterday';
//   if (diff.inDays < 7) {
//     return locale == 'ar'
//         ? 'منذ ${diff.inDays} أيام'
//         : '${diff.inDays} days ago';
//   }
//   if (diff.inDays < 14) return locale == 'ar' ? 'منذ أسبوع' : '1 week ago';
//   if (diff.inDays < 30) {
//     final weeks = (diff.inDays / 7).floor();
//     return locale == 'ar' ? 'منذ $weeks أسابيع' : '$weeks weeks ago';
//   }

//   final format = DateFormat('dd MMM yyyy', locale);
//   return format.format(dateTime);
// }

DateTime parseTime(String utcTimestamp) {
  final DateTime utcTime = DateTime.parse(utcTimestamp);
  return utcTime;
}

String getFormattedTime(TimeOfDay? time, BuildContext context) {
  if (time == null) {
    return AppStrings.selectTime.tr(context);
  }
  final hour = time.hourOfPeriod == 0 ? 12 : time.hourOfPeriod;
  final period = time.period == DayPeriod.am ? 'AM' : 'PM';
  return '${hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')} $period';
}

String convert24To12(String? time) {
  if (time == null || time.isEmpty) {
    return '--:--';
  }
  if (time.toLowerCase().contains('am') || time.toLowerCase().contains('pm')) {
    return time;
  }

  final parts = time.split(':');
  int hour = int.parse(parts[0]);
  final int minute = int.parse(parts[1]);

  final String period = hour >= 12 ? 'PM' : 'AM';

  hour = hour % 12;
  if (hour == 0) hour = 12;

  final formattedMinute = minute.toString().padLeft(2, '0');
  return '$hour:$formattedMinute $period';
}

// Future launchCustomUrl(context, String? url) async {
//   if (url != null) {
//     final Uri uri = Uri.parse(url);
//     await launchUrl(uri);
//   }
// }

// Future<XFile?> compressImage(XFile file, {int quality = 50}) async {
//   final dir = await getTemporaryDirectory();
//   final targetPath = p.join(
//     dir.path,
//     "${DateTime.now().millisecondsSinceEpoch}.jpg",
//   );

//   final compressedFile = await FlutterImageCompress.compressAndGetFile(
//     file.path,
//     targetPath,
//     quality: quality,
//   );

//   return compressedFile != null ? XFile(compressedFile.path) : null;
// }

// Future<void> launchPhoneDialer(context, String phoneNumber) async {
//   final Uri launchUri = Uri(scheme: 'tel', path: phoneNumber);
//   await launchUrl(launchUri);
// }

// Future<void> launchWhatsApp(context, String phoneNumber) async {
//   final Uri launchUri = Uri(scheme: 'https', host: 'wa.me', path: phoneNumber);

//   await launchUrl(launchUri);
// }

// Future<void> launchEmail(String email) async {
//   final Uri emailUri = Uri(scheme: 'mailto', path: email);

//   await launchUrl(emailUri);
// }

//! Vibrate
void vibrate() async {
  try {
    await HapticFeedback.heavyImpact();
  } catch (e) {
    log('Error with vibrate: $e');
  }
}

bool getIsArabic(String text) {
  final arabicRegex = RegExp(r'[\u0600-\u06FF]');
  return arabicRegex.hasMatch(text);
}
