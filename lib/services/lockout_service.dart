import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:tech_app/core/network/dio_client.dart';

class LockoutService {
  final  _dio = DioClient.dio;

  Future<void> fetchlogout() async{
    try{
      final response = await _dio.post("'user-account/logout'");

        if (kDebugMode) {
        debugPrint('🔒 Logout API Success');
        debugPrint('Response: ${response.data}');
      }
    } on DioException catch(e){
      final errmsg = e.response?.data['message'];
      throw errmsg;
    }
  }
}