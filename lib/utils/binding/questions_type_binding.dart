import 'package:get/get.dart';
import 'package:quizzy_app/view_model/exam/exam_type/compare_choice_exam_view_model.dart';
import 'package:quizzy_app/view_model/exam/exam_type/multiple_choice_exam_view_model.dart';
import 'package:quizzy_app/view_model/exam/exam_type/single_choice_exam_view_model.dart';
import 'package:quizzy_app/view_model/exam/exam_type/true_false_exam_view_model.dart';

import 'dart:math' as Math;

class QuestionsTypeBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      () => CompareChoiceExamViewModel(),
      fenix: true,
      // tag: DateTime.now().microsecondsSinceEpoch.toString(), // unique Tag
    );
    Get.lazyPut(
      () => MultipleChoiceExamViewModel(),
      fenix: true,
      // tag: DateTime.now().microsecondsSinceEpoch.toString(),
    );
    // Get.lazyPut(
    //   () => ShortLongAnswerViewModel(),
    //   fenix: true,
    //   // tag: DateTime.now().microsecondsSinceEpoch.toString(),
    // );
    Get.lazyPut(
      () => SingleChoiceExamViewModel(),
      fenix: true,
      // tag: DateTime.now().microsecondsSinceEpoch.toString(),
    );
    Get.lazyPut(
      () => TrueFalseExamViewModel(),
      fenix: true,
      // tag: DateTime.now().microsecondsSinceEpoch.toString(),
    );
  }
}
