class AuthModel {
  final String email;
  final String password;
  final String fcmToken;

  AuthModel({
    required this.email,
    required this.password, required this.fcmToken,
  });

  // Convert to JSON for API request
  Map<String, dynamic> toJson() {
    return {
      "email": email,
      "password": password,
      "fcmToken":fcmToken
    };
  }

}
