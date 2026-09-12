import 'package:quizzy_app/model/academic_year_model.dart';

class AcdemicYearsModel {
  bool? success;
  List<AcademicYearModel>? data;
  String? message;

  AcdemicYearsModel({this.success, this.data, this.message});

  factory AcdemicYearsModel.fromJson(Map<String, dynamic> json) {
    List<AcademicYearModel> list = [];

    if (json['data'] != null) {
      json['data'].forEach((v) {
        list.add(AcademicYearModel.fromJson(v));
      });
    }

    return AcdemicYearsModel(
      message: json['message'],
      success: json['success'],
      data: list,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'success': success,
      'data': data != null ? data!.map((v) => v.toJson()).toList() : [],
    };
  }
}
