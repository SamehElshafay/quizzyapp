import 'package:quizzy_app/model/user_model.dart';

class Data {
  String? accessToken;
  String? tokenType;
  int? expiresIn;
  User? user;

  Data({this.accessToken, this.tokenType, this.expiresIn, this.user});

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
        accessToken: json['access_token'],
        expiresIn: json['expires_in'],
        tokenType: json['token_type'],
        user: json['user'] != null ? User.fromJson(json['user']) : null);
  }

  Map<String, dynamic> toJson() {
    return {
      'access_token': accessToken,
      'token_type': tokenType,
      'expires_in': tokenType,
      'user': user != null ? user!.toJson() : null,
    };
  }
}
