import 'package:dio/dio.dart';
import 'package:shop_app/shared/components/constants.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';

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
    Map<String, dynamic>? query = null,
    String lang = 'ar',
  }) async {
    _dio?.options.headers = {
      'lang': lang,
      'Content-Type': 'application/json',
      'Authorization': CacheHelper.getData(key: USER_TOKEN),
    };
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
