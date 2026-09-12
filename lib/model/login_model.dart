import 'package:quizzy_app/utils/constant.dart';

class LoginModel {
  String? phone;
  String? email;
  String? password;
  SourceLoginType? type;
  LoginModel({this.email, this.password, this.phone, this.type});
}
