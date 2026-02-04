import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {
  static SharedPreferences? _preferences;
  static const String _isOnboardingViewedKey = 'is_onboarding_viewed';
  static const String _userDataKey = 'user_data';

  static Future<void> init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  static SharedPreferences get instance {
    if (_preferences == null) {
      throw Exception('SharedPreferences not initialized. Call init() first.');
    }
    return _preferences!;
  }

  // Onboarding Methods
  static Future<bool> setOnboardingViewed({
    required bool isOnboardingViewed,
  }) async {
    return await instance.setBool(_isOnboardingViewedKey, isOnboardingViewed);
  }

  static bool isOnboardingViewed() {
    return instance.getBool(_isOnboardingViewedKey) ?? false;
  }

  static Future<void> clearOnboardingViewed() async {
    await instance.remove(_isOnboardingViewedKey);
  }

  // User Data Methods
  static Future<bool> saveUserData(Map<String, dynamic> userData) async {
    final userDataJson = jsonEncode(userData);
    return await instance.setString(_userDataKey, userDataJson);
  }

  static Map<String, dynamic>? getUserData() {
    final userDataJson = instance.getString(_userDataKey);
    if (userDataJson == null) return null;
    return jsonDecode(userDataJson) as Map<String, dynamic>;
  }

  static Future<void> clearUserData() async {
    await instance.remove(_userDataKey);
  }
}
