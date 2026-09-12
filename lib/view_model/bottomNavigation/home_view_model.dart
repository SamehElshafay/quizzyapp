import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quizzy_app/model/academic_year_model.dart';
import 'package:quizzy_app/Service/api/repository_implementaion_service/academic_years_repository_service.dart';
import 'package:quizzy_app/Service/api/repository_implementaion_service/auth_repository_service.dart';
import 'package:quizzy_app/Service/api/repository_implementaion_service/ads_repository_service.dart';
import 'package:quizzy_app/Service/api/repository_implementaion_service/exam_repository_service.dart';
import 'package:quizzy_app/Service/api/repository_implementaion_service/subjects_repository_service.dart';
import 'package:quizzy_app/Service/local/cache_subject_service.dart';
import 'package:quizzy_app/Service/local/cache_user_service.dart';
import 'package:quizzy_app/model/ads_model.dart';
import 'package:quizzy_app/model/data_subject_model.dart';
import 'package:quizzy_app/model/exam_attempts_model.dart';
import 'package:quizzy_app/model/exam_model.dart';
import 'package:quizzy_app/model/exams_model.dart';
import 'package:quizzy_app/model/top_student_dataModel.dart';
import 'package:quizzy_app/utils/check_connection_helper.dart';
import 'package:quizzy_app/utils/dialog_helper.dart';
import 'package:quizzy_app/utils/routes.dart';
import 'package:quizzy_app/utils/snack_bar_helper.dart';
import 'package:quizzy_app/view_model/bottomNavigation/mange_bottom_navigation_view_model.dart';
import 'package:quizzy_app/view_model/exam/manage_exam_view_model.dart';

class HomeViewModel extends GetxController {
  bool _isLoadHomeViewPage = false;
  late AdsModel _adsModel;

  final List<ExamAttemptsDataModel> _listExamAttempts = [];
  final List<ExamAttemptsDataModel> _searchExamAttemptsList = [];
  final List<TopStudentDataModel> _listTopStudent = [];

  final ScrollController _examAttemptScrollController = ScrollController();
  final ScrollController _topStudentScrollController = ScrollController();
  late List<AdsData> _adsList;

  List<AcademicYearModel> _academicYearsList = [];
  List<AcademicYearModel> get academicYearsList => _academicYearsList;

  bool get isLoadHomeViewPage => _isLoadHomeViewPage;
  void setIsLoadHomeViewPage({required bool show}) {
    _isLoadHomeViewPage = show;
    update();
    update(['updateExamAttempts']);
  }

  bool get hasMoreDataExam => _hasMoreDataExam;
  bool get hasNextPageExam => _hasNextPageExam;
  bool get hasMoreDataTopStudent => _hasMoreDataTopStudent;
  bool get hasNextPageTopStudent => _hasNextPageTopStudent;
  List<AdsData> get adsList => _adsList;
  List<String> get subjectListDropDownValues => _subjectListDropDownValues;

  List<ExamAttemptsDataModel> get listExamAttempts => _listExamAttempts;
  List<ExamAttemptsDataModel> get searchExamAttemptsList =>
      _searchExamAttemptsList;
  List<TopStudentDataModel> get listTopStudent => _listTopStudent;
  ScrollController get examAttemptScrollController =>
      _examAttemptScrollController;
  ScrollController get topStudentScrollController =>
      _topStudentScrollController;

  String? _subjectValue; // the Value of the Subject in DropDown
  late List<DataSubjectModel> subjectListData;
  List<String> _subjectListDropDownValues =
      []; //  Data of SubjectName to the DropDownValue

  String? get subjectValue => _subjectValue;
  String? text;

  int _examPage = 1;
  final int _examLimit = 1;
  bool _hasMoreDataExam = false;
  bool _hasNextPageExam = true;

  int _topStudentPage = 1;
  final int _topStudentLimit = 5;
  bool _hasMoreDataTopStudent = false;
  bool _hasNextPageTopStudent = true;

  @override
  void onInit() {
    // TODO: implement onInit

    super.onInit();
    getAcademicYearsList();
    handelTheLogic();
    examAttemptScrollController.addListener(() => examAttemptsPagination());
    _topStudentScrollController.addListener(() => topStudentPagination());
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
    print("close Home Controller");
  }

  void updateData() {
    text = "Mohamed";
    update();
  }

///////////////////////////////////////////////////////Helper///////////////////////////////////////////////////////////////////
  int? get getSubjectId => subjectListData
      .firstWhere((element) => (element.name == subjectValue),
          orElse: () => DataSubjectModel())
      .id;

  void searchExamAttempts({required String value}) {
    if (value.isEmpty) {
      // if clear All and The Search become Empty
      _searchExamAttemptsList.clear();
      _searchExamAttemptsList.addAll(_listExamAttempts);
    } else {
      _searchExamAttemptsList.clear();
      _searchExamAttemptsList.addAll(_listExamAttempts
          .where((element) => element.subject!.name!.contains(value))
          .toList());
    }

    update(['updateExamAttempts']);
  }

  void removeAnExamAttemptById({required int examAttemptId}) {
    _listExamAttempts.removeWhere((element) => (element.id == examAttemptId));
    _searchExamAttemptsList.clear();
    _searchExamAttemptsList.addAll(_listExamAttempts);
  }
///////////////////////////////////////////////////////Actions///////////////////////////////////////////////////////////////////

  void updateSubject(String value) async {
    if (value == _subjectValue) {
      return; // if Selected Value Equal the Value  before   return from Method
    }
    _subjectValue = value;

    update(['updateSubject']);

    DialogHelper.showLoading();
    int? subjectId =
        getSubjectId; // subject Can Be Null this mean it must Select "All"
    print("*" * 50);
    print(subjectId);
    print("*" * 50);
    // reset the Data of the End Point Top Student
    _hasMoreDataTopStudent = false;
    _hasNextPageTopStudent = true;
    _topStudentPage = 1;
    _listTopStudent.clear(); // to Clear All the List Data
    getTopStudentService(
        page: _topStudentPage,
        limit: _topStudentLimit,
        selectedSubjectId: subjectId); // call the Api Again
  }

  void onTapExamAttempt({int? index}) {
    if (_listExamAttempts.isEmpty) {
      Get.find<ManageBottomNavigationViewModel>()
          .gotToExamPageManuallyWithoutClickOnIt();
      print("Load the Default Page");
      // if no Element Suggest you to create a new Exam
      // go to the Exam
    } else {
      int examId = _listExamAttempts[index!].id!;
      Get.find<ManageExamViewModel>()
          .activeExamAttmpts(); // to know a Flag that is Exam Attempts
      loadAttemptExam(id: examId);
      // Call the Api and Load the Exam
    }
  }

  Future<void> getAcademicYearsList() async {
    try {
      var result = await AcademicYearsRepositoryService().getAllAcademicYear();
      if (result.data != null) {
        _academicYearsList = result.data!;
        update(['updateAcademicYears']);
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> changeAcademicYear(AcademicYearModel newYear) async {
    DialogHelper.showLoading();
    try {
      await AuthRepositoryService.instance
          .updateAcademicYear(academicYearId: newYear.id!);

      var currentUser = CacheUserService.instance.getUser();
      currentUser!.academicYearId = newYear.id;
      currentUser.academicYear = newYear;
      await CacheUserService.instance.updateUser(user: currentUser);
      update(['updateAcademicYears']);

      // Clear data to refetch
      _subjectListDropDownValues.clear();
      _listTopStudent.clear();
      _listExamAttempts.clear();
      _searchExamAttemptsList.clear();
      _adsList.clear();

      _hasMoreDataTopStudent = false;
      _hasNextPageTopStudent = true;
      _topStudentPage = 1;

      _hasMoreDataExam = false;
      _hasNextPageExam = true;
      _examPage = 1;

      handelTheLogic();
      DialogHelper.hideLoading();
    } catch (e) {
      DialogHelper.hideLoading();
      SnackBarHelper.instance.showMessage(message: e.toString(), erro: true);
    }
  }
///////////////////////////////////////////////////////Pagination/////////////////////////////////////////////////////////////////
  ///

  void topStudentPagination() {
    if (_topStudentScrollController.position.pixels ==
        _topStudentScrollController.position.maxScrollExtent) {
      print("Call TopStudent");
      if (!_hasMoreDataTopStudent && _hasNextPageTopStudent) {
        _topStudentPage++;
        _hasMoreDataTopStudent = true;
        update(['updateTopStudent']);
        int? subjectId =
            getSubjectId; // subject Can Be Null this mean it must Select "All"
        getTopStudentService(
            page: _topStudentPage,
            limit: _topStudentLimit,
            selectedSubjectId: subjectId);
      }
    }
  }

  void examAttemptsPagination() {
    if (_examAttemptScrollController.position.pixels ==
        _examAttemptScrollController.position.maxScrollExtent) {
      print("Call examAttemptsPagination");

      if (!_hasMoreDataExam && _hasNextPageExam) {
        _examPage++;
        _hasMoreDataExam = true;

        update(['updateExamAttempts']);
        getExamAttempts(page: _examPage, limit: _examLimit);
      }
    }
  }

////////////////////////////////////////////////////// Service ////////////////////////////////////////////////////////////////////
  ///
  ///
  ///
  Future<List<DataSubjectModel>> getSubject() async {
    List<DataSubjectModel>? subjectList;

    bool checkConnection = await CheckConnectionHelper.checkConnection();

    if (checkConnection) {
      try {
        var value = await SubjectsRepositoryService().getSubjects(
            academicYearId:
                CacheUserService.instance.getUser()!.academicYearId);

        subjectList = value.data!;
        Get.find<ManageExamViewModel>().getSubjects(list: subjectList);
        await CacheSubjectService.instance.updateSubjects(subjectsModel: value);
      } catch (e) {
        SnackBarHelper.instance.showMessage(message: e.toString(), erro: true);
        subjectList = CacheSubjectService.instance.isExist()
            ? CacheSubjectService.instance.getSubjects()!.data!
            : [];
        Get.find<ManageExamViewModel>().getSubjects(list: subjectList);
      }
    } else {
      subjectList = CacheSubjectService.instance.isExist()
          ? CacheSubjectService.instance.getSubjects()!.data!
          : [];
      Get.find<ManageExamViewModel>().getSubjects(list: subjectList);
    }

    print("*" * 50);
    print(subjectList);
    print("*" * 50);
    return Future.value(subjectList);
  }

  // await Get.find<ManageSubjectCacheViewModel>().isLoadSubjectFromServer();

  // return Future.value(CacheSubjectService.instance.getSubjects()!.data ?? []);

  void handelTheLogic() async {
    // get Subject From the Cache
    getSubject().then((value) async {
      subjectListData = value; // to Save the Object of the Subject

      _subjectValue = "الكل"; // to make the Deualt value
      subjectListDropDownValues.add("الكل"); // Add this in the First Subject
      subjectListDropDownValues.addAll(subjectListData
          .map((e) => e.name!)
          .toList()); // convert SubjectObject to String Values

// Applly The Concurrent Api to Perforem Performance
      Future.wait([
        getAds(),
        getExamAttempts(page: _examPage, limit: _examLimit),
        getTopStudentService(
            page: _topStudentPage,
            limit: _topStudentLimit,
            selectedSubjectId: getSubjectId)
      ]).then((value) {
        _isLoadHomeViewPage = true;
        update();
      });
    });
  }

  Future<void> getAds() async {
    await AdsRepositoryService().getAds().then((value) {
      _adsModel = value;

      _adsList = _adsModel.data ?? [];

      update(['updateAds']);

      // update();
    }).catchError((e) {
      _adsList = [];
      SnackBarHelper.instance
          .showMessage(message: e.toString(), milliseconds: 2000, erro: true);
    });
  }

  Future<void> getTopStudentService(
      {int? page, int? limit, int? selectedSubjectId}) async {
    await ExamRepositoryService()
        .getTopStudentPoints(
            limit: limit, page: page, selectedSubjectId: selectedSubjectId)
        .then((value) {
      _hasMoreDataTopStudent = false;
      DialogHelper.hideLoading(); // to Close the Dailog when update the Subject
      List<TopStudentDataModel> result = value.data!.data ?? [];
      if (result.isEmpty) {
        _hasNextPageTopStudent = false;
      } else {
        _listTopStudent.addAll(result); // add The Item in the List
      }
      update(['updateTopStudent']);
      debugPrint("/" * 50);

      debugPrint(_listTopStudent.length.toString());
      debugPrint(
          "Current Page: ${value.data!.meta!.currentPage} , LastPage:${value.data!.meta!.lastPage}");
      debugPrint("/" * 50);
    }).catchError((e) => SnackBarHelper.instance.showMessage(
            message: e.toString(), milliseconds: 2000, erro: true));
  }

  Future<void> getExamAttempts({int? page, int? limit}) async {
    await ExamRepositoryService()
        .getExamAttempts(limit: limit, page: page)
        .then((value) {
      _hasMoreDataExam = false;

      List<ExamAttemptsDataModel> result = value.data!.data ?? [];
      if (result.isEmpty) {
        _hasNextPageExam = false;
      } else {
        _listExamAttempts.addAll(result); // add The Item in the List
        _searchExamAttemptsList.addAll(result);
      }

      debugPrint("/" * 50);

      debugPrint(_listExamAttempts.length.toString());
      debugPrint(
          "Current Page: ${value.data!.meta!.currentPage} , LastPage:${value.data!.meta!.lastPage}");
      debugPrint("/" * 50);

      update(['updateExamAttempts']);
    }).catchError((e) => SnackBarHelper.instance.showMessage(
            message: e.toString(), milliseconds: 2000, erro: true));
  }

  void loadAttemptExam({required int id}) {
    // ExamsModel

    ExamRepositoryService().showExamAttempts(id: id).then((value) {
      Get.find<ManageExamViewModel>().setExamData(
          totalOfQuestionValue: value.data!.unsolvedQuestions!.length,
          examsModel: ExamsModel(
              data: ExamModel(
                  subjectId: value.data!.examAttempt!.subjectId,
                  // book Id Add it

                  type: value.data!.examAttempt!.exam!.type,
                  questions: value.data!.unsolvedQuestions,
                  id: value.data!.examAttempt!.exam!
                      .id)), // used when make a RepetionExam
          examAttemptModel: value.data!.examAttempt!);
    }).catchError((e) =>
        SnackBarHelper.instance.showMessage(message: e.toString(), erro: true));

    Get.toNamed(Routes.examView);
  }

  void updateHomeView() {
    update();
  }
  /////////////////////////////////////////////
}
