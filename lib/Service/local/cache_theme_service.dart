import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class CacheThemeService {
  static CacheThemeService? _instance;
  static CacheThemeService get instance => _instance ??= CacheThemeService._();
  CacheThemeService._();
  static const _boxName = "themeBox";
  static const _key = "theme";
  late Box<bool> myBox;

  Future<void> init() async {
    await Hive.openBox<bool>(_boxName);
    myBox = Hive.box<bool>(_boxName);
  }

  bool isDarkTheme() {
    bool result = myBox.get(_key, defaultValue: false)!;

    return result;
  }

  Future<void> updateTheme({required bool value}) async {
    myBox.put(_key, value);
  }

  Future<void> deleteTheme() async {
    await myBox
        .delete(_key)
        .then((value) => debugPrint("delted the The Box of Theme"));
  }
}
