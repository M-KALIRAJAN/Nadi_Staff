import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:tech_app/core/network/dio_client.dart';
import 'package:tech_app/model/UpdatePayment_Model.dart';

class UpdatepaymentService {
  final Dio _dio = DioClient.dio;

  Future<void> passupdatepayment(UpdatePayment data) async {
    try {
      debugPrint("Payload: ${data.toJson()}");

      final response = await _dio.post(
        "techie/update-payment",
        data: data.toJson(),
      );

      debugPrint("Status: ${response.statusCode}");
      debugPrint("Response: ${response.data}");
    } on DioException catch (e) {
      final errorMsg = e.response?.data?['message'] ?? 'Payment update failed';
      throw Exception(errorMsg);
    }
  }
}
