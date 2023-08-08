import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class Environment {
  static String get fileName =>
      kReleaseMode ? ".env.production" : ".env.development";
  static String get apiUrl => dotenv.env['API_URL'] ?? 'MY_FALLBACK';
  static String get currentEnv => dotenv.env['ENV'] ?? 'MY_FALLBACK';
  static String get DEVELOPMENT_ENVIRONMENT_FILE_NAME => ".env.development";
  static String get PRODUCTION_ENVIRONMENT_FILE_NAME => ".env.production";
}
