import 'package:quizzy_app/model/unit_data_model.dart';

class UnitModel {
  bool? success;
  UnitDataModel? data;
  String? message;

  UnitModel({this.success, this.data, this.message});

  factory UnitModel.fromJson(Map<String, dynamic> json) {
    return UnitModel(
        success: json['success'],
        message: json['message'],
        data:
            json['data'] != null ? UnitDataModel.fromJson(json['data']) : null);
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'message': message,
      // ignore: prefer_null_aware_operators
      'data': data != null ? data!.toJson() : null
    };
  }
}
