import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quizzy_app/Service/api/repository_implementaion_service/exam_repository_service.dart';
import 'package:quizzy_app/model/top_student_dataModel.dart';
import 'package:quizzy_app/utils/constant/exam_costant.dart';
import 'package:quizzy_app/utils/dialog_helper.dart';
import 'package:quizzy_app/utils/snack_bar_helper.dart';

import 'package:quizzy_app/view_model/exam/manage_exam_view_model.dart';

class TopPointViewModel extends GetxController {
  final List<TopStudentDataModel> _topStudentList = [];
  ScrollController _scrollController = ScrollController();

  int _topStudentPage = 1;
  final int _topStudentLimit = 4;
  bool _hasMoreDataTopStudent = false;
  bool _hasNextPageTopStudent = true;
  bool _isLoadTopPointView = false;
  late int? _subjectId;
  late int? _examSpeciaListId;
  late bool _isSpecialistExam;
  List<TopStudentDataModel> get topStudentList => _topStudentList;
  ScrollController get scrollController => _scrollController;
  bool get hasNextPageTopStudent => _hasNextPageTopStudent;
  bool get hasMoreDataTopStudent => _hasMoreDataTopStudent;
  bool get isLoadTopPointView => _isLoadTopPointView;
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

    _isSpecialistExam = (Get.find<ManageExamViewModel>().examData.data!.type ==
        ExamConstatnt.specialistExam);
    print(Get.find<ManageExamViewModel>().examData.data!.type);
    // to Know if I get the Statsitci in Exam Specialist or Each Subject
    if (_isSpecialistExam) {
      _examSpeciaListId =
          Get.find<ManageExamViewModel>().startQuizModel.data?.id;
      _subjectId = null;
    } else {
      _subjectId = Get.find<ManageExamViewModel>().examData.data!.subjectId!;

      print(Get.find<ManageExamViewModel>().getsubjectName(_subjectId!));
      print(Get.find<ManageExamViewModel>().isExamAttempt);
      _examSpeciaListId = null;
    }
    debugPrint('isSpecailistExam : $_isSpecialistExam');
    debugPrint('isSpecailistExam : $_isSpecialistExam');
    scrollController.addListener(() => paginationTopStudent());

    getTopStudentService(
        limit: _topStudentLimit,
        page: _topStudentPage,
        selectedSubjectId: _subjectId,
        examIdOfStartQuiz: _examSpeciaListId);
  }

////////////////////////////////////////////////// Logic Section/////////////////////////////////////

  void paginationTopStudent() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      if (!_hasMoreDataTopStudent && _hasNextPageTopStudent) {
        _topStudentPage++;
        _hasMoreDataTopStudent = true;
        update(['updateTopStudent']);
        debugPrint("-" * 50);
        debugPrint("OK");
        debugPrint("-" * 50);
        getTopStudentService(
            page: _topStudentPage,
            limit: _topStudentLimit,
            examIdOfStartQuiz: _examSpeciaListId,
            selectedSubjectId: _subjectId);
      }
    }
  }

  ///////////////////////////////////////////////// Service //////////////////////////////////////////////
  Future<void> getTopStudentService(
      {int? page,
      int? limit,
      int? selectedSubjectId,
      int? examIdOfStartQuiz}) async {
    await ExamRepositoryService()
        .getTopStudentPoints(
            limit: limit,
            page: page,
            selectedSubjectId: selectedSubjectId,
            examIdOfStartQuiz: examIdOfStartQuiz)
        .then((value) {
      _hasMoreDataTopStudent = false;
      DialogHelper.hideLoading(); // to Close the Dailog when update the Subject
      List<TopStudentDataModel> result = value.data!.data ?? [];
      if (result.isEmpty) {
        _hasNextPageTopStudent = false;
      } else {
        _topStudentList.addAll(result); // add The Item in the List
      }

      if (!_isLoadTopPointView) {
        // if it the First Fetch Update the All Screen
        _isLoadTopPointView = true;
        debugPrint("-" * 50);
        update(['updateLoadTopPointView']);
      } else {
        update(['updateTopStudent']);
      }
      debugPrint("/" * 50);
      debugPrint(value.data!.meta!.total.toString());
      debugPrint(value.data!.meta!.perPage.toString());
      debugPrint(_topStudentList.length.toString());
      debugPrint(_subjectId.toString());
      debugPrint(
          "Current Page: ${value.data!.meta!.currentPage} , LastPage:${value.data!.meta!.lastPage}");
      debugPrint("/" * 50);
    }).catchError((e, s) {
      debugPrint(s.toString());
      SnackBarHelper.instance
          .showMessage(message: e.toString(), milliseconds: 2000, erro: true);
    });
  }
  ////////////////////////////////////////////////////////////////////////////////////////////////////////////

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }
}
