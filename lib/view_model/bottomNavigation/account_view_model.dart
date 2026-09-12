import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quizzy_app/Service/api/repository_implementaion_service/exam_repository_service.dart';
import 'package:quizzy_app/Service/local/cache_subject_service.dart';
import 'package:quizzy_app/model/achievement_model.dart';
import 'package:quizzy_app/model/data_subject_model.dart';

import 'package:quizzy_app/utils/dialog_helper.dart';
import 'package:quizzy_app/utils/snack_bar_helper.dart';

class AccountViewModel extends GetxController {
  String? _subjectValue; // the Value of the Subject in DropDown
  late AchievementModel _achievementModel;
  late List<DataSubjectModel>
      subjectListData; //  Data of SubjectModel to the DropDownValue
  late List<double> _chartListData;
  List<String> subjectListDropDownValues =
      []; //  Data of SubjectName to the DropDownValue
  bool _isLoadAccountView = false;

  bool get isLoadAccountView => _isLoadAccountView;

  String? get subjectValue => _subjectValue;
  AchievementModel? get achievementModel => _achievementModel;
  List<double> get chartListData => _chartListData;

  String selectedSubject() => _subjectValue!;
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

    handelTheLogic(); // to call Achievement Service
  }

  void updateSubject(String value) {
    if (value == _subjectValue) {
      return; // if Selected Value Equal the Value  before   return from Method
    }

    _subjectValue = value;
    update(['updateSubject']);
    DialogHelper.showLoading();
    getAchievementService(subjectId: getSubjectId); // call the Api Again
  }
////////////////////////////////////////// Some Logic Method ///////////////////////////////////////

  double maxNumberInCharts() {
    print("The Max is : ${chartListData[0]}");
    double max = chartListData[0];

    for (int i = 1; i < chartListData.length; i++) {
      if (chartListData[i] > max) max = chartListData[i];
    }

    return max;
  }

  int? get getSubjectId => subjectListData
      .firstWhere((element) => (element.name == subjectValue),
          orElse: () => DataSubjectModel())
      .id;

/////////////////////////////////////////////////// Service //////////////////////////////////////////

  void handelTheLogic() {
    // getSubject , saveTheList Subject Name, id  to R,
    getSubjectFromCahce().then((value) {
      subjectListData = value; // to Save the Object of the Subject

      _subjectValue = "الكل"; // to make the Deualt value
      subjectListDropDownValues.add("الكل");
      subjectListDropDownValues.addAll(subjectListData
          .map((e) => e.name!)
          .toList()); // To intlize the Data of Subject to the String Values DropDownValue
      print("*" * 50);
      print(getSubjectId);
      print("*" * 50);

      getAchievementService(subjectId: getSubjectId); // call the Api Again
    });
  }

  Future<List<DataSubjectModel>> getSubjectFromCahce() async {
    List<DataSubjectModel> subjectList = CacheSubjectService.instance.isExist()
        ? CacheSubjectService.instance.getSubjects()!.data!
        : [];

    return Future.value(subjectList);
  }

  void getAchievementService({int? subjectId}) {
    _isLoadAccountView = false;
    ExamRepositoryService().getAchievement(subjectId: subjectId).then((value) {
      _achievementModel = value;
      _chartListData = _achievementModel.data!.chart!.data!
          .map((e) => e.toDouble())
          .toList();
      _isLoadAccountView = true;

      update();
    }).catchError((e, s) {
      debugPrint(s.toString());
      SnackBarHelper.instance.showMessage(message: e.toString(), erro: true);
    }).whenComplete(() => DialogHelper.hideLoading());
  }
}
