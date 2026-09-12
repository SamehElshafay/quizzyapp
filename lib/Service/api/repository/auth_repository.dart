import 'package:quizzy_app/model/auth_model.dart';
import 'package:quizzy_app/model/genral_response_mode.dart';

import '../../../model/login_model.dart';
import '../../../model/register_model.dart';
import '../../../model/social_login_model.dart';

abstract class AuthRepository {
  Future<AuthModel> login({required LoginModel loginModel});
  Future<AuthModel> socialLogin({required SocialLoginModel socialLoginModel});
  Future<AuthModel> guestLogin();
  Future<GeneralResponseModel> checkUser(
      {required String
          value}); // vaule can be email / phone / proveiderID  , retrun(message , sucess)

  Future<GeneralResponseModel>
      logout(); // need Authorization , retrun(message , sucess)
  Future<AuthModel> register({required RegisterModel registerModel});
//   updateProfile();
//   getProfile();
  Future<GeneralResponseModel> deleteAccount();
  Future<GeneralResponseModel> updateAcademicYear(
      {required int academicYearId});
}
