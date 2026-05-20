import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import '../../../core/utils/debug_logger.dart';

class FcmService {
  static Future<void> initialize() async {
    final messaging = FirebaseMessaging.instance;

    await messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    if (kDebugMode) {
      final token = await messaging.getToken();
      DebugLogger.notification('FCM Token: $token');
    }

    FirebaseMessaging.onMessage.listen((message) {
      if (kDebugMode) {
        DebugLogger.notification('Foreground: ${message.notification?.title}');
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      if (kDebugMode) {
        DebugLogger.notification('Tapped: ${message.notification?.title}');
      }
    });
  }
}