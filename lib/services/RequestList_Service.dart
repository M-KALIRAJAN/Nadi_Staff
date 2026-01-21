import 'package:dio/dio.dart';
import 'package:flutter/rendering.dart';
import 'package:tech_app/core/network/dio_client.dart';
import 'package:tech_app/model/RequestList_Model.dart';

class RequestlistService {
  final _dio = DioClient.dio;
  Future<RequestList> fetchrequestlist() async{
    try{
       final response = await _dio.post('material/list');
         debugPrint("🟢 RESPONSE DATA: ${response.data}");
       return RequestList.fromJson(response.data);
    }on DioException catch(e){
       print("🔴 DIO ERROR: ${e.message}");
      print("🔴 RESPONSE: ${e.response?.data}");
      rethrow;
    }
  }
}