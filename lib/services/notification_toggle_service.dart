
import 'package:tech_app/core/network/dio_client.dart';
class NotificationToggleService {
 final _dio = DioClient.dio;
  Future<bool> fetchCheckStatus() async {
    try {
      final response = await _dio.post("technician/status");

      return response.data["data"] ?? true;

    } catch (e) {
      throw Exception("Failed to fetch notification status");
    }
  }

    Future<void> updateNotificationStatus(bool status) async {
    try {
      await _dio.post(
        "technician/notification-status",
        data: {
          "status": status,
        },
      );
    } catch (e) {
      throw Exception("Failed to update notification status");
    }
  }
}