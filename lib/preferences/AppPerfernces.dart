   import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:tech_app/model/TechnicianProfile_Model.dart';

class Appperfernces {
  static const String _tokenKey = "auth_token";
  static const String _profileKey = "technician_profile";

  // ==== TOKEN ====
  static Future<void> saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_tokenKey, token);
  }

  static Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_tokenKey);
  }

  // === PROFILE ===
  static Future<void> saveProfiledata(TechnicianProfile profile) async {
    final prefs = await SharedPreferences.getInstance();
    final profileJson = json.encode(profile.toJson());
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
