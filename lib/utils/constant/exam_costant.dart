import 'package:flutter/material.dart';

class ExamConstatnt {
  const ExamConstatnt._();
  static const String singleChoice = "single_choice";
  static const String multipleChoice = "multiple_choice";
  static const String trueFalse = "true_false";
  static const String shortAnswer = "short_answer";
  static const String longAnswer = "long_answer";
  static const String compare = "compare";
  static const String matching = "matching";
  //matching
  static const String typeAssessmentAfterFinish = "after_finish";
  static const String typeAssessmenDirect = "direct";
  static const String choiceExam = "choice";
  static const String randomlyExam = "randomly";
  static const String aiExam = "ai";
// medium ,  easy
  static const String difficultLevel = 'difficult';
  static const String easyLevel = 'easy';
  static const String mediumLevel = 'medium';
  static const String answerViewFormatIamge = "image";
  static const String answerViewFormatText = "text"; // text_image
  static const String answerViewFormatTextImage = "text_image";
  static const String isDeafultImage =
      "https://quizzy.makank.online/images/books/avatar.png";
  // choice_specialist

  static const String specialistExam = "choice_specialist";

  static const String video = "video";

/////////////////// Audio Video Section ///////////////////
  static BuildContext? _currentContextQuestion;
  static BuildContext? _currentContextVideo;
  static BuildContext? _currentContextAudio;
  static bool? _isPageHasVideo = false;

  static void setNewQuestionContext(BuildContext context) {
    _currentContextQuestion = context;
  }

  static void setNewVideoContext(BuildContext context) {
    _currentContextVideo = context;
  }

  static void setNewAudioContext(BuildContext context) {
    _currentContextAudio = context;
  }

  static void setPageHasVideo({required bool isPageHasVideo}) {
    _isPageHasVideo = isPageHasVideo;
  }

  static BuildContext get currentContextQuestion => _currentContextQuestion!;
  static BuildContext get currentContextAudio => _currentContextAudio!;
  static BuildContext get currentContextVideo => _currentContextVideo!;
  static bool get isPageHasVideo => _isPageHasVideo!;
}
