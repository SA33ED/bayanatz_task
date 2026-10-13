import 'dart:convert';

import 'package:flutter/foundation.dart';

// Reset:   \x1B[0m
// Black:   \x1B[30m
// White:   \x1B[37m
// Red:     \x1B[31m
// Green:   \x1B[32m
// Yellow:  \x1B[33m
// Blue:    \x1B[34m
// Cyan:    \x1B[36m
class Print {
  // ANSI codes for colors
  static const String _ansiRESET = '\x1B[0m';
  static const String _ansiRED = '\x1B[31m';
  static const String _ansiGREEN = '\x1B[32m';
  static const String _ansiYELLOW = '\x1B[33m';
  static const String _ansiBLUE = '\x1B[34m';
  static const String _ansiPURPLE = '\x1B[35m';

  // Print success message (green)
  static void success(dynamic message) {
    final String formattedMessage = _formatMessage(message, _ansiGREEN);
    if (kDebugMode) {
      print("✅✅$formattedMessage");
    }
  }

  // Print fail message (red)
  static void error(dynamic message) {
    final String formattedMessage = _formatMessage(message, _ansiRED);
    if (kDebugMode) {
      print('❌❌$formattedMessage');
    }
  }

  // Print warning message (yellow)
  static void warning(dynamic message) {
    final String formattedMessage = _formatMessage(message, _ansiYELLOW);
    if (kDebugMode) {
      print('☢️☢️$formattedMessage');
    }
  }

  // Print info message (blue)
  static void info(dynamic message) {
    final String formattedMessage = _formatMessage(message, _ansiBLUE);
    if (kDebugMode) {
      print('🔵🔵$formattedMessage');
    }
  }

  // Print important message (purple)
  static void important(dynamic message) {
    final String formattedMessage = _formatMessage(message, _ansiPURPLE);
    if (kDebugMode) {
      print('💡 💡$formattedMessage');
    }
  }

  // Helper method to format the message
  static String _formatMessage(dynamic message, String color) {
    try {
      if (message is Map || message is List) {
        // var jsonObject = jsonDecode(message);
        final String formattedJson = const JsonEncoder.withIndent(
          '  ',
        ).convert(message);
        // Split the formatted JSON string into lines
        final List<String> lines = formattedJson.split('\n');

        // Apply the ANSI color code to each line
        return lines.map((line) => '$color$line$_ansiRESET').join('\n');
      } else {
        return '$color$message$_ansiRESET';
      }
    } catch (e) {
      // If message is not a valid JSON, return it as plain text with color
      return '$color$message$_ansiRESET';
    }
  }
}
