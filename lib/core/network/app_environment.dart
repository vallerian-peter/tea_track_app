import 'dart:developer';

import 'package:flutter_dotenv/flutter_dotenv.dart';

/// Server configuration read from the bundled `.env` file.
///
/// Copy `.env.example` to `.env` and set `API_BASE_URL` before running.
abstract final class AppEnvironment {
  static const _fallbackBaseUrl = 'https://api.example.com/api/v1';

  static Future<void> load() async {
    await dotenv.load(fileName: '.env', isOptional: true);
    log('🌍 [Environment] $name → $baseUrl');
  }

  static String get name => dotenv.maybeGet('ENVIRONMENT') ?? 'DEV';

  /// API root without a trailing slash, e.g. `https://host/api/v1`.
  static String get baseUrl {
    final url = dotenv.maybeGet('API_BASE_URL') ?? _fallbackBaseUrl;
    return url.endsWith('/') ? url.substring(0, url.length - 1) : url;
  }

  static bool get isProduction => name.toUpperCase() == 'PRODUCTION';
}
