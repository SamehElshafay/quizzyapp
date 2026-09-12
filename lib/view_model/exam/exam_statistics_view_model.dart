import 'dart:async';

import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:quizzy_app/Service/api/repository_implementaion_service/attempt_answers_repository_service.dart';
import 'package:quizzy_app/Service/local/cache_user_service.dart';
import 'package:quizzy_app/Service/premession/permission_service.dart';
import 'package:quizzy_app/model/exam_attempt_model.dart';
import 'package:quizzy_app/model/exam_statistics_model.dart';
import 'package:quizzy_app/utils/dialog_helper.dart';

import 'package:quizzy_app/utils/pdf_helper/pdf_generator.dart';
import 'package:quizzy_app/utils/routes.dart';
import 'package:quizzy_app/utils/snack_bar_helper.dart';
import 'package:quizzy_app/view_model/bottomNavigation/home_view_model.dart';
import 'package:quizzy_app/view_model/bottomNavigation/mange_bottom_navigation_view_model.dart';
import 'package:quizzy_app/view_model/exam/manage_exam_view_model.dart';
import 'package:share_plus/share_plus.dart';

class ExamStatisticsViewModel extends GetxController {
  bool _isLoadExamStatisticsViewPage = false;
  late ExamStatisticsModel _examStatisticsModel;
  late ExamAttemptModel _examAttemptStatisticsInofrmation;
  bool get isLoadExamStatisticsViewPage => _isLoadExamStatisticsViewPage;
  ExamStatisticsModel get examStatisticsModel => _examStatisticsModel;
  ExamAttemptModel get examAttemptStatisticsInofrmation =>
      _examAttemptStatisticsInofrmation;
  ManageExamViewModel controllerOfMangeExamViewModel =
      Get.find<ManageExamViewModel>();

  late final String subjectName;
  late final String studentName;
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    subjectName = controllerOfMangeExamViewModel.getsubjectName(
        controllerOfMangeExamViewModel.examData.data!.subjectId!);
    studentName = CacheUserService.instance.getUser().name ?? "";
    PdfGenerator.init();
    int examAttemptId = controllerOfMangeExamViewModel.startQuizModel.data!.id!;

    _removeExamAttempt(
        examAttemptId:
            examAttemptId); // to remove the ExamAttempt From the List in the HomeviewModel

    _attemptAnswersService(examAttemptId: examAttemptId!);
  }

////////////////////////////////// Service ////////////////////////////////////
  ///
  void _attemptAnswersService({required int examAttemptId}) {
    _isLoadExamStatisticsViewPage = false;
    AttemptAnsweRepositoryService()
        .getAttemptAnswersById(examEttemptId: examAttemptId)
        .then((value) {
      print("-" * 50);
      print(value);

      print("-" * 50);

      _examStatisticsModel = value;
      _examAttemptStatisticsInofrmation = value.data!.examAttempt!;
      _isLoadExamStatisticsViewPage = true;
      update(["updateExamStatisticsView"]);
    }).catchError((e, s) {
      print('-' * 50);
      print(e.toString());
      print('-' * 50);

      print(s.toString());
      SnackBarHelper.instance
          .showMessage(message: e.toString(), milliseconds: 2000, erro: true);
    });
  }

  void repetitionExam() async {
    controllerOfMangeExamViewModel.resetAllController();
    DialogHelper.showLoading(
        message: 'يتم الان إعادة الاختبار ....',
        textDirection: TextDirection.rtl);

    update(['updateAboveSection', 'updateBlewSection']);
    await controllerOfMangeExamViewModel
        .startQuizService(
            examId: controllerOfMangeExamViewModel.examData.data!.id!)
        .then((value) {
      Timer(
        controllerOfMangeExamViewModel.isExamAttempt
            ? const Duration(seconds: 5)
            : const Duration(seconds: 5),
        () {
          // Navigate to your favorite place
          DialogHelper.hideLoading();
          update(['updateAboveSection', 'updateBlewSection']);
          // to update when The Dialog Disposed
          controllerOfMangeExamViewModel
              .resetValueOfRepitionExam(); // to _isLoafExamViewPage False , Map of Answers
          controllerOfMangeExamViewModel.updateTheCurrentExamType();
          Get.until((route) => Get.currentRoute == Routes.examView);
          controllerOfMangeExamViewModel.updateTheCurrentExamType();
          controllerOfMangeExamViewModel.resetDurationTimer();
        },
      );
    }); // to call the StartQuiz Again
  }

  void revisionaAnswers() {
    controllerOfMangeExamViewModel.resetAllController();
    DialogHelper.showLoading(
        message: "يتم الان مراجعة الإجابات", textDirection: TextDirection.rtl);
    controllerOfMangeExamViewModel
        .resetValueRevisonAnswers(); // to _isLoafExamViewPage False , Map of Answers
    update(['updateAboveSection', 'updateBlewSection']);
    Timer(
      const Duration(seconds: 3),
      () {
        // Navigate to your favorite place
        DialogHelper.hideLoading();

        // to update when The Dialog Disposed
        controllerOfMangeExamViewModel.resetDurationTimer();
        Get.toNamed(Routes.examView);
        controllerOfMangeExamViewModel.updateTheCurrentExamType();
      },
    ); // to call the StartQuiz
  }

  void _removeExamAttempt({required int examAttemptId}) {
    // use in go to Home , ReptionExam
    if (controllerOfMangeExamViewModel.isExamAttempt) {
      // Remove this Exam from the HomView
      print("*" * 50);
      print(examAttemptId);
      print("*" * 50);
      Get.find<HomeViewModel>()
          .removeAnExamAttemptById(examAttemptId: examAttemptId);
    }
  }

  void goToHomePage() {
    controllerOfMangeExamViewModel.resetAllController();
    controllerOfMangeExamViewModel.resetController();
    ManageBottomNavigationViewModel manageBottomNavigationViewModel =
        Get.find<ManageBottomNavigationViewModel>();

    HomeViewModel homeViewModel = Get.find<HomeViewModel>();
    if (controllerOfMangeExamViewModel.isExamAttempt) {
      // Get.offAllNamed(Routes.bottomNavgation);
      // manageBottomNavigationViewModel.gotToHomePageManuallyWithoutClickOnIt();

      homeViewModel.setIsLoadHomeViewPage(show: false); // to diable homeView

      Timer(const Duration(seconds: 2), () {
        Get.until((route) => Get.currentRoute == Routes.bottomNavgation);
        homeViewModel.setIsLoadHomeViewPage(
            show: true); // to update the HomeView

        // manageBottomNavigationViewModel.gotToHomePageManuallyWithoutClickOnIt();
      });
    } else {
      manageBottomNavigationViewModel.gotToHomePageManuallyWithoutClickOnIt();
      Get.until((route) => Get.currentRoute == Routes.bottomNavgation);
    }
  }

  void convertToPdf() async {
    // var permissionStatus = await Permission.storage.status;
    try {
      DialogHelper.showLoading();
      bool isGranted = await PermissionService.instance.checkStorage();

      if (isGranted) {
        String path = await PdfGenerator.createPdf(
            studentName: studentName,
            subjectName: subjectName,
            examAttemptStatisticsInofrmation:
                _examAttemptStatisticsInofrmation);
        debugPrint('Pdf path ; $path');
      }
    } catch (e) {
      SnackBarHelper.instance.showMessage(
          message: 'حدث خطأ أثناء تنفيذ هذه العملية \n ${e.toString()}',
          erro: true,
          isEnglish: false);
    } finally {
      DialogHelper.hideLoading();
    }
  }

  void shareFile() async {
    try {
      DialogHelper.showLoading();
      String? path = await PdfGenerator.createImg(
          studentName: studentName,
          subjectName: subjectName,
          examAttemptStatisticsInofrmation: _examAttemptStatisticsInofrmation);

      //  await OpenFile.open(path);

      debugPrint('Image path ; $path');

      DialogHelper.hideLoading();

      if (path != null) {
        await Share.shareXFiles([XFile(path)],
            text:
                "مشاركة نتيجة الإمتحان في مادة ${subjectName}\n للطالب :  ${studentName}");
      } else {
        debugPrint('حدث خطأ أثناء المشاركة');
      }
    } catch (e) {
      SnackBarHelper.instance.showMessage(
          message: 'لم يتم مشاركة نيتجة هذا الإمتحان \n${e.toString()}',
          erro: true,
          isEnglish: false);
    } finally {
      DialogHelper.hideLoading();
    }
  }

  void topPointRoute() {
    Get.toNamed(Routes.topPoint);
  }
}
