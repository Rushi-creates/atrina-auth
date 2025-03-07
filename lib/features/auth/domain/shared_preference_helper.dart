import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesHelper {
  static late SharedPreferences sharedPreferences;

  final String _keyname;
  final dynamic _fromJson;

  const SharedPreferencesHelper(this._keyname, {dynamic fromJson})
      : _fromJson = fromJson;

  static init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  //!Fetch  ( only get is not async in SP)
  dynamic get() {
    return sharedPreferences.get(_keyname);
  }

  dynamic getModel() {
    String? jsonifyModel = sharedPreferences.getString(_keyname);
    if (jsonifyModel != null) {
      return _fromJson(jsonifyModel);
    }
    return null;
  }

  //! add
  Future<bool> set(dynamic value) async {
    if (value is String) {
      return await sharedPreferences.setString(_keyname, value);
    }
    if (value is int) return await sharedPreferences.setInt(_keyname, value);
    if (value is bool) return await sharedPreferences.setBool(_keyname, value);
    if (value is List<String>) {
      return await sharedPreferences.setStringList(_keyname, value);
    }
    if (value is double) {
      return await sharedPreferences.setDouble(_keyname, value);
    } else {
      return await sharedPreferences.setString(_keyname, value.toMap());
    }
  }

  //! delete
  dynamic remove() async {
    return await sharedPreferences.remove(_keyname);
  }
}
