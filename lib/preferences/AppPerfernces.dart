   import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:tech_app/model/TechnicianProfile_Model.dart';

class Appperfernces {
  static const String _tokenKey = "auth_token";
  static const String _profileKey = "technician_profile";
  static const String _loginKey = "is_logged_in";
  static const String _fcmtokenkey ="fcmtoken";
  // ==== TOKEN ====
  static Future<void> saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_tokenKey, token);
  }

  static Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_tokenKey);
  }
// === FCM TOKEN ===
static Future<void> saveFcmToken(String fcmToken) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString(_fcmtokenkey, fcmToken);
}

static Future<String?> getFcmToken() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getString(_fcmtokenkey);
}

    // ================== LOGIN FLAG ==================
  static Future<void> setLoggedIn(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_loginKey, value);
  }

  static Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_loginKey) ?? false;
  }

  // === PROFILE ===
  static Future<void> saveProfiledata(TechnicianProfile profile) async {
    final prefs = await SharedPreferences.getInstance();
    final profileJson = json.encode(profile);
    await prefs.setString(_profileKey, profileJson);
  }

  static Future<TechnicianProfile?> getProfiledata() async {
    final prefs = await SharedPreferences.getInstance();
    final profileString = prefs.getString(_profileKey);

    if (profileString == null) return null;

    final Map<String, dynamic> jsonMap = json.decode(profileString);
    return TechnicianProfile.fromJson(jsonMap);
  }
}
