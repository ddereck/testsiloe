// ignore_for_file: constant_identifier_names

import 'package:get_storage/get_storage.dart' show GetStorage;

class PreferencesServices {
  static final GetStorage _storage = GetStorage('AppPreferences');

  static Future<void> registerValue(String key, dynamic value) async {
    if(value == null || value == '') {
      return;
    }
    if (_storage.read(key)!= null) {
      await _storage.write(key, value);
    } else {
      await _storage.writeIfNull(key, value);
    }
  }

  static dynamic getValue(String key) {
    return _storage.read(key);
  }

  static Future<void> deleteValue(String key) async {
    await _storage.remove(key);
  }

  static Future<void> saveData(String key, dynamic value) async {
    await _storage.write(key, value);
  }

  /// Vérifie si une clé existe dans GetStorage
  static bool hasData(String key) {
    return _storage.hasData(key);
  }
  
  static const String THEME_MODE  = 'dark';
  static bool get isThemeMode => PreferencesServices.getValue(THEME_MODE) != null;

  static const String firstOpeningKey = "firstOpening";
  
  static const String appThemeModeKey = "AppThemeMode";

  static const String apiTokenKey = "api_token";
}
