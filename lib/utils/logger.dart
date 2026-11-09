import 'package:flutter/foundation.dart';

/// Class Logger untuk logging terstruktur dan aman
class Logger {
  /// Kumpulan kata kunci data sensitif (Poin c)
  static const List<String> _sensitiveKeys = [
    'password',
    'token',
    'api_key',
    'apikey',
    'secret',
    'authorization',
    'pin',
  ];

  /// Poin c: Menyaring teks dari data sensitif sebelum dipublikasikan ke console
  static String _sanitize(String message) {
    String sanitized = message;
    for (final key in _sensitiveKeys) {
      if (sanitized.toLowerCase().contains(key)) {
        sanitized = sanitized.replaceAll(
          RegExp('$key\\s*[:=]\\s*[^\\s,]+', caseSensitive: false),
          '$key: [REDACTED]',
        );
      }
    }
    return sanitized;
  }

 static void _log(String level, String message) {
    if (kDebugMode) {
      final timestamp = DateTime.now().toIso8601String();
      // Otomatis bersihkan teks dari data sensitif jika ada
      final safeMessage = _sanitize(message);
      print('[$timestamp] [$level] $safeMessage');
    }
  }
  // --- POIN a: METHOD-METHOD LEVEL LOG ---

  /// Log level: DEBUG
  static void debug(String message) {
    _log('DEBUG', message);
  }

  /// Log level: INFO
  static void info(String message) {
    _log('INFO', message);
  }

  /// Log level: WARNING
  static void warning(String message) {
    _log('WARNING', message);
  }

  /// Log level: ERROR
  static void error(String message, [Object? error, StackTrace? stackTrace]) {
    _log('ERROR', message);
    if (error != null) {
      _log('ERROR_DETAILS', error.toString());
    }
    if (stackTrace != null) {
      _log('STACK_TRACE', stackTrace.toString());
    }
  }
}