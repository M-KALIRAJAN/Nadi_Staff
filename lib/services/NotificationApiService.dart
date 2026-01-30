import 'package:dio/dio.dart';
import 'package:tech_app/core/network/dio_client.dart';
import 'package:tech_app/model/NotificationModel.dart';

class Notificationapiservice {
  final _dio = DioClient.dio;

  Future<List<NotificationModel>> fetchnodification() async {
    try {
      final response = await _dio.post('techie/notifications');

      final List list = response.data['data'];

      return list
          .map((e) => NotificationModel.fromJson(e))
          .toList();

    } on DioException catch (e) {
      final errmsg = e.response?.data['message'] ?? "Something went wrong";
      throw errmsg;
    }
  }

Future<void> deletesinglenotification({
  required String id,
}) async {
  try {
    await _dio.post("techNotifications/clear-notification/$id");
  } on DioException catch (e) {
    throw e;
  }
}
 Future<void> deleteallnotifications() async{
  try {
    await _dio.post("techNotifications/clear");
  } on DioException catch (e) {
    throw e;
  }
 }
}
