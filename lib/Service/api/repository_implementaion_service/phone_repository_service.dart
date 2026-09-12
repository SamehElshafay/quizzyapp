import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:quizzy_app/Service/Networking/dio_exception.dart';
import 'package:quizzy_app/Service/Networking/dio_helper.dart';

import 'package:quizzy_app/Service/api/repository/phone_repository.dart';
import 'package:quizzy_app/model/genral_response_mode.dart';
import 'package:quizzy_app/model/resend_verify_email_model.dart';
import 'package:quizzy_app/utils/end_point.dart';

class PhoneRepositoryService implements PhoneRepository {
  @override
  Future<ReSendVeifyModel> reSendVerifyPhone({
    required String phone,
  }) async {
    try {
      var response = await DioHelper()
          .post(EndPoint.reSendVeifyPhone, data: {'phone': phone});
      return ReSendVeifyModel.fromJson(response);
    } on DioException catch (e, s) {
      debugPrint(s.toString());
      throw DioExceptionHelper.instance.getExceptionMessage(dioException: e);
    } catch (e, s) {
      debugPrint(s.toString());
      rethrow;
    }
  }

  @override
  Future<GeneralResponseModel> verifyPhoneCode(
      {required String phone, required String code}) async {
    try {
      var response = await DioHelper()
          .post(EndPoint.veifyPhoneCode, data: {'phone': phone, 'code': code});
      return GeneralResponseModel.fromJson(response);
    } on DioException catch (e, s) {
      debugPrint(s.toString());
      throw DioExceptionHelper.instance.getExceptionMessage(dioException: e);
    } catch (e, s) {
      debugPrint(s.toString());
      rethrow;
    }
  }
}
