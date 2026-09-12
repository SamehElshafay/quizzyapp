import 'package:quizzy_app/model/unit_data_model.dart';

class UnitsModel {
  bool? success;
  List<UnitDataModel>? data;
  String? message;

  UnitsModel({this.success, this.data, this.message});

  factory UnitsModel.fromJson(Map<String, dynamic> json) {
    List<UnitDataModel> listUnitDataModel = [];
    if (json['data'] != null) {
      json['data'].forEach((v) {
        listUnitDataModel.add(UnitDataModel.fromJson(v));
      });
    }

    return UnitsModel(
        message: json['message'],
        success: json['success'],
        data: listUnitDataModel);
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'message': message,
      'data': data != null ? data!.map((v) => v.toJson()).toList() : []
    };
  }
}
