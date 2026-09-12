import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:quizzy_app/model/settings_data_model.dart';
import 'package:quizzy_app/model/settings_model.dart';

class CacheSettingsService {
  static CacheSettingsService? _instance;
  static CacheSettingsService get instance =>
      _instance ??= CacheSettingsService._();
  CacheSettingsService._();

  static const _boxName = "settingsBox";
  static const _key = "settings";
  late Box<SettingsModel> myBox;

  Future<void> init() async {
    await Hive.openBox<SettingsModel>(_boxName);
    myBox = Hive.box<SettingsModel>(_boxName);
  }

/*
      defaultValue: SettingsModel(
            success: false,
            data: Data(
                isTeacher: "1",
                baseUrlApi: "https://quizzy.ps",
                version: "1",
                showBalance: "1"))

*/
  SettingsModel getSettings() {
    SettingsModel result = myBox.get(_key,
        defaultValue: SettingsModel(
            settingsData: SettingsData(
          baseUrlApi: "https://quizzy.quizzy.site",
          isTeacher: "0",
          showBalance: "1",
        )))!;

    return result;
  }

  Future<void> updateSettings({required SettingsModel settingsModel}) async {
    await myBox.put(_key, settingsModel);
  }

  void getStudentData() async {
    bool result = getSettings().settingsData!.isTeacher == "1" ? true : false;

    if (result) {
      if (Platform.isAndroid) {
        await SystemNavigator.pop();
      } else {
        await SystemChannels.platform.invokeMethod<void>('SystemNavigator.pop');
      }
    }
  }

  Future<void> deleteUser() async {
    await myBox
        .delete(_key)
        .then((value) => debugPrint("delted the Settings from Cahce"));
  }
}
