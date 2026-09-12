import 'package:quizzy_app/model/genral_response_mode.dart';
import 'package:quizzy_app/model/resend_verify_email_model.dart';

abstract class PhoneRepository {
  Future<GeneralResponseModel> verifyPhoneCode(
      {required String phone, required String code});

  Future<ReSendVeifyModel> reSendVerifyPhone({required String phone});
}
