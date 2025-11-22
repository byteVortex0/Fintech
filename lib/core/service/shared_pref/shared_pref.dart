import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {
  const SharedPref._();

  static const SharedPref instance = SharedPref._();

  factory SharedPref() => instance;

  static SharedPreferences? _sharedPreferences;

  static Future<void> init() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  static Future<void> setValue(String key, dynamic value) async {
    if (value is String) {
      await _sharedPreferences?.setString(key, value);
    } else if (value is bool) {
      await _sharedPreferences?.setBool(key, value);
    } else if (value is int) {
      await _sharedPreferences?.setInt(key, value);
    } else if (value is double) {
      await _sharedPreferences?.setDouble(key, value);
    }
  }

  static dynamic getValue(String key) {
    return _sharedPreferences?.get(key);
  }

  static Future<void> removeValue(String key) async {
    await _sharedPreferences?.remove(key);
  }
}
