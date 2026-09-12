import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quizzy_app/Service/local/cache_theme_service.dart';

class ThemeViewMode extends GetxController {
  final ThemeData _lightTheme = ThemeData(colorScheme: ColorScheme.light());

  final ThemeData _darkTheme = ThemeData(colorScheme: ColorScheme.dark());

  late ThemeData _themeValue;

  ThemeData get themeValue => _themeValue;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    _loadTheme();
  }

  _loadTheme() {
    if (CacheThemeService.instance.isDarkTheme()) {
      _themeValue = _darkTheme;
    } else {
      _themeValue = _lightTheme;
    }
  }

  void updateTheme() {
    if (_themeValue == _lightTheme) {
      _themeValue = _darkTheme;
    } else {
      _themeValue = _lightTheme;
    }
    print("updateTheme");
    update(['updateTheme']);
  }

  bool isDarkMode() {
    return CacheThemeService.instance.isDarkTheme();
  }
}
