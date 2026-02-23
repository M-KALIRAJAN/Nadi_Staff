import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:tech_app/core/network/dio_client.dart';

class AccountDelete {
  final _dio = DioClient.dio;
  // Reson for Account Delete
  Future<Map<String, dynamic>> fetchdeletereson() async {
    try {
      final response = await _dio.get("delete-Reasons");
      return response.data;
    } on DioException catch (e) {
      final err = e.response?.data['message'];
      throw err;
    }
  }

  // Account delete

  Future<Map<String, dynamic>> fetchdeleteaccount({
    required String reasonId,
  }) async {
    debugPrint("fetchdeleteaccount ${reasonId}");
    try {
      final response = await _dio.post(
        "technician/delete-tech",
        data: {"reasonId": reasonId},
      );
      return response.data;
    } on DioException catch (e) {
      final err = e.response?.data['message'];
      throw err;
    }
  }
}
