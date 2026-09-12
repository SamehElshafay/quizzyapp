import 'package:quizzy_app/model/forget_password_model.dart';
import 'package:quizzy_app/model/genral_response_mode.dart';

abstract class ForgetPasswordRepository {
  Future<ForgetPasswordModel> forgetPassword({required String email});
  Future<GeneralResponseModel> verifyCode(
      {required String email, required String code});
  // reset password
  Future<GeneralResponseModel> resetpassword(
      {required String email,
      required String code,
      required String password,
      required String passwordConfirmation});
}
