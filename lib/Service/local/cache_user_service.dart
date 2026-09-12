import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:quizzy_app/model/user_model.dart';

class CacheUserService {
  static CacheUserService? _instance;
  static CacheUserService get instance => _instance ??= CacheUserService._();
  CacheUserService._();

  static const _boxName = "userBox";
  static const _key = "user";
  late Box<User> myBox;

  Future<void> init() async {
    await Hive.openBox<User>(_boxName);
    myBox = Hive.box<User>(_boxName);
  }

  User getUser() {
    User result = myBox.get(_key, defaultValue: User())!;

    return result;
  }

  Future<void> updateUser({required User user}) async {
    myBox.put(_key, user);
  }

  Future<void> deleteUser() async {
    await myBox
        .delete(_key)
        .then((value) => debugPrint("delted the User Cahce"));
  }
}
