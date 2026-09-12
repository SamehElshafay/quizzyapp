import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quizzy_app/model/answers_model.dart';
import 'package:quizzy_app/model/questions_model.dart';
import 'package:quizzy_app/view_model/exam/manage_exam_view_model.dart';

class TrueFalseExamViewModel extends ChangeNotifier {
  bool isNotFirstTimeToLoadConstractor = false;
  late List<AnswersModel> listAnswersModel;
  late QuestionsModel questionsModel;
  late ManageExamViewModel manageExamViewModel;
  int? selectedIndex;
  bool isRevisionAnswers = false;
  // int? idQueion; // 4 true
  int? answerSelectedId;

  void initObject() {
    manageExamViewModel = Get.find<ManageExamViewModel>();

    questionsModel = manageExamViewModel.getCurrentQuestionModel(
        index: manageExamViewModel.currentQuetionIndex);
    listAnswersModel = questionsModel.answers!;
// when click the Button Back Show the Current Resut that Choice it before
    isRevisionAnswers = manageExamViewModel.isRevisionAnswers;
    print("Question Id ${questionsModel.id}");
    print(manageExamViewModel.answerSelectedByUser['${questionsModel.id}']);
    if (((manageExamViewModel.isAfterFinish ||
            manageExamViewModel.isRevisionAnswers) &&
        manageExamViewModel.answerSelectedByUser['${questionsModel.id}'] !=
            null)) {
      print("TRUE SUCESS");
      answerSelectedId =
          manageExamViewModel.answerSelectedByUser['${questionsModel.id}'];
      selectedIndex = getCurrentIndex(answerSelectedId!);
    } else {
      selectedIndex = null;
      answerSelectedId = null;
    }

    print("+" * 50);
    print("Sucess Init the object TrueFalseExamViewModel");
    print("+" * 50);
    if (isNotFirstTimeToLoadConstractor) notifyListeners();

    isNotFirstTimeToLoadConstractor = true;
  }

  TrueFalseExamViewModel() {
    initObject();
  }

  void onTap({required int idAnswerValue, required int index}) {
    if (manageExamViewModel.isRevisionAnswers)
      return; // if the Revsion Ansers skip
    if (idAnswerValue == answerSelectedId) return; // to Skip the rebuild
    answerSelectedId = idAnswerValue;

    selectedIndex = index;

    notifyListeners();
    print("-" * 50);
    print(
        "Question Id ${questionsModel.id} \n answerSelectedId:$answerSelectedId");
    addAnswer(answerValue: answerSelectedId!);
    print("-" * 50);
    print("OK");
  }

  void addAnswer({required int answerValue}) {
    manageExamViewModel.addAnswerQuestion(
        mapEntry: MapEntry(questionsModel.id.toString(), answerValue));
    manageExamViewModel.printMapOfAnswerQuestion();
  }

  int? getCurrentIndex(int answerSelectedId) {
    for (int i = 0; i < listAnswersModel.length; i++) {
      if (listAnswersModel[i].id == answerSelectedId) {
        return i;
      }
    }
    return null;
  }
}
