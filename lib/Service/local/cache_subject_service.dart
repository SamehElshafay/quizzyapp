// SubjectsModel

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:quizzy_app/model/subjects_model.dart';

class CacheSubjectService {
  static CacheSubjectService? _instance;
  static CacheSubjectService get instance =>
      _instance ??= CacheSubjectService._();
  CacheSubjectService._();

  static const _boxName = "subejctBox";
  static const _key = "subject";
  late Box<SubjectsModel> myBox;

  Future<void> init() async {
    await Hive.openBox<SubjectsModel>(_boxName);
    myBox = Hive.box<SubjectsModel>(_boxName);
  }

  SubjectsModel? getSubjects() {
    SubjectsModel? result = myBox.get(_key);

    return result;
  }

  Future<void> updateSubjects({required SubjectsModel subjectsModel}) async {
    myBox.put(_key, subjectsModel);
  }

  Future<void> deleteSubjects() async {
    await myBox
        .delete(_key)
        .then((value) => debugPrint("delete the Subejct Cahce"));
  }

  bool isExist() => myBox.containsKey(_key);
}
