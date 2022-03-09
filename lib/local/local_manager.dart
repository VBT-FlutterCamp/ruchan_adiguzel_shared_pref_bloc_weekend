import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:vexana/vexana.dart';

class LocalManager {
  static final LocalManager _instance = LocalManager._init();
  SharedPreferences? _preferences;
  static LocalManager get instance => _instance;

  LocalManager._init() {
    SharedPreferences.getInstance().then((value) {
      _preferences = value;
    });
  }
  static Future preferenceInit() async {
    instance._preferences ??= await SharedPreferences.getInstance();
    return;
  }

  Future<void> setStringValue(PreferencesKey key, String value) async {
    await _preferences?.setString(key.toString(), value);
  }

  String getStringValue(PreferencesKey key) =>
      _preferences?.getString(key.toString()) ?? "";

  T getDynamicValue<T extends INetworkModel>(PreferencesKey key, T model) {
    final body = getStringValue(key);
    if (body.isNotEmpty) {
      return model.fromJson(jsonDecode(body));
    }
    return model;
  }
}

enum PreferencesKey { model_body }
