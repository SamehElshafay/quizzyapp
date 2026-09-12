import 'package:quizzy_app/model/academic_year_model.dart';

class AcdemicYearResponseModel {
  bool? success;
  AcademicYearModel? academicYearModel;
  String? message;

  AcdemicYearResponseModel(
      {this.success, this.academicYearModel, this.message});

  factory AcdemicYearResponseModel.fromJson(Map<String, dynamic> json) {
    return AcdemicYearResponseModel(
      success: json['success'],
      message: json['message'],
      academicYearModel: json['data'] != null
          ? AcademicYearModel.fromJson(json['data'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'message': message,
      'data': academicYearModel != null ? academicYearModel!.toJson() : {}
    };
  }
}
