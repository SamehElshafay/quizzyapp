import 'package:hive_flutter/hive_flutter.dart';
import 'package:quizzy_app/model/data_subject_model.dart';

part 'subjects_model.g.dart';

@HiveType(typeId: 3)
class SubjectsModel {
  @HiveField(0)
  bool? success;
  @HiveField(1)
  List<DataSubjectModel>? data;
  @HiveField(2)
  String? message;

  SubjectsModel({this.success, this.data, this.message});

  factory SubjectsModel.fromJson(Map<String, dynamic> json) {
    List<DataSubjectModel> data = [];
    if (json['data'] != null) {
      json['data'].forEach((v) {
        data.add(DataSubjectModel.fromJson(v));
      });
    }

    return SubjectsModel(
        message: json['message'], success: json['success'], data: data);
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'message': message,
      'data': data != null ? data!.map((v) => v.toJson()).toList() : []
    };
  }
}
