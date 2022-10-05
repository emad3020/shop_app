import 'package:dio/dio.dart';

class DioHelper {
  static Dio? _dio;

  static init() {
    _dio ??= Dio(
      BaseOptions(
          baseUrl: 'https://student.valuxapps.com/api/',
          receiveDataWhenStatusError: true,
          headers: {
            'Content-Type': 'application/json',
          }),
    );
  }

  static Future<Response?> getData({
    required String url,
    required Map<String, dynamic> query,
  }) async {
    return await _dio?.get(
      url,
      queryParameters: query,
    );
  }

  static Future<Response?> postDate({
    required String url,
    required Map<String, dynamic> data,
    Map<String, dynamic>? query,
    String lang = 'ar',
    String? token,
  }) async {
    _dio?.options.headers = {
      'lang': lang,
      'Authorization': token,
    };
    return _dio?.post(url, data: data, queryParameters: query);
  }
}
