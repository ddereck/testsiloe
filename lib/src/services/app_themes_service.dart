import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:siloe/src/core/utils/fonts_names_utils.dart';

class AppThemesService {
  static var themeData = GetStorage('Theme');

  static ThemeMode getActualThemeMode() {
    themeData.writeIfNull('theme_mode', ThemeMode.light.name);
    
    if (themeData.read('theme_mode') == ThemeMode.light.name) {
      return ThemeMode.light;
    } else {
      return ThemeMode.dark;
    }
  }

  static void changeMode(ThemeMode mode) {
    themeData.write('theme_mode', mode.name);
  }

  static Color lightThemeColor = Colors.white,
      darkThemeColor = Colors.grey[900]!;

  static final lightThemeData = ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: Colors.white,
    fontFamily: FontsNamesUtils.fontName,
    primaryColor: Colors.white,
    primaryColorLight: Colors.redAccent,
    primaryColorDark: Colors.redAccent,
    highlightColor: Colors.grey[200],
    cardColor: const Color.fromARGB(255, 245, 245, 245),
    canvasColor: const Color.fromARGB(255, 245, 245, 245),
    focusColor: const Color.fromARGB(246, 243, 237, 237),
    shadowColor: const Color.fromARGB(246, 195, 190, 190),
    bottomSheetTheme: const BottomSheetThemeData(
      backgroundColor: Colors.transparent,
    ),
    switchTheme: SwitchThemeData(
      thumbColor:
          WidgetStateProperty.resolveWith<Color>((states) => lightThemeColor),
    ),
    useMaterial3: true,
  );

  static final darkThemeData = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: const Color.fromARGB(255, 22, 21, 21),
    fontFamily:FontsNamesUtils.fontName,
    highlightColor: const Color.fromARGB(100, 56, 55, 55),
    primaryColor: Colors.grey[900],
    primaryColorLight: Colors.redAccent,
    primaryColorDark: Colors.redAccent,
    cardColor: const Color.fromARGB(255, 56, 55, 55),
    canvasColor: const Color.fromARGB(255, 56, 55, 55),
    shadowColor: const Color.fromARGB(255, 56, 55, 55),
    switchTheme: SwitchThemeData(
      trackColor:
          WidgetStateProperty.resolveWith<Color>((states) => darkThemeColor),
    ),
    useMaterial3: true,
  );
}
