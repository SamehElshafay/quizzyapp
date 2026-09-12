import 'package:dio/dio.dart';
import 'package:quizzy_app/Service/Networking/dio_exception.dart';
import 'package:quizzy_app/Service/Networking/dio_helper.dart';
import 'package:quizzy_app/Service/api/repository/forget_password_repository.dart';
import 'package:quizzy_app/model/forget_password_model.dart';
import 'package:quizzy_app/model/genral_response_mode.dart';
import 'package:quizzy_app/utils/end_point.dart';

class ForgetPasswordRepositoryService implements ForgetPasswordRepository {
  @override
  Future<ForgetPasswordModel> forgetPassword({required String email}) async {
    try {
      var response = await DioHelper()
          .post(EndPoint.forgetPassword, data: {'email': email});
      return ForgetPasswordModel.fromJson(response);
    } on DioException catch (e) {
      throw DioExceptionHelper.instance.getExceptionMessage(dioException: e);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<GeneralResponseModel> resetpassword(
      {required String email,
      required String code,
      required String password,
      required String passwordConfirmation}) async {
    try {
      var response = await DioHelper().post(EndPoint.resetPassword, data: {
        'email': email,
        'password': password,
        'password_confirmation': passwordConfirmation,
        'code': code
      });
      return GeneralResponseModel.fromJson(response);
    } on DioException catch (e) {
      throw DioExceptionHelper.instance.getExceptionMessage(dioException: e);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<GeneralResponseModel> verifyCode(
      {required String email, required String code}) async {
    try {
      var response = await DioHelper()
          .post(EndPoint.verifyCode, data: {'email': email, 'code': code});
      return GeneralResponseModel.fromJson(response);
    } on DioException catch (e) {
      throw DioExceptionHelper.instance.getExceptionMessage(dioException: e);
    } catch (e) {
      rethrow;
    }
  }
}
