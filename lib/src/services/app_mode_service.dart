import 'package:flutter/material.dart';

import '../core/services/preferences_service.dart' show PreferencesServices;

class AppModeService {

  static Future<void> setAppThemeMode(ThemeMode mode) async {
    await PreferencesServices.saveData(PreferencesServices.appThemeModeKey, mode.name);
  }
  
  static ThemeMode getAppThemeMode() {
    try {
      ThemeMode? theme;
      if(PreferencesServices.hasData(PreferencesServices.appThemeModeKey)) {
        final color = PreferencesServices.getValue(PreferencesServices.appThemeModeKey) as String;
        theme = ThemeMode.values.firstWhere((element) => element.name == color, orElse: () => ThemeMode.light);
      } 
      return theme ?? ThemeMode.light;
    } catch (e) {
      return ThemeMode.light;
    }
  }
}