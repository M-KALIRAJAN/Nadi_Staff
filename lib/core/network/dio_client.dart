import 'package:dio/dio.dart';
import 'package:tech_app/preferences/AppPerfernces.dart';

class DioClient {
  static final Dio dio =
      Dio(
          BaseOptions(
            baseUrl: "https://srv1252888.hstgr.cloud/api/",
            responseType: ResponseType.json,
            connectTimeout: const Duration(seconds: 30),
            receiveTimeout: const Duration(seconds: 30),
          ),
        )
        ..interceptors.add(
          InterceptorsWrapper(
            onRequest: (options, handler) async {
              final token = await Appperfernces.getToken();

              if (token != null && token.isNotEmpty) {
                options.headers['Authorization'] = 'Bearer $token';
              }

              return handler.next(options);
            },
            onError: (error, handler) {
              return handler.next(error);
            },
          ),
        );
}

class ImageBaseUrl {
  static const baseUrl = "https://srv1252888.hstgr.cloud/uploads";
}
