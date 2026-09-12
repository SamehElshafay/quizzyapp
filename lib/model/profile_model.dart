import 'package:quizzy_app/model/user_model.dart';

class ProfileModel {
  bool? success;
  User? data;
  String? message;

  ProfileModel({this.success, this.data, this.message});

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
        success: json['success'],
        message: json['message'],
        data: json['data'] != null ? User.fromJson(json['data']) : null);
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'message': message,
      'data': data != null ? data!.toJson() : {}
    };
  }
}
