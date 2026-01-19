import 'package:dio/dio.dart';
import 'package:tech_app/core/network/dio_client.dart';
import 'package:tech_app/model/Inventory_Material_Model.dart';

class Productlist {
  final _dio = DioClient.dio;

  Future<List<Product>> fetchproductlist() async {
    try {
      final response = await _dio.get('inventory/product-list');
      final List list = response.data['data'];
      return list.map((e) => Product.fromJson(e)).toList();
    } on DioException catch (e) {

      final errorData = e.response?.data;
      final message = errorData is Map<String, dynamic>
          ? errorData['message'] ?? 'Something went wrong'
          : errorData.toString();

      throw message;
    }
  }
}
