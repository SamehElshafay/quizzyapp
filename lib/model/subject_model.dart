import 'package:quizzy_app/model/data_subject_model.dart';

class SubjectModel {
  bool? success;
  DataSubjectModel? data;
  String? message;

  SubjectModel({this.success, this.data, this.message});

  factory SubjectModel.fromJson(Map<String, dynamic> json) {
    return SubjectModel(
        message: json['message'],
        success: json['success'],
        data: json['data'] != null
            ? DataSubjectModel.fromJson(json['data'])
            : null);
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'message': message,
      'data': data != null ? data!.toJson() : {}
    };
  }
}
