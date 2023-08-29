import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesHelper {
  static late SharedPreferences preferences;

  static Future<void> initialize() async {
    preferences = await SharedPreferences.getInstance();
  }

  static late SharedPreferencesHelper _instance;

  SharedPreferencesHelper._();

  factory SharedPreferencesHelper() {
    _instance ??= SharedPreferencesHelper._();
    return _instance;
  }
}
