import 'package:dio/dio.dart';
import 'package:tech_app/core/network/dio_client.dart';

class TimerService {
  final _dio = DioClient.dio;

  Future<Map<String, dynamic>> fetchTimerData({
    required String userServiceId,
  }) async {
    try {
      final response = await _dio.post(
        "/techie/timer/",
        data: {"userServiceId": userServiceId},
      );

      return response.data;
    } on DioException catch (e) {
      throw e.response?.data["message"] ?? "Failed to fetch timer";
    }
  }

  Future<void> pauseTimer({required String userServiceId}) async {
    await _dio.post(
      "/techie/hold-work",
      data: {"userServiceId": userServiceId},
    );
  }

  Future<void> resumeTimer({required String userServiceId}) async {
    await _dio.post(
      "/techie/start-work",
      data: {"userServiceId": userServiceId},
    );
  }
}
