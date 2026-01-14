class AuthModel {
  final String email;
  final String password;

  AuthModel({
    required this.email,
    required this.password,
  });

  // Convert to JSON for API request
  Map<String, dynamic> toJson() {
    return {
      "email": email,
      "password": password,
    };
  }

  @override
  String toString() {
    return 'AuthModel(email: $email, password: $password)';
  }
}
