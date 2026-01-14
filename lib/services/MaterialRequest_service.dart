import 'package:dio/dio.dart';
import 'package:flutter/rendering.dart';
import 'package:tech_app/core/network/dio_client.dart';

class MaterialrequestService {
  final _dio = DioClient.dio;
  Future<void> fetchmaterialrequest({
  required Map<String, dynamic> payload

  }) async {
    try {
    
      final response = await _dio.post(
        'material/bulk-request',
        data: payload,
      );


    } on DioException catch (e) {

      final errorData = e.response?.data;
      final message = errorData is Map<String, dynamic>
          ? errorData['message'] ?? 'Something went wrong'
          : errorData.toString();

      throw message;
    }
  }
}
