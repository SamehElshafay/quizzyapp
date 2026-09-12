import 'data_model.dart';

class AuthModel {
  bool? success;
  Data? data;
  String? message;

  AuthModel({this.success, this.data, this.message});

  factory AuthModel.fromJson(Map<String, dynamic> json) {
    return AuthModel(
        data: json['data'] != null ? Data.fromJson(json['data']) : null,
        message: json['message'],
        success: json['success']);
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'success': success,
      'data': data != null ? data!.toJson() : {}
    };
  }
}
