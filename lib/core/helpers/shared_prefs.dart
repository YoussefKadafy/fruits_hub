import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:fruits_hub/features/auth/domain/entity/user_entity.dart';

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
  static Future<bool> saveUserData(UserEntity user) async {
    final userDataJson = jsonEncode(user.toMap());
    return await instance.setString(_userDataKey, userDataJson);
  }

  static UserEntity? getUserEntity() {
    final userDataJson = instance.getString(_userDataKey);
    if (userDataJson == null) return null;
    final userData = jsonDecode(userDataJson) as Map<String, dynamic>;
    return UserEntity.fromMap(userData);
  }

  static Future<void> clearUserData() async {
    await instance.remove(_userDataKey);
  }
}
