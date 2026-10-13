import 'dart:developer';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../app/app.dart';
import 'local_notification_service.dart';

class NotificationHandler {
  static FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
  static String? fcmToken = '';

  static Future init() async {
    try {
      await firebaseMessaging.requestPermission(
        alert: true,
        announcement: true,
        badge: true,
        carPlay: true,
        criticalAlert: true,
        provisional: true,
        sound: true,
      );

      // Get the token
      if (Platform.isIOS) {
        try {
          await firebaseMessaging.getAPNSToken();
          fcmToken = await getToken();
        } on Exception catch (e) {
          log('Error getting iOS FCM token: $e');
        }
      } else {
        fcmToken = await getToken();
      }

      // Background message handler
      FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);

      // ── iOS Foreground Notification Presentation ────────────────────
      // Enable iOS to show notifications while app is in foreground.
      // This is required for notifications to appear when app is open.
      await FirebaseMessaging.instance
          .setForegroundNotificationPresentationOptions(
        alert: true,
        badge: true,
        sound: true,
      );

      // Foreground notifications
      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        // On iOS, FCM automatically displays the notification via
        // setForegroundNotificationPresentationOptions, so we only need
        // to show local notification on Android to avoid duplicates.
        if (Platform.isAndroid) {
          LocalNotificationService.showBasicNotification(message);
        }
        if (!kReleaseMode) {
          log('Notification onMessage: ${message.notification?.title}');
          log('Notification Data: ${message.data}');
          // Log if image is present
          if (message.data['image'] != null) {
            log('📸 Image URL: ${message.data['image']}');
          }
        }
      });

      // Handle when app is opened from a notification (background)
      FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
        _handleNavigation(message.data);
      });

      // Handle initial message when app is launched from terminated state
      final RemoteMessage? initialMessage =
          await FirebaseMessaging.instance.getInitialMessage();
      if (initialMessage != null) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          _handleNavigation(initialMessage.data);
        });
      }
    } catch (e) {
      log('Error initializing Firebase Messaging: $e');
      // Continue app execution even if FCM fails
    }
  }

  static Future<void> handleBackgroundMessage(RemoteMessage message) async {
    // ── FIX #2 – Prevent duplicate background notifications ────────────
    // When a push includes a `notification` payload, Android and iOS
    // automatically display a system notification while the app is in
    // the background or terminated. Calling showBasicNotification here
    // would create a SECOND (often silent/empty) notification.
    // We only create a manual local notification for DATA-ONLY messages
    // (no `notification` field), which the system does not auto-display.
    if (message.notification == null) {
      LocalNotificationService.showBasicNotification(message);
    }

    if (!kReleaseMode) {
      log('Background Notification: ${message.notification?.title}');
      if (message.data['image'] != null) {
        log('📸 Background Image URL: ${message.data['image']}');
      }
    }
  }

  static Future<String?> getToken() async {
    try {
      final String? token = await firebaseMessaging.getToken();
      fcmToken = token;
      log('FCM Token: $token');
      return token;
    } catch (e) {
      log('Error getting FCM token: $e');
      return null;
    }
  }

  static void _handleNavigation(Map<String, dynamic> data) {
    if (navigatorKey.currentState != null && data.isNotEmpty) {
      LocalNotificationService.navigateBasedOnPayload(data);
    } else {
      log('Navigator state is null or data is empty: $data');
      // Delay navigation for terminated state
      Future.delayed(const Duration(milliseconds: 500), () {
        if (navigatorKey.currentState != null && data.isNotEmpty) {
          LocalNotificationService.navigateBasedOnPayload(data);
        }
      });
    }
  }

  //!Delete Token on logout
  static Future<void> deleteToken() async {
    try {
      await firebaseMessaging.deleteToken();
      fcmToken = null;
      log('FCM Token deleted');
    } catch (e) {
      log('Error deleting FCM token: $e');
    }
  }
}
