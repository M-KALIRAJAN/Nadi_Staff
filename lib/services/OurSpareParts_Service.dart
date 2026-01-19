
import 'package:dio/dio.dart';
import 'package:tech_app/core/network/dio_client.dart';
import 'package:tech_app/model/OurSpareParts_Model.dart';

class OursparepartsService {
  final Dio _dio = DioClient.dio;

  Future<OurSpareParts> fetchourspareparts() async {
    try {
      print("🟡 API CALL START");

      final response = await _dio.post('spare');

      print("🟢 RAW RESPONSE TYPE: ${response.data.runtimeType}");
      print("🟢 RAW RESPONSE: ${response.data}");

      final model = OurSpareParts.fromJson(response.data);

      print("🟢 MODEL PARSED: ${model.data.length} items");

      return model;
    } on DioException catch (e) {
      print("🔴 DIO ERROR: ${e.message}");
      print("🔴 RESPONSE: ${e.response?.data}");
      rethrow;
    } catch (e) {
      print("🔴 PARSE ERROR: $e");
      rethrow;
    }
  }
}
