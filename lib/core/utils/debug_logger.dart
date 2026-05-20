import 'package:flutter/foundation.dart';

class DebugLogger {
  static void log(String message) {
    if (kDebugMode) debugPrint('$message');
  }

  static void request(String message) {
    if (kDebugMode) debugPrint('$message');
  }

  static void response(String message) {
    if (kDebugMode) debugPrint('$message');
  }

  static void deepLink(String message) {
    if (kDebugMode) debugPrint('$message');
  }

  static void notification(String message) {
    if (kDebugMode) debugPrint('$message');
  }
}