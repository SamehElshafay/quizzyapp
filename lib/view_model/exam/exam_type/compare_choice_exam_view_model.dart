import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quizzy_app/model/answers_model.dart';
import 'package:quizzy_app/model/questions_model.dart';
import 'package:quizzy_app/view_model/exam/manage_exam_view_model.dart';

class CompareChoiceExamViewModel extends ChangeNotifier {
  bool isNotFirstTimeToLoadConstractor = false;
  late List<AnswersModel> listAnswersModel;
  late QuestionsModel questionsModel;
  late ManageExamViewModel manageExamViewModel;
  late TextEditingController answerTextController;

  void initObject() {
    manageExamViewModel = Get.find<ManageExamViewModel>();

    answerTextController = TextEditingController();
    questionsModel = manageExamViewModel.getCurrentQuestionModel(
        index: manageExamViewModel.currentQuetionIndex);
    listAnswersModel = questionsModel.answers!;
    print("+" * 50);
    print("Sucess Init the CompareChoiceExamViewModel");
    print("+" * 50);
    if (isNotFirstTimeToLoadConstractor) notifyListeners();

    isNotFirstTimeToLoadConstractor = true;
  }
}
