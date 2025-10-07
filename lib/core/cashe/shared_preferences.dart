import 'package:shared_preferences/shared_preferences.dart';

class CacheData {
  static late SharedPreferences preferences;
  static init() async {
    preferences = await SharedPreferences.getInstance();
  }

  static Future<bool> saveData(String key, String data) async {
    return preferences.setString(key, data);
  }

  static Future<String?> getData(String key) async {
    return preferences.getString(key);
  }

  static Future<bool> removeData(String key) async {
    return preferences.remove(key);
  }
}
