import 'package:shared_preferences/shared_preferences.dart';

//danghld
// class save data local application
class SaveDataLocal {
  SaveDataLocal._privateConstructor();

  static final SaveDataLocal _instance = SaveDataLocal._privateConstructor();

  static SaveDataLocal get instance => _instance;

  //Boolean
  //function set data
  Future<bool> setDataBoolean(String key, bool value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setBool(key, value);
  }

  //function get data
  Future<bool> getDataBoolean(String key) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(key) ?? false;
  }

  //String

  Future<bool> setDataString(String key, String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(key, value);
  }

  Future<String> getDataString(String key) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(key) ?? "";
  }

  //Int

  Future<bool> setDataInt(String key, int value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setInt(key, value);
  }

  Future<int> getDataInt(String key) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt(key) ?? -1;
  }

  //Double

  Future<bool> setDataDouble(String key, double value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setDouble(key, value);
  }

  Future<double> getDataDouble(String key) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getDouble(key) ?? -1.1;
  }

  // save default language

  Future<bool> setLanguageDefault(String key, String value) async {
    return setDataString(key, value);
  }

  Future<String> getLanguageDefault(String key) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(key) ?? "en"; //return default language if not
  }
}
