import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

import '../../app/app.dart';

class LocalNotificationService {
  static FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  static StreamController<NotificationResponse> streamController =
      StreamController.broadcast();

  // ─── Channel constants ──────────────────────────────────────────────────────
  // FIX #1 & #4 – A new channel ID guarantees we are not reusing an old,
  // silently-cached channel from a previous build. Android caches channel
  // settings on first creation and never updates them, so changing the ID
  // is the only reliable way to enforce sound / vibration / importance.
  static const String _channelId = 'maxliss_high_importance_v2';
  static const String _channelName = 'Maxliss Notifications';
  static const String _channelDescription =
      'Push notifications for the Maxliss app';

  // ─── Deduplication guard ────────────────────────────────────────────────────
  // FIX #3 – Keeps track of recently processed FCM messageIds so the same
  // notification is never shown twice (e.g. background isolate re-trigger,
  // or the system delivering the same message to multiple callbacks).
  static final Set<String> _processedMessageIds = {};
  static const int _maxDedupEntries = 200;

  static void onTap(NotificationResponse notificationResponse) {
    final Map<String, dynamic>? map = jsonDecode(
      notificationResponse.payload ?? "{}",
    );
    if (map!.isNotEmpty && navigatorKey.currentState != null) {
      navigateBasedOnPayload(map);
    } else {
      log(
        'Tap handled but no navigation: map=$map, navigatorState=${navigatorKey.currentState}',
      );
      Future.delayed(const Duration(seconds: 1), () {
        if (navigatorKey.currentState != null && map.isNotEmpty) {
          navigateBasedOnPayload(map);
        }
      });
    }
  }

  static void navigateBasedOnPayload(Map<String, dynamic> map) {
    if (map['request_id'] != null) {
      try {
        // Do somthing
      } on Exception catch (e) {
        log('Navigation error: $e');
      }
    }
  }

  static Future init() async {
    // ── FIX #1 & #4 – Explicitly create the Android notification channel ────
    // Android 8+ caches channel settings on first creation and never updates
    // them afterwards. By deleting the OLD channel and creating a NEW one with
    // a fresh ID, we guarantee sound, vibration, and max importance are set
    // correctly – which is required for heads-up popup display.
    if (Platform.isAndroid) {
      final AndroidFlutterLocalNotificationsPlugin? androidPlugin =
          flutterLocalNotificationsPlugin
              .resolvePlatformSpecificImplementation<
                AndroidFlutterLocalNotificationsPlugin
              >();

      if (androidPlugin != null) {
        // Remove any legacy silent channel from older builds.
        await androidPlugin.deleteNotificationChannel(channelId: 'channel_id');

        // Create the channel with all heads-up prerequisites.
        const AndroidNotificationChannel channel = AndroidNotificationChannel(
          _channelId,
          _channelName,
          description: _channelDescription,
          importance: Importance.max, // Required for heads-up
          playSound: true, // Ensures audible alert
          enableVibration: true, // Tactile feedback
          enableLights: true,
          showBadge: true,
        );
        await androidPlugin.createNotificationChannel(channel);
      }
    }

    // ── Platform initialization settings ────────────────────────────────────
    const InitializationSettings settings = InitializationSettings(
      android: AndroidInitializationSettings('@mipmap/ic_launcher'),
      iOS: DarwinInitializationSettings(),
    );
    await flutterLocalNotificationsPlugin.initialize(
      settings: settings,
      onDidReceiveNotificationResponse: onTap,
      onDidReceiveBackgroundNotificationResponse: onTap,
    );

    streamController.stream.listen((response) {
      onTap(response);
    });
  }

  // ─── Stable notification ID ───────────────────────────────────────────────
  // FIX #3 – The old `millisecondsSinceEpoch.remainder(100000)` approach
  // caused ID collisions (max 100 000 values) leading to dismissed
  // notifications being overwritten and re-appearing as blank entries.
  // Using the FCM messageId hash gives a deterministic, collision-resistant ID.
  static int _notificationId(RemoteMessage message) {
    if (message.messageId != null && message.messageId!.isNotEmpty) {
      // hashCode is stable for the same string within a single runtime,
      // and provides much better distribution than a small remainder.
      return message.messageId!.hashCode.abs();
    }
    // Fallback: microseconds with full int range (avoid small remainder).
    return DateTime.now().microsecondsSinceEpoch.remainder(2147483647);
  }

  // ─── Dedup check ──────────────────────────────────────────────────────────
  // FIX #3 – Prevents the same notification from being displayed more than
  // once, which can happen when the background isolate re-fires or the same
  // message is delivered to multiple listeners.
  static bool _shouldShow(RemoteMessage message) {
    final String? id = message.messageId;
    if (id == null || id.isEmpty) return true; // cannot dedup without an ID

    if (_processedMessageIds.contains(id)) {
      log('⚠️ Duplicate notification suppressed (messageId=$id)');
      return false;
    }

    _processedMessageIds.add(id);

    // Prevent unbounded growth in long-running sessions.
    if (_processedMessageIds.length > _maxDedupEntries) {
      _processedMessageIds.remove(_processedMessageIds.first);
    }

    return true;
  }

  static void showBasicNotification(RemoteMessage message) async {
    // FIX #3 – Dedup guard: skip if this message was already displayed.
    if (!_shouldShow(message)) return;

    try {
      // Check if the message contains an image
      final String? imageUrl = message.data['image'];

      if (imageUrl != null && imageUrl.isNotEmpty) {
        // Show notification with image
        await _showImageNotification(message, imageUrl);
      } else {
        // Show regular notification without image
        await _showRegularNotification(message);
      }
    } catch (e) {
      log('Error showing notification: $e');
      // Fallback to regular notification if image fails
      await _showRegularNotification(message);
    }
  }

  /// Show regular notification without image
  static Future<void> _showRegularNotification(RemoteMessage message) async {
    // FIX #1 & #4 – Using the explicitly-created channel with sound,
    // vibration, and max importance to guarantee heads-up display.
    const AndroidNotificationDetails android = AndroidNotificationDetails(
      _channelId,
      _channelName,
      channelDescription: _channelDescription,
      importance: Importance.max,
      priority: Priority.high,
      icon: "@drawable/ic_notification",
      playSound: true,
      enableVibration: true,
      enableLights: true,
    );

    const DarwinNotificationDetails iOS = DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
      sound: 'default',
    );

    const NotificationDetails details = NotificationDetails(
      android: android,
      iOS: iOS,
    );

    await flutterLocalNotificationsPlugin.show(
      id: _notificationId(message), // FIX #3 – stable unique ID
      title: message.notification?.title,
      body: message.notification?.body,
      notificationDetails: details,
      payload: jsonEncode(message.data),
    );
  }

  /// Show notification with image
  static Future<void> _showImageNotification(
    RemoteMessage message,
    String imageUrl,
  ) async {
    try {
      // Download image
      final String? imagePath = await _downloadAndSaveImage(imageUrl);

      if (imagePath != null) {
        // Android notification with big picture
        // FIX #1 & #4 – Same channel & heads-up settings as regular notifications.
        final AndroidNotificationDetails androidDetails =
            AndroidNotificationDetails(
              _channelId,
              _channelName,
              channelDescription: _channelDescription,
              importance: Importance.max,
              priority: Priority.high,
              icon: "@drawable/ic_notification",
              styleInformation: BigPictureStyleInformation(
                FilePathAndroidBitmap(imagePath),
                largeIcon: FilePathAndroidBitmap(imagePath),
                contentTitle: message.notification?.title,
                htmlFormatContentTitle: true,
                summaryText: message.notification?.body,
                htmlFormatSummaryText: true,
              ),
              playSound: true,
              enableVibration: true,
              enableLights: true,
            );

        // iOS notification with attachment
        final List<DarwinNotificationAttachment> attachments = [
          DarwinNotificationAttachment(imagePath),
        ];

        final DarwinNotificationDetails iOSDetails = DarwinNotificationDetails(
          presentAlert: true,
          presentBadge: true,
          presentSound: true,
          sound: 'default',
          attachments: attachments,
        );

        final NotificationDetails notificationDetails = NotificationDetails(
          android: androidDetails,
          iOS: iOSDetails,
        );

        await flutterLocalNotificationsPlugin.show(
          id: _notificationId(message), // FIX #3 – stable unique ID
          title: message.notification?.title,
          body: message.notification?.body,
          notificationDetails: notificationDetails,
          payload: jsonEncode(message.data),
        );

        log('✅ Image notification displayed successfully');
      } else {
        log('⚠️ Failed to download image, showing regular notification');
        await _showRegularNotification(message);
      }
    } catch (e) {
      log('❌ Error in _showImageNotification: $e');
      await _showRegularNotification(message);
    }
  }

  /// Download and save image for notification
  static Future<String?> _downloadAndSaveImage(String imageUrl) async {
    try {
      log('📥 Downloading image: $imageUrl');

      final http.Response response = await http
          .get(
            Uri.parse(imageUrl),
            headers: {
              'User-Agent': 'Mozilla/5.0 (compatible; Flutter notification)',
            },
          )
          .timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        final Directory tempDir = await getTemporaryDirectory();
        final String fileName =
            'notification_${DateTime.now().millisecondsSinceEpoch}.png';
        final File file = File('${tempDir.path}/$fileName');

        await file.writeAsBytes(response.bodyBytes);
        log('✅ Image saved to: ${file.path}');
        return file.path;
      } else {
        log('❌ Failed to download image. Status code: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      log('❌ Exception downloading image: $e');
      return null;
    }
  }
}
