import 'dart:convert'; 
import 'package:dio/dio.dart';
import 'package:flutter/rendering.dart';
import 'package:tech_app/core/network/dio_client.dart';
import 'package:tech_app/model/TechnicianProfile_Model.dart';

class TechnicianprofileService {
  final Dio _dio = DioClient.dio;
  Future<TechnicianProfile> tech_profile() async {
    try {
      final response = await _dio.post('technician/profile');

      return TechnicianProfile.fromJson(response.data);
    } on DioException catch (e) {

      final errorData = e.response?.data;

      final message = errorData is Map<String, dynamic>
          ? errorData['message'] ?? 'Something went wrong'
          : errorData.toString();

      throw message;
    }
  }
}
