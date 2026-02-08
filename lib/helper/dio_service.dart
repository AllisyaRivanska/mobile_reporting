import 'package:dio/dio.dart';
import 'package:mobile_reporting/constant/api_endpoints.dart';

class DioService {
  static Dio? _dio;

  static Future<Dio> getInstance() async {
    _dio ??= Dio(
        BaseOptions(
      baseUrl: ApiEndpoints.baseUrl,
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
      headers: {
        'Accept': 'application/json',
      },
      ),
      );
    return _dio!;
  }
}