import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class AuthRouteService {
  static AuthRouteService? _instance;
  static AuthRouteService get instance => _instance ??= AuthRouteService._();
  AuthRouteService._();
  static const _boxName = "routeBook";
  static const _key = "route";
  static const _guestKey = "isGuest";
  late Box<bool> myBox;

  Future<void> init() async {
    await Hive.openBox<bool>(_boxName);
    myBox = Hive.box<bool>(_boxName);
  }

  bool readRoute() {
    bool result = myBox.get(_key, defaultValue: false)!;

    return result;
  }

  Future<void> logIn() async {
    myBox.put(_key, true);
  }

  bool readIsGuest() {
    return myBox.get(_guestKey, defaultValue: false)!;
  }

  Future<void> setGuest(bool isGuest) async {
    myBox.put(_guestKey, isGuest);
  }

  Future<void> logout() async {
    await myBox.delete(_key).then((value) => debugPrint("delted the Route"));
    await myBox.delete(_guestKey);
  }
}
