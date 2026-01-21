import 'package:dio/dio.dart';

import 'package:tech_app/core/network/dio_client.dart';
import 'package:tech_app/model/Auth_Model.dart';
import 'package:tech_app/preferences/AppPerfernces.dart';

class AuthService {
  final Dio _dio = DioClient.dio;

  Future<Map<String, dynamic>> techLogin(AuthModel authmodel) async {
    try {
      final response = await _dio.post(
        "technician/login",
        data: authmodel.toJson(),
      );

      final token = response.data['token'];
      if (token != null) {
        await Appperfernces.saveToken(token);
      }

      return response.data;
    } on DioException catch (e) {
      final message = e.response?.data['message']?.toString() ?? "Login failed";
      throw message; // will be caught in controller
    }
  }

  Future<Map<String, dynamic>> updatepassword({required String email}) async {
    try {
      final response = await _dio.post(
        'technician/forgot-password',
        data: {"email": email},
      );
      return response.data;
    } on DioException catch (e) {
      throw e.response?.data['message'] ?? "someting went wrong ";
    }
  }
}
