import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {
  static SharedPreferences? _preferences;
  static const String _isOnboardingViewedKey = 'is_onboarding_viewed';
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
}
