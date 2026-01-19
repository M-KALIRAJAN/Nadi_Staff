import 'package:dio/dio.dart';
import 'package:tech_app/core/network/dio_client.dart';

class StartworkService {
  final _dio = DioClient.dio;

  Future<Map<String, dynamic>> fetchstartwork(String userServiceId) async {
    try {
      final response = await _dio.post(
        "techie/start-work",
        data: {"userServiceId": userServiceId},
      );
      return response.data;
    } on DioException catch (e) {

      final message = e.response?.data['message']?.toString() ?? "Login failed";
      throw message;
    }
  }
}
