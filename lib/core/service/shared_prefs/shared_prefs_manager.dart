import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefsManager {
  static SharedPreferences? _instance;
  static Future<SharedPreferences> get instance async {
    if (_instance != null) return _instance!;
    _instance = await SharedPreferences.getInstance();
    return _instance!;
  }

  late final SharedPreferences sharedPreferences;

  SharedPrefsManager._init() {
    getSharedPrefsInstance();
  }

  Future<SharedPreferences> getSharedPrefsInstance() async {
    sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences;
  }
}
