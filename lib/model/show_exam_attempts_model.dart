import 'package:quizzy_app/model/exam_attempt_model.dart';
import 'package:quizzy_app/model/questions_model.dart';

class ShowExamAttemptsModel {
  bool? success;
  ShowExamAttemptsDataModel? data;
  String? message;

  ShowExamAttemptsModel({this.success, this.data, this.message});

  factory ShowExamAttemptsModel.fromJson(Map<String, dynamic> json) {
    return ShowExamAttemptsModel(
        success: json['success'],
        message: json['message'],
        data: json['data'] != null
            ? ShowExamAttemptsDataModel.fromJson(json['data'])
            : null);
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'success': success,
      'data': data != null ? data!.toJson() : {}
    };
  }
}

class ShowExamAttemptsDataModel {
  ExamAttemptModel? examAttempt;
  List<QuestionsModel>? unsolvedQuestions;

  ShowExamAttemptsDataModel({this.examAttempt, this.unsolvedQuestions});

  factory ShowExamAttemptsDataModel.fromJson(Map<String, dynamic> json) {
    List<QuestionsModel> list = [];
    if (json['unsolved_questions'] != null) {
      json['unsolved_questions'].forEach((v) {
        list.add(QuestionsModel.fromJson(v));
      });
    }

    return ShowExamAttemptsDataModel(
        examAttempt: json['exam_attempt'] != null
            ? ExamAttemptModel.fromJson(json['exam_attempt'])
            : null,
        unsolvedQuestions: list);
  }

  Map<String, dynamic> toJson() {
    return {
      'unsolved_questions': unsolvedQuestions != null
          ? unsolvedQuestions!.map((v) => v.toJson()).toList()
          : [],
      'exam_attempt': examAttempt != null ? examAttempt!.toJson() : {}
    };
  }
}
