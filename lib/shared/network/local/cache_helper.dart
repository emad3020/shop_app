import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {
  static SharedPreferences? _sharedPreferences;

  static init() async {
    _sharedPreferences ??= await SharedPreferences.getInstance();
  }

  static Future<bool?> setData({
    required String key,
    required dynamic value,
  }) async {
    if (value is String) {
      return await _sharedPreferences?.setString(key, value);
    }
    if (value is int) {
      return await _sharedPreferences?.setInt(key, value);
    }
    if (value is double) {
      return await _sharedPreferences?.setDouble(key, value);
    }
    if (value is bool) {
      return await _sharedPreferences?.setBool(key, value);
    }
    return throw Exception(
        'Data type is not supported for $value in sharedPreferences');
  }

  static dynamic getData({
    required String key,
  }) {
    return _sharedPreferences?.get(key);
  }

  static Future<bool?> removeData({
    required String key,
  }) async {
    return await _sharedPreferences?.remove(key);
  }
}
