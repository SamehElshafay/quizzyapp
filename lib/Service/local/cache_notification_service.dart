import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class CacheNotificationService {
  static CacheNotificationService? _instance;
  static CacheNotificationService get instance =>
      _instance ??= CacheNotificationService._();
  CacheNotificationService._();
  static const _boxName = "notificationBox";
  static const _key = "notification";
  late Box<bool> myBox;

  Future<void> init() async {
    await Hive.openBox<bool>(_boxName);
    myBox = Hive.box<bool>(_boxName);
  }

  bool isNotificationEnabled() {
    bool result = myBox.get(_key, defaultValue: true)!;

    return result;
  }

  Future<void> updateValueOfNotification({required bool value}) async {
    myBox.put(_key, value);
  }

  Future<void> delete() async {
    await myBox
        .delete(_key)
        .then((value) => debugPrint("delted the The Box of Notification"));
  }
}
