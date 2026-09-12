import 'package:quizzy_app/model/questions_model.dart';

class SendNoteOrWrongToQuestionModel {
  bool? success;
  QuestionsModel? data;
  String? message;

  SendNoteOrWrongToQuestionModel({this.success, this.data, this.message});

  factory SendNoteOrWrongToQuestionModel.fromJson(Map<String, dynamic> json) {
    return SendNoteOrWrongToQuestionModel(
        message: json['message'],
        success: json['success'],
        data: json['data'] != null
            ? QuestionsModel.fromJson(json['data'])
            : null);
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'message': message,
      'data': data != null ? data!.toJson() : null
    };
  }
}
