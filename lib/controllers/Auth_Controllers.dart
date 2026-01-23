import 'package:flutter/material.dart';
import 'package:tech_app/model/Auth_Model.dart';
import 'package:tech_app/preferences/AppPerfernces.dart';
import 'package:tech_app/services/Auth_Service.dart';

class AuthControllers {
  final email = TextEditingController();
  final pasword = TextEditingController();
  final AuthService _authService = AuthService();
  


  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) return "Email is required";
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(value)) return "Enter valid email";
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) return "Password is required";
    return null;
  }

  Future<String?> login() async {
    try {
         final fcmToken = await Appperfernces.getFcmToken();
      final authmodel = AuthModel(
        email: email.text.trim(),
        password: pasword.text.trim(),
        fcmToken:fcmToken ?? ""
      );
        print("fcmToken ************************* $fcmToken");
      final response = await _authService.techLogin(authmodel);
     print("response ************************* $response");

      // Optionally save token: response['token']
      return null; // null means success
    } catch (e) {
      return e.toString(); // return error message for snackbar
    }
  }

  void dispose() {
    email.dispose();
    pasword.dispose();
  }
}
