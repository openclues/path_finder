import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesService {
  SharedPreferencesService._(); // Private constructor

  static final SharedPreferencesService instance = SharedPreferencesService._();

  late SharedPreferences _prefs;

  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  factory SharedPreferencesService.fromLocator() {
    return instance;
  }

  Future<void> setData<T>(String key, T value) async {
    // _prefs = await SharedPreferences.getInstance();

    if (T == int) {
      await _prefs.setInt(key, value as int);
    } else if (T == double) {
      await _prefs.setDouble(key, value as double);
    } else if (T == bool) {
      await _prefs.setBool(key, value as bool);
    } else {
      await _prefs.setString(key, value as String);
    }
  }

  T? getData<T>(String key) {
    if (T == int) {
      int? value = _prefs.getInt(key);
      return value as T?;
    } else if (T == double) {
      return _prefs.getDouble(key) as T?;
    } else if (T == bool) {
      return _prefs.getBool(key) as T?;
    } else {
      return _prefs.getString(key) as T?;
    }
  }

  Future<void> removeData(String key) async {
    // _prefs = await SharedPreferences.getInstance();
    await _prefs.remove(key);
  }

  //will be used for logout
  Future<void> clearData() async {
    _prefs = await SharedPreferences.getInstance();

    await _prefs.clear();
  }
}
