import 'dart:io';

import 'package:flutter/services.dart';
import 'package:fruits_hub/core/admin/services/supabase_service.dart';

/// A helper class for loading environment variables from assets
/// Supports mobile platforms (Android, iOS) and parses .env files
class EnvLoader {
  /// The path to the environment file in assets
  static const String _envFilePath = '.env';

  /// Loads environment variables from the .env file in assets
  /// Falls back to empty environment if file is not found or parsing fails
  static Future<void> load() async {
    if (Platform.isAndroid || Platform.isIOS) {
      await _loadFromAssets();
    }
    // Desktop and other platforms can be added here if needed
  }

  /// Loads environment variables from assets bundle
  static Future<void> _loadFromAssets() async {
    try {
      final String envString = await rootBundle.loadString(_envFilePath);
      final Map<String, String> envVars = _parseEnvFile(envString);
      SupabaseService.setEnv(envVars);
    } catch (e) {
      // Fall back to empty env - no environment variables loaded
      // This allows the app to continue with default values
    }
  }

  /// Parses environment file content into a map
  /// Supports comments (lines starting with #) and key=value format
  static Map<String, String> _parseEnvFile(String content) {
    final Map<String, String> envVars = {};

    for (var line in content.split('\n')) {
      final trimmedLine = line.trim();

      // Skip empty lines and comment lines
      if (trimmedLine.isEmpty || trimmedLine.startsWith('#')) {
        continue;
      }

      final parts = trimmedLine.split('=');
      if (_isValidEnvEntry(parts)) {
        envVars[parts[0].trim()] = parts[1].trim();
      }
    }

    return envVars;
  }

  /// Validates that the parsed line is a valid environment variable entry
  /// Returns true only if there are exactly 2 parts (key=value)
  static bool _isValidEnvEntry(List<String> parts) {
    return parts.length == 2 && parts[0].trim().isNotEmpty;
  }
}
