import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:quizzy_app/Service/api/repository_implementaion_service/exam_repository_service.dart';
import 'package:quizzy_app/Service/api/repository_implementaion_service/questions_repository_service.dart';
import 'package:quizzy_app/Service/local/cache_subject_service.dart';
import 'package:quizzy_app/model/answer_question_model.dart';
import 'package:quizzy_app/model/book_model.dart';
import 'package:quizzy_app/model/data_subject_model.dart';
import 'package:quizzy_app/model/exam_attempt_model.dart';
import 'package:quizzy_app/model/exam_model.dart';
import 'package:quizzy_app/model/exams_model.dart';
import 'package:quizzy_app/model/questions_model.dart';
import 'package:quizzy_app/model/send_note_or_wrong_to_question_mode.dart';
import 'package:quizzy_app/model/start_quiz_model.dart';
import 'package:quizzy_app/model/store_exam_model.dart';
import 'package:quizzy_app/model/timer_model.dart';
import 'package:quizzy_app/utils/constant/exam_costant.dart';
import 'package:quizzy_app/utils/dialog_helper.dart';
import 'package:quizzy_app/utils/routes.dart';
import 'package:quizzy_app/utils/snack_bar_helper.dart';
import 'package:quizzy_app/view/screens/exam/choose_book.dart';

import 'package:quizzy_app/view/screens/exam/choose_subject.dart';

import 'package:quizzy_app/view/screens/exam/exam_type/compare_exam.dart';
import 'package:quizzy_app/view/screens/exam/exam_type/long_short_answer_exam.dart';
import 'package:quizzy_app/view/screens/exam/exam_type/matching_exam.dart';
import 'package:quizzy_app/view/screens/exam/exam_type/multiple_choice_exam.dart';
import 'package:quizzy_app/view/screens/exam/exam_type/single_choice_exam.dart';
import 'package:quizzy_app/view/screens/exam/exam_type/true_false_exam.dart';
import 'package:quizzy_app/view/screens/exam/filter_questions_view.dart';
import 'package:quizzy_app/view/screens/exam/quiz_type_view.dart';
import 'package:quizzy_app/view_model/bottomNavigation/home_view_model.dart';
import 'package:quizzy_app/view_model/bottomNavigation/mange_bottom_navigation_view_model.dart';
import 'package:quizzy_app/view_model/exam/exam_type/multiple_choice_exam_view_model.dart';
import 'package:quizzy_app/view_model/exam/exam_type/short_long_answer_choice_exam_provider_view_model.dart';
import 'package:quizzy_app/view_model/exam/exam_type/single_choice_exam_view_model.dart';
import 'package:quizzy_app/view_model/exam/exam_type/true_false_exam_view_model.dart';
import 'package:quizzy_app/view_model/media/video_view_model.dart';

import '../../utils/constant.dart';

class ManageExamViewModel extends GetxController {
  Timer? timer;
  Duration duration = const Duration(seconds: 0);
  TextEditingController noteController = TextEditingController();
  bool _isClickSendNote = false;
  bool _isClickWrongAnswer = false;
  bool _isLoadChoicePage = false;
  int _currentManageExamsPagesIndex = 0;
  int _currentQuetionIndex = 0;
  int _currentExamTypeIndex = 0;
  int _countOfQuestion = 1;
  int _totalOfQuestion = 0;
  bool _isAfterFinish = false;
  bool _isExamAttempt = false;
  bool _isRevisionAnswers = false;
  String _examTypeMessage = "الإختبار";
  Map<String, int> _timeCounterMap = {};
  String _counterTimerValue = "0";

  DataSubjectModel? _subjectSelectedInformation;
  BookModel? _bookSelected;
  StartQuizModel? _startQuizModel;
  bool _isLoadExamViewPage = false;
  late List<DataSubjectModel> _subjectList;
  List<DataSubjectModel> _searchSubjectList = [];
  List<BookModel> _bookList = [];
  List<BookModel> _seachBookList = [];
  void activeExamAttmpts() => _isExamAttempt = true;

  void resetDurationTimer() {
    duration = const Duration(seconds: 1);
    update(['updateTimer']);
  }

  final List<Widget> _examTypeList = [
    const CompareExam(),
    const LongShortAnswerExam(),
    const MultipleChoiceExam(),
    const TrueFalseExam(),
    const SingleChoiceExam(),
    const MatchingExam(),
  ];
  final List<Widget> _examViewList = const [
    ChooseSubjectView(),
    ChooseBookView(),
    QuizTypeView(),
    FilterQuestionsView(),
    // ExamView(),
  ];

  ExamsModel? _examData;

  Map<String, dynamic> _mapAnswersOfExam = {};
  Map<String, bool> _mapCorrectAnswers = {};

  List<Widget> get examViewList => _examViewList;

  void addAnswerQuestion({required MapEntry<String, dynamic> mapEntry}) {
    _mapAnswersOfExam.addEntries({mapEntry});
  }

  void addCorrectAnswers({required MapEntry<String, bool> mapEntry}) {
    _mapCorrectAnswers.addEntries({mapEntry});
  }

  void printMapOfAnswerQuestion() {
    print(_mapAnswersOfExam);
  }

  bool get isLoadChoicePage => _isLoadChoicePage;
  bool get isExamAttempt => _isExamAttempt;
  bool get isLoadExamViewPage => _isLoadExamViewPage;
  bool get isRevisionAnswers => _isRevisionAnswers;
  String get examTypeMessage => _examTypeMessage;
  String get counterTimerValue => _counterTimerValue;

  void setAfterFinish() => _isAfterFinish = true;
  bool get isAfterFinish => _isAfterFinish;
  Map<String, dynamic> get answerSelectedByUser => _mapAnswersOfExam;

  dynamic answerUserSelected({required int questionId}) =>
      _mapAnswersOfExam['$questionId'];
  bool isCorrectAnswer({required String questionId}) =>
      _mapCorrectAnswers['$questionId']!;
  Map<String, int> get timeCounterMap => _timeCounterMap;

  void resetValueOfLoadExamViewPage() => _isLoadExamViewPage = false;

  void updatefLoadExamViewPage() {
    _isLoadExamViewPage = true;
    update(['LoadExamViewPage', 'updateLinearProgres']);
  }

  void resetMapAnswer() => _mapAnswersOfExam = {};
  void resetValueOfRepitionExam() {
    _isLoadExamViewPage = false;
    _mapAnswersOfExam.clear();
    _mapCorrectAnswers.clear();
    _timeCounterMap.clear();
    _currentQuetionIndex =
        0; // we will use it When Repetion , reviseons Answer The Exam
    _countOfQuestion =
        1; // set we will use it When Repetion , reviseons Answer The Exam

    if (_isExamAttempt) {
      updateTheCurrentExamType();
    }
    // _counterTimerValue = "0";
    duration = const Duration(seconds: 0);
    resetVideoController(); // to Reset Video Controller
    resetAllController(); // this Solve the Problem of Nested Controller
  }

  void resetValueRevisonAnswers() {
    _isLoadExamViewPage = true;

    _timeCounterMap.clear();
    _currentQuetionIndex = 0;
    // _countOfQuestion = 1;

    // if you need to download All revision set the count =1
    _countOfQuestion = _startQuizModel!.data!.totalAnsweredQuestions == 0
        ? 1
        : _startQuizModel!.data!.totalAnsweredQuestions!;
    updateTheCurrentExamType();
    // updateTheCurrentExamType();
    // updateTheCurrentExamType
    // _counterTimerValue = "0";
    duration = const Duration(seconds: 0);
    resetVideoController(); // to Reset Video Controller
    resetAllController(); // this Solve the Problem of Nested Controller
    _isAfterFinish = false;
    _isRevisionAnswers = true;
  }

  List<DataSubjectModel> get subjectList => _subjectList;
  List<DataSubjectModel> get searchSubjectList => _searchSubjectList;
  List<BookModel> get bookList => _bookList;
  List<BookModel> get seachBookList => _seachBookList;

  DataSubjectModel get getSubjectSelectedInformation =>
      _subjectSelectedInformation!;
  BookModel get getBookSelected => _bookSelected!;
  StartQuizModel get startQuizModel => _startQuizModel!;
  ExamsModel get examData => _examData!;
  bool get isEmptyExam => (_examData!.data!.questions == null) ||
          (_examData!.data!.questions!.isEmpty)
      ? true
      : false;

  void setExamData(
      {required ExamsModel examsModel,
      required int totalOfQuestionValue,
      required ExamAttemptModel examAttemptModel}) {
    if (timer != null) {
      if (timer!.isActive) timer!.cancel();
    }
    _timeCounterMap.clear();
    _mapAnswersOfExam.clear();
    _mapCorrectAnswers.clear();
    duration = const Duration(seconds: 0);

    _isLoadExamViewPage = false;
    _isAfterFinish = false; // must be false
    _examData = examsModel;
    _subjectSelectedInformation =
        DataSubjectModel(id: examAttemptModel.subjectId);
    _bookSelected = BookModel(id: examAttemptModel.bookId);
    // _countOfQuestion = examAttemptModel.totalAnsweredQuestions! == 0
    //     ? 1
    //     : examAttemptModel.totalAnsweredQuestions!;
    _countOfQuestion = examAttemptModel.totalAnsweredQuestions!;
    _currentQuetionIndex = 0;
    _startQuizModel = StartQuizModel(
        data: StartQuizData(
      totalAnsweredQuestions: examAttemptModel.totalAnsweredQuestions,
      totalQuestions: examAttemptModel.totalQuestions,
      bookId: examAttemptModel.bookId,
      studentId: examAttemptModel.studentId,
      id: examAttemptModel.id,
      examId: examAttemptModel.examId,

      // totalMarks: examAttemptModel.totalMarks,
    ));
    _totalOfQuestion = _startQuizModel!
        .data!.totalQuestions!; // intialize the Value of total Question
    _isLoadExamViewPage = true; // to updateScreen
    if (!isNoQuestionExist) {
      updateTheCurrentExamType();
    }

    startTimer();
    update([
      'LoadExamViewPage',
      'updateLinearProgres'
    ]); //update  the Question Type
  }

  bool get isNoQuestionExist =>
      _examData!.data!.questions!.isEmpty ? true : false;
  List<Widget> get examTypeList => _examTypeList;
  int get currentQuetionIndex => _currentQuetionIndex;
  int get currentManageExamsPagesIndex => _currentManageExamsPagesIndex;
  void setCurrentManageExamsPagesIndex(int index) =>
      _currentManageExamsPagesIndex = index;
  int get currentExamTypeIndex => _currentExamTypeIndex;
  int get totalOfQuestion => _totalOfQuestion;
  int get countOfQuestion => _countOfQuestion;
  bool get isFirstQuestion => (_currentQuetionIndex == 0);
  bool get isLastQuestion =>
      (_currentQuetionIndex == examData.data!.questions!.length - 1);
  QuestionsModel getCurrentQuestionModel({required int index}) {
    return _examData!.data!.questions![index];
  }

  bool isNoSourceInputForThisQuestion() {
    QuestionsModel questionsModel =
        _examData!.data!.questions![_currentQuetionIndex];
    return questionsModel.fileType == null && questionsModel.photo == null
        ? true
        : false;
  }

  void chooseSubject({required DataSubjectModel subjectSelectedInformation}) {
    _searchSubjectList =
        subjectList; // to make the Search has a Defualt Value of the Subject
    _subjectSelectedInformation = subjectSelectedInformation;
    _bookList = _subjectSelectedInformation!.books ?? [];
    _seachBookList = _bookList; // to peformSearch
    _currentManageExamsPagesIndex = 1;
    update(['updateCurrentManageExamsPagesIndex']);
  }

  void chooseBook({required BookModel bookModel}) {
    _seachBookList =
        bookList; // to make the Search has a Defualt Value of the Book
    _bookSelected = bookModel;
    _currentManageExamsPagesIndex = 2; // update Book Index
    update(['updateCurrentManageExamsPagesIndex']);
  }

  void backFromChooseBookView() {
    _currentManageExamsPagesIndex = 0;
    update(['updateCurrentManageExamsPagesIndex']);
  }

  void backFromQuizViewType() {
    _currentManageExamsPagesIndex = 1;
    update(['updateCurrentManageExamsPagesIndex']);
  }

  void backFromExamViewPage() {
    resetController();

    if (Get.find<ManageBottomNavigationViewModel>().isCurrentHomePage()) {
      Get.find<HomeViewModel>().setIsLoadHomeViewPage(show: false);
      Get.back();
      Timer(const Duration(seconds: 1), () {
        Get.find<HomeViewModel>().setIsLoadHomeViewPage(show: true);
      });
    } else {
      Get.back(); // back to The Exam
    }
  }

  void backFromFilter() {
    _currentManageExamsPagesIndex = 2;
    update(['updateCurrentManageExamsPagesIndex']);
    Get.delete<FilterQuestionsView>(force: true);
  }

  void createYourExamByFilter() {
    _currentManageExamsPagesIndex = 3;
    update(['updateCurrentManageExamsPagesIndex']);
    // call api Repositry for filter Question
  }

  void getTheTypeOfExamMessage() {}

  void confirmFilter(
      {int? leasonId,
      String? level,
      String? semesterId,
      int? time,
      String? typeAssessment,
      List<String>? questionTypes,
      int? unitId}) {
    // _currentIndex = 3;
    // update();
    // call api to create Exam Based on Filter information
    // if it Choce the typeOfAssessment AfterFinish

    print("*" * 50);
    print(questionTypes);
    print("*" * 50);
    if (ExamConstatnt.typeAssessmentAfterFinish == typeAssessment) {
      _isAfterFinish = true;
    } else {
      _isAfterFinish = false;
    }
    _examTypeMessage = "الإختبار الإختياري";
    _choiceExamService(
        leasonId: leasonId,
        level: level,
        semesterId: semesterId,
        time: time,
        typeAssessment: typeAssessment,
        questionTypes: questionTypes,
        unitId: unitId);
  }

  void createOtherExam(QuizType quizType) {
    // _currentIndex = 3;
    // update();
    // call api Service to create Exam for other Quetion (Q)
    // ( quizType== QuizType.ai ) // call Api for Ai Reposirty

    if (QuizType.ai == quizType) {
      _examTypeMessage = "الإختبار لمعالجة الضعف بالذكاء الاصطناعي";
      _aiExamService();
    } else if (QuizType.random == quizType) {
      _examTypeMessage = "الإختبار العشوائي";
      _randomExamService();
    } else {
      _examTypeMessage = "الإختبار من مختص";
      SnackBarHelper.instance.showMessage(
          message: "يتم ظهور هذه الميزة عند اضافة المدرس",
          milliseconds: 2000,
          isEnglish: false,
          erro: true);
      return;
      _specialistExamService();
    }
    // Get.toNamed(Routes.examView);
  }

  void resetController() {
    _currentManageExamsPagesIndex = 0;
    _currentExamTypeIndex = 0;
    _currentQuetionIndex = 0;
    _isLoadExamViewPage = false;
    duration = const Duration(seconds: 0);
    _timeCounterMap.clear();
    noteController.clear(); // to clear the note Controller
    _isClickSendNote = false; // to Clear it
    _isClickWrongAnswer = false; // to Clear it
    _mapAnswersOfExam.clear(); // clear the Map
    _mapCorrectAnswers.clear();
    _countOfQuestion = 1;
    _totalOfQuestion = 0;
    _isAfterFinish = false;
    _isExamAttempt = false;
    _isRevisionAnswers = false;

    _searchSubjectList =
        _subjectList; // to Solve problem when selecte an Page from BottomSheet

    if (timer != null) {
      if (timer!.isActive) timer!.cancel();
    }
  }

///////////////////////// Helper Methods //////////////////////////////

  void updateTheCurrentExamType() {
    /*
 [
    const CompareExam(),
    const LongAnswerExam(),
    const MultipleChoiceExam(),
    const TrueFalseExam(),
    const SingleChoiceExam()
  ];
    */

    String typeOfQuestion =
        _examData!.data!.questions![_currentQuetionIndex].type!;

    print("-" * 50);
    print(typeOfQuestion);
    print("-" * 50);
    switch (typeOfQuestion) {
      case ExamConstatnt.compare:
        _currentExamTypeIndex = 0;
        break;
      case ExamConstatnt.longAnswer:
        _currentExamTypeIndex = 1;
        break;
      case ExamConstatnt.shortAnswer:
        _currentExamTypeIndex = 1;
        break;
      case ExamConstatnt.multipleChoice:
        _currentExamTypeIndex = 2;
        break;
      case ExamConstatnt.trueFalse:
        _currentExamTypeIndex = 3;
        break;
      case ExamConstatnt.singleChoice:
        _currentExamTypeIndex = 4;
        break;
      case ExamConstatnt.matching:
        _currentExamTypeIndex = 5;
        break;
    }
    update(['examType']);
  }

  void resetVideoController() {
    print("-" * 80);
    print("Rest Video Controller");
    print("-" * 80);

    if (ExamConstatnt.isPageHasVideo) {
      Provider.of<VideoViewModel>(ExamConstatnt.currentContextVideo,
              listen: false)
          .deleteControllerManually();
      print("-" * 50);
      print("Delete it Manually");
      print("-" * 50);
    }
  }

  Future<void> resetAllController() async {
    print("/" * 60);
    print("Current Exam Type : $_currentExamTypeIndex");
    print("/" * 60);

    String typeOfQuestion =
        _examData!.data!.questions![_currentQuetionIndex].type!;
    print("/" * 60);
    print("Type Exam Type : $_currentExamTypeIndex");
    print("/" * 60);
    switch (_currentExamTypeIndex) {
      // case 0:
      //   await Get.delete<CompareChoiceExamViewModel>(force: true);

      //   break;
      case 1:
        if (typeOfQuestion != ExamConstatnt.shortAnswer &&
            typeOfQuestion != ExamConstatnt.longAnswer) return;
        Provider.of<ShortLongAnswerViewModel>(
                ExamConstatnt.currentContextQuestion,
                listen: false)
            .initObject();
        break;
      case 2:
        if (typeOfQuestion != ExamConstatnt.multipleChoice) return;
        Provider.of<MultipleChoiceExamViewModel>(
                ExamConstatnt.currentContextQuestion,
                listen: false)
            .initObject();
        break;
      case 3:
        if (typeOfQuestion != ExamConstatnt.trueFalse) return;
        Provider.of<TrueFalseExamViewModel>(
                ExamConstatnt.currentContextQuestion,
                listen: false)
            .initObject();
        break;
      case 4:
        if (typeOfQuestion != ExamConstatnt.singleChoice) return;
        Provider.of<SingleChoiceExamViewModel>(
                ExamConstatnt.currentContextQuestion,
                listen: false)
            .initObject();
        break;

      //       case 5:
      // if (typeOfQuestion != ExamConstatnt.matching) return;
      // Provider.of<SingleChoiceExamViewModel>(
      //         ExamConstatnt.currentContextQuestion,
      //         listen: false)
      //     .initObject();
      // break;

      // ناقص COMPARE
    }
  }
/////////////////////////////////// Button Action///////////////////////
  ///

  void backFromExam() {
    timer!.cancel();

    timeCounterMap.clear();
    Get.back();
    resetAllController();
  }

  void canselTime() {
    timer!.cancel();
  }

  void backQuestion() {
    QuestionsModel currentQuestionModel =
        getCurrentQuestionModel(index: _currentQuetionIndex);
    noteController.clear(); // to clear the note Controller
    _isClickSendNote = false; // to Clear it
    _isClickWrongAnswer = false; // to Clear it
    _timeCounterMap['${currentQuestionModel.id}'] = duration
        .inSeconds; // save the Current Value of the CounterTimerValue before decrement the new Question
    resetVideoController(); // to Reset Video Controller

    if (_currentQuetionIndex > 0) {
      _currentQuetionIndex--; // decrement the index of the  Question
      _countOfQuestion--; // decrement the number of Question
      resetAllController(); // this Solve the Problem of Nested Controller
      update([
        "updateLinearProgres",
        "updateAboveSection",
        "updateBlewSection"
      ]); // update the Above Section

      updateTheCurrentExamType(); // update  the Question Type

      // update the Timer for the back Question
      duration = Duration(
          seconds: _timeCounterMap[
              "${getCurrentQuestionModel(index: _currentQuetionIndex).id}"]!);
      update(['updateTimer']);
    } else {
      debugPrint("-" * 50);
      debugPrint("This is the First Question");
      debugPrint("-" * 50);
    }
  }

  void nextQuestion() async {
    QuestionsModel currentQuestionModel =
        getCurrentQuestionModel(index: _currentQuetionIndex);

    debugPrint("-" * 50);
    debugPrint("Question Id ${currentQuestionModel.id}");
    debugPrint("-" * 50);

////////////////////////////////// Send Note or Wrong Answer Section /////////////////////////////////////////

// if the Question have a Wrong Answer  or Note Call this
    if ((_isClickSendNote || _isClickWrongAnswer) && !_isRevisionAnswers) {
      _sendNoteAndWrongQuestion(
              notes: noteController.text,
              idQuestion: currentQuestionModel.id!,
              needReview: _isClickWrongAnswer)
          .then((value) {
        debugPrint(": " * 50);
        debugPrint(
            "Value of Send Note : ${value.message}  ${currentQuestionModel.id}");
        debugPrint(": " * 50);
        if (!value.success!) {
          SnackBarHelper.instance.showMessage(
              message: value.message.toString(),
              erro: true); // if the Id of the Question not Found
        } else {
          debugPrint("/ " * 50);
          debugPrint("Send Note : ${value.message}");
          debugPrint("/ " * 50);
        }
      });
    }
//////////////////////////////////////////////////////////////////////////////////////////////////////////////

/////////////////////////////////////// Send Answers Section ////////////////////////////////////////////////////////

    _timeCounterMap['${currentQuestionModel.id}'] = duration
        .inSeconds; // save the Current Value of the CounterTimerValue before (Send the Answer , Next Question)  the new Question
// printAll Questions Answer Map
    debugPrint("/ " * 50);
    debugPrint(" All Current Questions Answer $_mapAnswersOfExam");
    debugPrint(" All Time Of Questions  $_timeCounterMap");
    debugPrint(
        " The Answer of Current Question($_currentQuetionIndex), Questin Id(${currentQuestionModel.id})  Answer ${_mapAnswersOfExam['${currentQuestionModel.id}']}");
    debugPrint("/ " * 50);

    // send Anser if the TypeAssestment Direct

    if (!_isAfterFinish && !_isRevisionAnswers) {
      var resultOfTheCurrentQuestion =
          _mapAnswersOfExam['${currentQuestionModel.id}'];

      resultOfTheCurrentQuestion ??=
          ExamConstatnt.multipleChoice == currentQuestionModel.type ? [] : null;

      DialogHelper.showLoading(); // Show Diallog

      await answerQuestionService(
              questionId: currentQuestionModel.id!,
              timeSpent: _timeCounterMap['${currentQuestionModel.id}']!,
              givenAnswer: resultOfTheCurrentQuestion)
          .then((value) {
        DialogHelper.hideLoading(); // Hide Diallog
        if (!value!.success!) {
          SnackBarHelper.instance
              .showMessage(message: value.message!, erro: true);
        } else {
          debugPrint("/ " * 50);
          debugPrint(
              "Answer of Question Id ${currentQuestionModel.id}  Message : ${value.message}");
          debugPrint("/ " * 50);

          SnackBarHelper.instance.showMessage(
              // isCorrect is null in Short Answer Question
              isEnglish: false,
              message: value.data!.isCorrect == null
                  ? " لم يتم الانتهاء من تطوير التصحيح بالذكاء الاصطناعي ل الاسئلة المقالية"
                  : value.data!.isCorrect!
                      ? "إجابة صحيحة"
                      : "إجابة خاطئة ",
              erro: value.data!.isCorrect == null || !value.data!.isCorrect!);

          // Add to the Correct Answers
          addCorrectAnswers(
              mapEntry: MapEntry(
                  currentQuestionModel.id.toString(), value.data!.isCorrect!));
        }
      }).catchError((e) {
        debugPrint(e.toString());
        DialogHelper.hideLoading(); // Hide Diallog if any Erro Occur
      });
    }

    ///////////////////////////////// Loading for the Revision Exam //////////////////////////////////

    if (_isRevisionAnswers) {
      DialogHelper.showLoading(
          message: "يتم التحميل ...", textDirection: TextDirection.rtl);
      updateTheCurrentExamType();
      await Future.delayed(const Duration(seconds: 1));
      updateTheCurrentExamType();
      DialogHelper.hideLoading();
    }
    print("-" * 50);
    print("Correct Answer Maps");
    print(_mapCorrectAnswers);
    print("-" * 50);

//////////////////////////////////////////////////////////////////////////////////////////////////////////////

//////////////////////////////////////////////////Reset Value Section ////////////////////////////////////////////////////////////

    noteController.clear(); // to clear the note Controller
    _isClickSendNote = false; // to Clear it
    _isClickWrongAnswer = false; // to Clear it
    _currentQuetionIndex++; // increment the new Question
    _countOfQuestion++; // increment the number of Question
    resetVideoController(); // to Reset Video Controller
//////////////////////////////////////////////////////////////////////////////////////////////////////////////

///////////////////////////////////// Control Exam Page Section //////////////////////////////////////////////
    ///
    if (_currentQuetionIndex < examData.data!.questions!.length) {
      /*
      To Solve the Problem of this we need to call resetAllController()
      // to Reset All Provider Controler to delete the Data if we have  a nested of the Same Controller the Data is Shared betwen them 
      // the Controller not Removed if we have a Nested Controller of the Sampe Tyep
      */

      resetAllController(); // this Solve the Problem of Nested Controller
      update([
        "updateLinearProgres",
        "updateAboveSection",
        "updateBlewSection"
      ]); // update the Above Section

      updateTheCurrentExamType(); // update  the Question Type

      if (_isRevisionAnswers) {
        updateTheCurrentExamType(); // update  the Question Type
      }

      /////////////////////////////update the Timer for the Next Question////////////////////////////
      ///
      QuestionsModel currentNewQuestionModel =
          getCurrentQuestionModel(index: _currentQuetionIndex);
      if (_timeCounterMap["${currentNewQuestionModel.id}"] == null) {
        debugPrint("*" * 100);
        debugPrint("YES");
        debugPrint("*" * 100);
        // _counterTimerValue = "0";
        duration = const Duration(seconds: 0); //  reset the Counter Value
        _timeCounterMap["${currentNewQuestionModel.id}"] = duration.inSeconds;
      } else {
// this mean this is exist when use the After Finish Evaluation
        duration = Duration(
            seconds: _timeCounterMap["${currentNewQuestionModel.id}"]!);
        // _counterTimerValue = _timeCounterMap["${currentQuestionModel.id}"]!;
        debugPrint("*" * 100);
        debugPrint("no");
        debugPrint("*" * 100);
      }
      update(['updateTimer']);
////////////////////////////////////////////////////////////////////////////////////////
    } else {
      debugPrint("-" * 50);
      debugPrint("Exam Finished");
      debugPrint("-" * 50);

      if (_isAfterFinish) {
        await senAnswerAfterFinish(); // if is After Finish Send Answer
      }
      // when End The Exam Finsish Reset the currentQuestionIndex , countOfQuestion
      _currentQuetionIndex =
          0; // we will use it When Repetion , reviseons Answer The Exam
      _countOfQuestion =
          1; // set we will use it When Repetion , reviseons Answer The Exam

      _timeCounterMap.clear(); // reset the Map
      duration = const Duration(seconds: 0);
      timer!.cancel();
      // _counterTimerValue = "0";
      duration = const Duration(seconds: 0); //  reset the Counter Value
      // Timer Reset Here and Close it
      if (_isRevisionAnswers) {
        // when the Exam is Revision
        resetController();
        resetAllController();
        Get.find<ManageBottomNavigationViewModel>()
            .gotToHomePageManuallyWithoutClickOnIt();
        Get.until((route) => Get.currentRoute == Routes.bottomNavgation);
      } else {
        Get.toNamed(Routes.examStatisticsView);
      }
    }

    // if the Exam Entire
  }

  Future<void> senAnswerAfterFinish() async {
    DialogHelper.showLoading(
        message: 'يتم الان إرسال الإجابات ....',
        textDirection: TextDirection.rtl); // Show Diallog

    for (int currentIndex = 0;
        currentIndex < examData.data!.questions!.length;
        currentIndex++) {
      QuestionsModel currentQuestionModel =
          getCurrentQuestionModel(index: currentIndex);
      var resultOfTheCurrentQuestion =
          _mapAnswersOfExam['${currentQuestionModel.id}'];

      resultOfTheCurrentQuestion ??=
          ExamConstatnt.multipleChoice == currentQuestionModel.type ? [] : null;
      await answerQuestionService(
              questionId: currentQuestionModel.id!,
              timeSpent: _timeCounterMap['${currentQuestionModel.id}']!,
              givenAnswer: resultOfTheCurrentQuestion)
          .then((value) {
        if (!value!.success!) {
          debugPrint("/ " * 50);
          debugPrint(
              "Answer of Question Id ${currentQuestionModel.id}  Message : ${value.message}");
          debugPrint("/ " * 50);
        } else {
          debugPrint("/ " * 50);
          debugPrint(
              "Answer of Question Id ${currentQuestionModel.id}  Message : ${value.message}");
          debugPrint("/ " * 50);
          // Add to the Correct Answers
          addCorrectAnswers(
              mapEntry: MapEntry(
                  currentQuestionModel.id.toString(), value.data!.isCorrect!));
          print(_mapCorrectAnswers);
        }
      }).catchError((e) {
        debugPrint("/ " * 50);
        debugPrint(e.toString());
        debugPrint("/ " * 50);
      });
    }
    DialogHelper.hideLoading(); // Hide Diallog
  }

  void sendNote() {
    _isClickSendNote = true; // hint to know it Click SendNote Button
    debugPrint("-" * 50);
    debugPrint(
        "QutionId: ${getCurrentQuestionModel(index: _currentQuetionIndex).id} Send Note textOfNote ${noteController.text}");
    debugPrint("-" * 50);
  }

  void wrongQuetion({required bool isWrongQuestion}) {
    _isClickWrongAnswer =
        isWrongQuestion; // hint to know it Click wrongQuetion Button
    if (isWrongQuestion) {
      debugPrint("-" * 50);
      debugPrint(
          "QutionId: ${getCurrentQuestionModel(index: _currentQuetionIndex).id} Wrong Answer");
      debugPrint("-" * 50);
    }
  }

  ///////////////////////////////Life cylce/////////////////////////////////////

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

    print("Load Page");
  }

  //////////////////////////////////// Service ///////////////////////////////////
  ///
  ///

  String getsubjectName(int id) {
    return CacheSubjectService.instance
        .getSubjects()!
        .data!
        .firstWhere((element) => (element.id == id),
            orElse: () => DataSubjectModel(id: null))
        .name!;
  }

  Future<SendNoteOrWrongToQuestionModel> _sendNoteAndWrongQuestion(
      {required String notes,
      required bool needReview,
      required int idQuestion}) async {
    try {
      return await QuestionsRepositoryService().sendNoteOrWrongToQuestionById(
          id: idQuestion, needReview: needReview, notes: notes);
    } catch (e) {
      rethrow;
    }
  }

  void getSubjects({required List<DataSubjectModel> list}) {
    _isLoadChoicePage = false;
    _subjectList = list;
    _searchSubjectList = _subjectList; // to peformSearch
    _isLoadChoicePage = true;

    update(['updateSubject', 'loadingChoicePage']);
  }

  /*
  void _getSubjectsFromCache() async {
    _isLoadChoicePage = false;

    final receivePort = ReceivePort();
    final isolate =
        await Isolate.spawn(runSubjectInIsolated, receivePort.sendPort);

    StreamSubscription<dynamic> stream = receivePort.listen((data) {
      print('Data received from isolate: $data');
      receivePort.close(); // Close the receive port after receiving the data
      isolate.kill(priority: Isolate.immediate); // Terminate the isolate
    });
    stream.cancel();
    receivePort.close();
  }

  void runSubjectInIsolated(SendPort sendPort) {
    while (true) {
      if (Get.find<ManageSubjectCacheViewModel>().isLoadSubjectFromServer()) {
        _searchSubjectList =
            _subjectList; //_subjectList = CacheSubjectService.instance.getSubjects()!.data ?? []; to peformSearch
        _isLoadChoicePage = true;
        update(['updateSubject', 'loadingChoicePage']);
        break;
      }
    }
    sendPort.send(true);
  }

  */
  void addTime() {
    int secound = 1;
    int totalSecounds = secound + duration.inSeconds;
    duration = Duration(seconds: totalSecounds);
    update(['updateTimer']);
  }

  TimerModel getCurrentTimer() {
    // pad  Left to show the Two Digit if num less tahn 10 make 09 other wise 12
    // remainder to prevent number to become 65 restrate recyle again
    String secound =
        duration.inSeconds.remainder(60).toString().padLeft(2, '0');
    String minute = duration.inMinutes.remainder(60).toString().padLeft(2, '0');
    return TimerModel(minute: minute, secound: secound);
  }

  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) => addTime());
    update(['updateTimer']);
  }

  Future<void> startQuizService({required int examId}) async {
    ExamRepositoryService().startQuiz(examId: examId).then((value) async {
      if (timer != null) {
        if (timer!.isActive) timer!.cancel();
      }
      _timeCounterMap.clear();
      // _counterTimerValue = "0";

      duration = const Duration(seconds: 0);
      _mapAnswersOfExam.clear(); // review it
      _mapCorrectAnswers.clear();
      _countOfQuestion = 1;
      _currentQuetionIndex = 0;
      _startQuizModel = value;
      _totalOfQuestion = _startQuizModel!
          .data!.totalQuestions!; // intialize the Value of total Question

      if (_isExamAttempt) {
        // when make a RepetitionExam must Load All Question if the Exam is a AttemptExam
        await loadAllQuestionOfExamAttempts();
      }
      _isLoadExamViewPage = true; // to updateScreen
      if (!isNoQuestionExist) {
        updateTheCurrentExamType();
      }

      startTimer();

      update([
        'LoadExamViewPage',
        'updateLinearProgres'
      ]); //update  the Question Type
    }).catchError((e) => SnackBarHelper.instance
        .showMessage(message: e.toString(), milliseconds: 2000, erro: true));
  }

  Future<AnswerQuestionModel?> answerQuestionService(
      {required int questionId,
      required var givenAnswer,
      required int timeSpent}) async {
    AnswerQuestionModel? answerQuestionModel;
    try {
      answerQuestionModel = await ExamRepositoryService().answerQuestion(
          questionId: questionId,
          timeSpent: timeSpent,
          examAttemptId: _startQuizModel!.data!.id!, // from Start Exam Service
          givenAnswer: givenAnswer);
    } catch (e) {
      rethrow;
    }
    return answerQuestionModel;
  }

  void repetitionExam() {
    _isLoadExamViewPage = false;
    startQuizService(examId: _examData!.data!.id!);
    updateTheCurrentExamType(); //update  the Question Type
  }

  Future<void> loadAllQuestionOfExamAttempts() async {
    debugPrint("*" * 50);
    debugPrint("It is Exam Attempt");
    debugPrint("*" * 50);
    await ExamRepositoryService()
        .showExamAttempts(id: _startQuizModel!.data!.id!)
        .then((value) {
      _examData = ExamsModel(
          data: ExamModel(
              questions: value.data!.unsolvedQuestions,
              subjectId: value.data!.examAttempt!.subjectId,
              type: value.data!.examAttempt!.exam!.type,
              id: _startQuizModel!.data!.examId));
    }).catchError((e) => SnackBarHelper.instance
            .showMessage(message: e.toString(), erro: true));
  }

  void _randomExamService() {
    _isExamAttempt = false;
    _isLoadExamViewPage = false;
    _isAfterFinish = false; // must be false

    ExamRepositoryService()
        .storeExam(
            storeExamModel: StoreExamModel(
      type: ExamConstatnt.randomlyExam,
      typeAssessment: ExamConstatnt.typeAssessmenDirect,
      subjectId: _subjectSelectedInformation!.id,
      bookId: _bookSelected!.id!,
    ))
        .then((value) {
      _examData = value;

      if (_examData!.success!) {
        Get.toNamed(Routes.examView);
        startQuizService(examId: _examData!.data!.id!);
      } else {
        SnackBarHelper.instance.showMessage(
            // this mean your balance is equal zero
            message: _examData!.message!.toString(),
            milliseconds: 2000,
            isEnglish: false,
            showByGetx: true,
            erro: true);
      }
    }).catchError((e) => SnackBarHelper.instance.showMessage(
            message: e.toString(), milliseconds: 2000, erro: true));

    // _examData = ExamsModel(
    //     success: true,
    //     message: "Sucess",
    //     data: ExamModel(
    //         id: 18,
    //         name: "TEst",
    //         type: "choice",
    //         questionTypes: null,
    //         level: null,
    //         typeAssessment: "after_finish",
    //         description: null,
    //         photo: "https://quizzy.makank.online/images/exams/avatar.png",
    //         file: null,
    //         semester: "1",
    //         points: null,
    //         time: null,
    //         isActive: true,
    //         questions: <QuestionsModel>[
    //           QuestionsModel(
    //               id: 5,
    //               name: "معني كلمة سيارة",
    //               type:
    //                   "multiple_choice", //single_choice,multiple_choice,true_false,short_answer,long_answer,compare
    //               description: null,
    //               // photo:
    //               //     "https://quizzy.makank.online/images/answers/V3qeTQmmZKgkxtLYXsuvU1HfCcuGw4YX93meyAKn.jpg",
    //               semester: null,
    //               points: "15.00",
    //               time: "50",
    //               isActive: true,
    //               fileType: "video",
    //               file:
    //                   "https://quizzy.makank.online/images/questions/3pPXtCAfypiTcMRg24kNNtASz2cddUpXRUvjMh5t.mp4",
    //               // file: "https://streamable.com/bj6lsx", // Stream Link
    //               answers: <AnswersModel>[
    //                 AnswersModel(
    //                     id: 6,
    //                     title: "Car",
    //                     questionType: "multiple_choice",
    //                     answerTwoGapMatch: null,
    //                     answerViewFormat: "text",
    //                     answerOrder: 1,
    //                     answerSettings: null,
    //                     photo:
    //                         "https://quizzy.makank.online/images/answers/avatar.png",
    //                     isCorrect: true,
    //                     createdAt: "2023-10-31T18:26:47.000000Z",
    //                     updatedAt: "2023-10-31T18:28:53.000000Z"),
    //                 AnswersModel(
    //                     id: 3,
    //                     title: "Bmw",
    //                     questionType: "multiple_choice",
    //                     answerTwoGapMatch: null,
    //                     answerViewFormat: "text_image",
    //                     answerOrder: null,
    //                     answerSettings: null,
    //                     photo:
    //                         "https://quizzy.makank.online/images/answers/V3qeTQmmZKgkxtLYXsuvU1HfCcuGw4YX93meyAKn.jpg",
    //                     isCorrect: true,
    //                     createdAt: "2023-10-31T18:27:33.000000Z",
    //                     updatedAt: "2023-10-31T18:28:53.000000Z"),
    //                 AnswersModel(
    //                     id: 4,
    //                     title:
    //                         "Marcidis Marcidis Marcidis  Marcidis Marcidis Marcidis Marcidis Marcidis Marcidis Marcidis Marcidis Marcidis Marcidis Marcidis Marcidis Marcidis Marcidis ",
    //                     questionType: "multiple_choice",
    //                     answerTwoGapMatch: null,
    //                     answerViewFormat: "text",
    //                     answerOrder: null,
    //                     answerSettings: null,
    //                     photo:
    //                         "https://quizzy.makank.online/images/answers/avatar.png",
    //                     isCorrect: true,
    //                     createdAt: "2023-10-31T18:28:53.000000Z",
    //                     updatedAt: "2023-10-31T18:28:53.000000Z"),
    //                 AnswersModel(
    //                     id: 9,
    //                     title: null,
    //                     questionType: "multiple_choice",
    //                     answerTwoGapMatch: null,
    //                     answerViewFormat: "image",
    //                     answerOrder: null,
    //                     answerSettings: null,
    //                     photo:
    //                         "https://quizzy.makank.online/images/answers/V3qeTQmmZKgkxtLYXsuvU1HfCcuGw4YX93meyAKn.jpg",
    //                     isCorrect: false,
    //                     createdAt: "2023-10-31T18:28:53.000000Z",
    //                     updatedAt: "2023-10-31T18:28:53.000000Z"),
    //               ],
    //               createdAt: "2023-10-31T18:23:49.000000Z",
    //               updatedAt: "2023-10-31T18:23:49.000000Z"),
    //           QuestionsModel(
    //               id: 1,
    //               name: "ماهي عاصمة فلسطين ؟",
    //               type:
    //                   "single_choice", //single_choice,multiple_choice,true_false,short_answer,long_answer,compare
    //               description: null,
    //               photo: "",
    //               fileType: "video",
    //               file:
    //                   'https://quizzy.makank.online/images/questions/LwtqkyNwatPEDzH9iIBCuMubz3IhLB6KpNaad03U.mp4',
    //               semester: null,
    //               points: "15.00",
    //               time: "50",
    //               isActive: true,
    //               // reference: "ثانوية عامة , دليل  التقويم",
    //               answers: <AnswersModel>[
    //                 AnswersModel(
    //                     id: 1,
    //                     title:
    //                         " اجابة اجابةاجابةاجابةاجابةاجابةاجابةاجابةاجابةاجابةاجابةاجابةاجابةاجابةاجابةاجابةاجابةاجابة  اجابة اجابةاجابةاجابةاجابةاجابةاجابةاجابةاجابةاجابةاجابةاجابةاجابةاجابة  سؤال اجابة سؤال",
    //                     questionType: "single_choice",
    //                     answerTwoGapMatch: null,
    //                     answerViewFormat: "text",
    //                     answerOrder: 1,
    //                     answerSettings: null,
    //                     photo:
    //                         "https://quizzy.makank.online/images/answers/avatar.png",
    //                     isCorrect: false,
    //                     createdAt: "2023-10-31T18:26:47.000000Z",
    //                     updatedAt: "2023-10-31T18:28:53.000000Z"),
    //                 AnswersModel(
    //                     id: 3,
    //                     title: "القاهرة",
    //                     questionType: "single_choice",
    //                     answerTwoGapMatch: null,
    //                     answerViewFormat: "text_image",
    //                     answerOrder: null,
    //                     answerSettings: null,
    //                     photo:
    //                         "https://quizzy.makank.online/images/answers/V3qeTQmmZKgkxtLYXsuvU1HfCcuGw4YX93meyAKn.jpg",
    //                     isCorrect: false,
    //                     createdAt: "2023-10-31T18:27:33.000000Z",
    //                     updatedAt: "2023-10-31T18:28:53.000000Z"),
    //                 AnswersModel(
    //                     id: 4,
    //                     title: "دبي",
    //                     questionType: "single_choice",
    //                     answerTwoGapMatch: null,
    //                     answerViewFormat: "text",
    //                     answerOrder: null,
    //                     answerSettings: null,
    //                     photo:
    //                         "https://quizzy.makank.online/images/answers/avatar.png",
    //                     isCorrect: true,
    //                     createdAt: "2023-10-31T18:28:53.000000Z",
    //                     updatedAt: "2023-10-31T18:28:53.000000Z"),
    //               ],
    //               createdAt: "2023-10-31T18:23:49.000000Z",
    //               updatedAt: "2023-10-31T18:23:49.000000Z"),
    //           QuestionsModel(
    //               id: 5,
    //               name: "معني كلمة سيارة",
    //               type:
    //                   "multiple_choice", //single_choice,multiple_choice,true_false,short_answer,long_answer,compare
    //               description: null,
    //               // photo:
    //               //     "https://quizzy.makank.online/images/answers/V3qeTQmmZKgkxtLYXsuvU1HfCcuGw4YX93meyAKn.jpg",
    //               semester: null,
    //               points: "15.00",
    //               time: "50",
    //               isActive: true,
    //               fileType: "video",
    //               file:
    //                   "https://quizzy.makank.online/images/questions/3pPXtCAfypiTcMRg24kNNtASz2cddUpXRUvjMh5t.mp4",
    //               // file: "https://streamable.com/bj6lsx", // Stream Link
    //               answers: <AnswersModel>[
    //                 AnswersModel(
    //                     id: 6,
    //                     title: "Car",
    //                     questionType: "multiple_choice",
    //                     answerTwoGapMatch: null,
    //                     answerViewFormat: "text",
    //                     answerOrder: 1,
    //                     answerSettings: null,
    //                     photo:
    //                         "https://quizzy.makank.online/images/answers/avatar.png",
    //                     isCorrect: true,
    //                     createdAt: "2023-10-31T18:26:47.000000Z",
    //                     updatedAt: "2023-10-31T18:28:53.000000Z"),
    //                 AnswersModel(
    //                     id: 3,
    //                     title: "Bmw",
    //                     questionType: "multiple_choice",
    //                     answerTwoGapMatch: null,
    //                     answerViewFormat: "text_image",
    //                     answerOrder: null,
    //                     answerSettings: null,
    //                     photo:
    //                         "https://quizzy.makank.online/images/answers/V3qeTQmmZKgkxtLYXsuvU1HfCcuGw4YX93meyAKn.jpg",
    //                     isCorrect: true,
    //                     createdAt: "2023-10-31T18:27:33.000000Z",
    //                     updatedAt: "2023-10-31T18:28:53.000000Z"),
    //                 AnswersModel(
    //                     id: 4,
    //                     title:
    //                         "Marcidis Marcidis Marcidis  Marcidis Marcidis Marcidis Marcidis Marcidis Marcidis Marcidis Marcidis Marcidis Marcidis Marcidis Marcidis Marcidis Marcidis ",
    //                     questionType: "multiple_choice",
    //                     answerTwoGapMatch: null,
    //                     answerViewFormat: "text",
    //                     answerOrder: null,
    //                     answerSettings: null,
    //                     photo:
    //                         "https://quizzy.makank.online/images/answers/avatar.png",
    //                     isCorrect: true,
    //                     createdAt: "2023-10-31T18:28:53.000000Z",
    //                     updatedAt: "2023-10-31T18:28:53.000000Z"),
    //                 AnswersModel(
    //                     id: 9,
    //                     title: null,
    //                     questionType: "multiple_choice",
    //                     answerTwoGapMatch: null,
    //                     answerViewFormat: "image",
    //                     answerOrder: null,
    //                     answerSettings: null,
    //                     photo:
    //                         "https://quizzy.makank.online/images/answers/V3qeTQmmZKgkxtLYXsuvU1HfCcuGw4YX93meyAKn.jpg",
    //                     isCorrect: false,
    //                     createdAt: "2023-10-31T18:28:53.000000Z",
    //                     updatedAt: "2023-10-31T18:28:53.000000Z"),
    //               ],
    //               createdAt: "2023-10-31T18:23:49.000000Z",
    //               updatedAt: "2023-10-31T18:23:49.000000Z"),
    //           QuestionsModel(
    //               id: 1,
    //               name: "ماهي عاصمة فلسطين ؟",
    //               type:
    //                   "true_false", //single_choice,multiple_choice,true_false,short_answer,long_answer,compare
    //               description: null,
    //               photo: null,
    //               fileType: "audio",
    //               file:
    //                   "http://codeskulptor-demos.commondatastorage.googleapis.com/GalaxyInvaders/pause.wav",
    //               semester: null,
    //               points: "25.00",
    //               time: "60",
    //               isActive: true,
    //               answers: <AnswersModel>[
    //                 AnswersModel(
    //                     id: 3,
    //                     title: "هذه الإجابة صحيحة",
    //                     questionType: "true_false",
    //                     answerTwoGapMatch: null,
    //                     answerViewFormat: "text",
    //                     answerOrder: 1,
    //                     answerSettings: null,
    //                     photo:
    //                         "https://quizzy.makank.online/images/answers/avatar.png",
    //                     isCorrect: true,
    //                     createdAt: "2023-10-31T18:26:47.000000Z",
    //                     updatedAt: "2023-10-31T18:28:53.000000Z"),
    //                 AnswersModel(
    //                     id: 6,
    //                     title: "خطأ",
    //                     questionType: "true_false",
    //                     answerTwoGapMatch: null,
    //                     answerViewFormat: "text_image",
    //                     answerOrder: null,
    //                     answerSettings: null,
    //                     photo:
    //                         "https://quizzy.makank.online/images/answers/V3qeTQmmZKgkxtLYXsuvU1HfCcuGw4YX93meyAKn.jpg",
    //                     isCorrect: false,
    //                     createdAt: "2023-10-31T18:27:33.000000Z",
    //                     updatedAt: "2023-10-31T18:28:53.000000Z"),
    //               ],
    //               createdAt: "2023-10-31T18:23:49.000000Z",
    //               updatedAt: "2023-10-31T18:23:49.000000Z"),
    //           QuestionsModel(
    //               id: 1,
    //               name: "ماهي عاصمة فلسطين ؟",
    //               type:
    //                   "short_answer", //single_choice,multiple_choice,true_false,short_answer,long_answer,compare
    //               description: null,
    //               photo:
    //                   "https://quizzy.makank.online/images/answers/V3qeTQmmZKgkxtLYXsuvU1HfCcuGw4YX93meyAKn.jpg",
    //               semester: null,
    //               lessonId: 1,
    //               file: null,
    //               fileType: null,
    //               level: "متوسط",
    //               points: "200.00",
    //               time: "20",
    //               isActive: true,
    //               answers: <AnswersModel>[
    //                 AnswersModel(
    //                     id: 13,
    //                     title: "اكتب باختصار لايتجاوز السطرين",
    //                     questionType: "short_answer",
    //                     answerTwoGapMatch: null,
    //                     answerViewFormat: "text_image",
    //                     answerOrder: null,
    //                     answerSettings: null,
    //                     photo:
    //                         "https://quizzy.makank.online/images/answers/V3qeTQmmZKgkxtLYXsuvU1HfCcuGw4YX93meyAKn.jpg",
    //                     isCorrect: null,
    //                     createdAt: "2023-10-31T18:26:47.000000Z",
    //                     updatedAt: "2023-10-31T18:28:53.000000Z"),
    //               ],
    //               createdAt: "2023-10-31T18:23:49.000000Z",
    //               updatedAt: "2023-10-31T18:23:49.000000Z"),
    //           QuestionsModel(
    //               id: 5,
    //               name: "معني كلمة سيارة",
    //               type:
    //                   "multiple_choice", //single_choice,multiple_choice,true_false,short_answer,long_answer,compare
    //               description: null,
    //               photo:
    //                   "https://quizzy.makank.online/images/questions/avatar.png",
    //               semester: null,
    //               points: "15.00",
    //               time: "50",
    //               isActive: true,
    //               answers: <AnswersModel>[
    //                 AnswersModel(
    //                     id: 6,
    //                     title: "Car",
    //                     questionType: "multiple_choice",
    //                     answerTwoGapMatch: null,
    //                     answerViewFormat: "text",
    //                     answerOrder: 1,
    //                     answerSettings: null,
    //                     photo:
    //                         "https://quizzy.makank.online/images/answers/avatar.png",
    //                     isCorrect: true,
    //                     createdAt: "2023-10-31T18:26:47.000000Z",
    //                     updatedAt: "2023-10-31T18:28:53.000000Z"),
    //                 AnswersModel(
    //                     id: 3,
    //                     title: "Bmw",
    //                     questionType: "multiple_choice",
    //                     answerTwoGapMatch: null,
    //                     answerViewFormat: "text_image",
    //                     answerOrder: null,
    //                     answerSettings: null,
    //                     photo:
    //                         "https://quizzy.makank.online/images/answers/V3qeTQmmZKgkxtLYXsuvU1HfCcuGw4YX93meyAKn.jpg",
    //                     isCorrect: true,
    //                     createdAt: "2023-10-31T18:27:33.000000Z",
    //                     updatedAt: "2023-10-31T18:28:53.000000Z"),
    //                 AnswersModel(
    //                     id: 4,
    //                     title:
    //                         "Marcidis Marcidis Marcidis  Marcidis Marcidis Marcidis Marcidis Marcidis Marcidis Marcidis Marcidis Marcidis Marcidis Marcidis Marcidis Marcidis Marcidis ",
    //                     questionType: "multiple_choice",
    //                     answerTwoGapMatch: null,
    //                     answerViewFormat: "text",
    //                     answerOrder: null,
    //                     answerSettings: null,
    //                     photo:
    //                         "https://quizzy.makank.online/images/answers/avatar.png",
    //                     isCorrect: true,
    //                     createdAt: "2023-10-31T18:28:53.000000Z",
    //                     updatedAt: "2023-10-31T18:28:53.000000Z"),
    //                 AnswersModel(
    //                     id: 9,
    //                     title: null,
    //                     questionType: "multiple_choice",
    //                     answerTwoGapMatch: null,
    //                     answerViewFormat: "image",
    //                     answerOrder: null,
    //                     answerSettings: null,
    //                     photo:
    //                         "https://quizzy.makank.online/images/answers/V3qeTQmmZKgkxtLYXsuvU1HfCcuGw4YX93meyAKn.jpg",
    //                     isCorrect: false,
    //                     createdAt: "2023-10-31T18:28:53.000000Z",
    //                     updatedAt: "2023-10-31T18:28:53.000000Z"),
    //               ],
    //               createdAt: "2023-10-31T18:23:49.000000Z",
    //               updatedAt: "2023-10-31T18:23:49.000000Z"),
    //           QuestionsModel(
    //               id: 1,
    //               name: "ماهي عاصمة فلسطين ؟",
    //               type:
    //                   "true_false", //single_choice,multiple_choice,true_false,short_answer,long_answer,compare
    //               description: null,
    //               photo:
    //                   "https://quizzy.makank.online/images/questions/avatar.png",
    //               semester: null,
    //               points: "25.00",
    //               time: "60",
    //               isActive: true,
    //               answers: <AnswersModel>[
    //                 AnswersModel(
    //                     id: 3,
    //                     title: "صح",
    //                     questionType: "true_false",
    //                     answerTwoGapMatch: null,
    //                     answerViewFormat: "text",
    //                     answerOrder: 1,
    //                     answerSettings: null,
    //                     photo:
    //                         "https://quizzy.makank.online/images/answers/avatar.png",
    //                     isCorrect: true,
    //                     createdAt: "2023-10-31T18:26:47.000000Z",
    //                     updatedAt: "2023-10-31T18:28:53.000000Z"),
    //                 AnswersModel(
    //                     id: 6,
    //                     title: "خطأ",
    //                     questionType: "true_false",
    //                     answerTwoGapMatch: null,
    //                     answerViewFormat: "text_image",
    //                     answerOrder: null,
    //                     answerSettings: null,
    //                     photo:
    //                         "https://quizzy.makank.online/images/answers/V3qeTQmmZKgkxtLYXsuvU1HfCcuGw4YX93meyAKn.jpg",
    //                     isCorrect: false,
    //                     createdAt: "2023-10-31T18:27:33.000000Z",
    //                     updatedAt: "2023-10-31T18:28:53.000000Z"),
    //               ],
    //               createdAt: "2023-10-31T18:23:49.000000Z",
    //               updatedAt: "2023-10-31T18:23:49.000000Z"),
    //           QuestionsModel(
    //               id: 1,
    //               name: "ماهي عاصمة فلسطين ؟",
    //               type:
    //                   "single_choice", //single_choice,multiple_choice,true_false,short_answer,long_answer,compare
    //               description: null,
    //               photo: "",
    //               // fileType: "audio",
    //               file:
    //                   "https://quizzy.makank.online/images/questions/diqxxvjwu3t4hqDCWRp9kt9jOGbIBnySIpzItM1N.mp3",
    //               semester: null,
    //               points: "15.00",
    //               time: "50",
    //               isActive: true,
    //               // reference: "ثانوية عامة , دليل  التقويم",
    //               answers: <AnswersModel>[
    //                 AnswersModel(
    //                     id: 1,
    //                     title:
    //                         " اجابة اجابةاجابةاجابةاجابةاجابةاجابةاجابةاجابةاجابةاجابةاجابةاجابةاجابةاجابةاجابةاجابةاجابة  اجابة اجابةاجابةاجابةاجابةاجابةاجابةاجابةاجابةاجابةاجابةاجابةاجابةاجابة  سؤال اجابة سؤال",
    //                     questionType: "single_choice",
    //                     answerTwoGapMatch: null,
    //                     answerViewFormat: "text",
    //                     answerOrder: 1,
    //                     answerSettings: null,
    //                     photo: "",
    //                     isCorrect: false,
    //                     createdAt: "2023-10-31T18:26:47.000000Z",
    //                     updatedAt: "2023-10-31T18:28:53.000000Z"),
    //                 AnswersModel(
    //                     id: 3,
    //                     title: "القاهرة",
    //                     questionType: "single_choice",
    //                     answerTwoGapMatch: null,
    //                     answerViewFormat: "text_image",
    //                     answerOrder: null,
    //                     answerSettings: null,
    //                     photo:
    //                         "https://quizzy.makank.online/images/answers/V3qeTQmmZKgkxtLYXsuvU1HfCcuGw4YX93meyAKn.jpg",
    //                     isCorrect: false,
    //                     createdAt: "2023-10-31T18:27:33.000000Z",
    //                     updatedAt: "2023-10-31T18:28:53.000000Z"),
    //                 AnswersModel(
    //                     id: 4,
    //                     title: "دبي",
    //                     questionType: "single_choice",
    //                     answerTwoGapMatch: null,
    //                     answerViewFormat: "text",
    //                     answerOrder: null,
    //                     answerSettings: null,
    //                     photo:
    //                         "https://quizzy.makank.online/images/answers/avatar.png",
    //                     isCorrect: true,
    //                     createdAt: "2023-10-31T18:28:53.000000Z",
    //                     updatedAt: "2023-10-31T18:28:53.000000Z"),
    //               ],
    //               createdAt: "2023-10-31T18:23:49.000000Z",
    //               updatedAt: "2023-10-31T18:23:49.000000Z"),
    //           QuestionsModel(
    //               id: 1,
    //               name: "ماهي عاصمة فلسطين ؟",
    //               type:
    //                   "short_answer", //single_choice,multiple_choice,true_false,short_answer,long_answer,compare
    //               description: null,
    //               photo: null,
    //               semester: null,
    //               lessonId: 1,
    //               file: null,
    //               fileType: null,
    //               level: "متوسط",
    //               points: "200.00",
    //               time: "20",
    //               isActive: true,
    //               answers: <AnswersModel>[
    //                 AnswersModel(
    //                     id: 13,
    //                     title: "اكتب بما لايتجاوز السطرين",
    //                     questionType: "short_answer",
    //                     answerTwoGapMatch: "القدس",
    //                     answerViewFormat: "text",
    //                     answerOrder: null,
    //                     answerSettings: null,
    //                     photo:
    //                         "https://quizzy.makank.online/images/answers/avatar.png",
    //                     isCorrect: null,
    //                     createdAt: "2023-10-31T18:26:47.000000Z",
    //                     updatedAt: "2023-10-31T18:28:53.000000Z"),
    //               ],
    //               createdAt: "2023-10-31T18:23:49.000000Z",
    //               updatedAt: "2023-10-31T18:23:49.000000Z"),
    //           QuestionsModel(
    //               id: 1,
    //               name: "ماهي عاصمة فلسطين ؟",
    //               type:
    //                   "true_false", //single_choice,multiple_choice,true_false,short_answer,long_answer,compare
    //               description: null,
    //               photo:
    //                   "https://quizzy.makank.online/images/questions/avatar.png",
    //               semester: null,
    //               points: "25.00",
    //               time: "60",
    //               isActive: true,
    //               answers: <AnswersModel>[
    //                 AnswersModel(
    //                     id: 3,
    //                     title: "صح",
    //                     questionType: "true_false",
    //                     answerTwoGapMatch: null,
    //                     answerViewFormat: "text",
    //                     answerOrder: 1,
    //                     answerSettings: null,
    //                     photo:
    //                         "https://quizzy.makank.online/images/answers/avatar.png",
    //                     isCorrect: true,
    //                     createdAt: "2023-10-31T18:26:47.000000Z",
    //                     updatedAt: "2023-10-31T18:28:53.000000Z"),
    //                 AnswersModel(
    //                     id: 6,
    //                     title: "خطأ",
    //                     questionType: "true_false",
    //                     answerTwoGapMatch: null,
    //                     answerViewFormat: "text_image",
    //                     answerOrder: null,
    //                     answerSettings: null,
    //                     photo:
    //                         "https://quizzy.makank.online/images/answers/V3qeTQmmZKgkxtLYXsuvU1HfCcuGw4YX93meyAKn.jpg",
    //                     isCorrect: false,
    //                     createdAt: "2023-10-31T18:27:33.000000Z",
    //                     updatedAt: "2023-10-31T18:28:53.000000Z"),
    //               ],
    //               createdAt: "2023-10-31T18:23:49.000000Z",
    //               updatedAt: "2023-10-31T18:23:49.000000Z"),
    //         ]));
    // _isLoadExamViewPage = true;
    // updateTheCurrentExamType();
    // update(['LoadExamViewPage']);
  }

  void _aiExamService() {
    _isExamAttempt = false;
    _isLoadExamViewPage = false;
    _isAfterFinish = false; // must be false
    ExamRepositoryService()
        .storeExam(
            storeExamModel: StoreExamModel(
      type: ExamConstatnt.aiExam,
      typeAssessment: ExamConstatnt.typeAssessmenDirect,
      subjectId: _subjectSelectedInformation!.id,
      bookId: _bookSelected!.id!,
    ))
        .then((value) {
      _examData = value;
      // SnackBarHelper.instance
      //     .showMessage(message: _examData!.message!.toString());

      if (_examData!.success!) {
        Get.toNamed(Routes.examView);
        startQuizService(examId: _examData!.data!.id!);
      } else {
        SnackBarHelper.instance.showMessage(
            // this mean your balance is equal zero
            message: _examData!.message!.toString(),
            milliseconds: 2000,
            isEnglish: false,
            showByGetx: true,
            erro: true);
      }

      // updateTheCurrentExamType(); //update  the Question Type
    }).catchError((e) => SnackBarHelper.instance.showMessage(
            message: e.toString(), milliseconds: 2000, erro: true));
  }

  void _choiceExamService(
      {String? semesterId,
      int? unitId,
      int? leasonId,
      int? time,
      String? level,
      List<String>? questionTypes,
      String? typeAssessment}) {
    _isLoadExamViewPage = false;
    _isExamAttempt = false;
    ExamRepositoryService()
        .storeExam(
            storeExamModel: StoreExamModel(
                subjectId: _subjectSelectedInformation!.id,
                bookId: _bookSelected!.id!,
                type: ExamConstatnt.choiceExam,
                typeAssessment: typeAssessment,
                semester: semesterId,
                lessonId: leasonId,
                questionTypes: questionTypes,
                level: level,
                unitId: unitId,
                time: time))
        .then((value) {
      _examData = value;

      if (_examData!.success!) {
        Get.toNamed(Routes.examView);
        startQuizService(examId: _examData!.data!.id!);
      } else {
        SnackBarHelper.instance.showMessage(
            // this mean your balance is equal zero
            message: _examData!.message!.toString(),
            milliseconds: 2000,
            isEnglish: false,
            showByGetx: true,
            erro: true);
      }
    }).catchError((e, s) {
      debugPrint(s.toString());
      SnackBarHelper.instance
          .showMessage(message: e.toString(), milliseconds: 2000, erro: true);
    });
  }

  void _specialistExamService() {
    _isExamAttempt = false;
    _isLoadExamViewPage = false;
    _isAfterFinish = false; // must be false

    ExamRepositoryService()
        .getExams(
      type: ExamConstatnt.specialistExam,
      typeAssessment: ExamConstatnt.typeAssessmenDirect,
      subjectId: _subjectSelectedInformation!.id!,
    )
        .then((value) {
      _examData = value;
      Get.toNamed(Routes.examView);
      startQuizService(examId: _examData!.data!.id!);

      print("*" * 50);
      print(_examData!.data!.id!);
      print("*" * 50);
    }).catchError((e, s) {
      debugPrint(s.toString());
      SnackBarHelper.instance
          .showMessage(message: e.toString(), milliseconds: 2000, erro: true);
    });
  }

  ///////////////////////////////////////////////// Search Service ////////////////////////////////////////////////

  void searchSubject({required String value}) {
    if (value.isEmpty) {
      // if clear All and The Search become Empty
      _searchSubjectList = _subjectList;
    } else {
      _searchSubjectList = _subjectList
          .where((element) => element.name!.contains(value))
          .toList();
    }

    update(['updateSubject']);
  }

  void searchBook({required String value}) {
    if (value.isEmpty) {
      // if clear All and The Search become Empty
      _seachBookList = _bookList;
    } else {
      _seachBookList =
          _bookList.where((element) => element.name!.contains(value)).toList();
    }

    update(['updateBook']);
  }
}
