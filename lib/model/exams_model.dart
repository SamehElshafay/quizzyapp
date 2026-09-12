import 'package:quizzy_app/model/exam_model.dart';

class ExamsModel {
  bool? success;
  ExamModel? data;
  String? message;

  ExamsModel({this.success, this.data, this.message});

  factory ExamsModel.fromJson(Map<String, dynamic> json) {
    return ExamsModel(
        message: json['message'],
        success: json['success'],
        data: json['data'] != null ? ExamModel.fromJson(json['data']) : null);
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'message': message,
      'data': data != null ? data!.toJson() : {}
    };
  }
}
