import 'package:quizzy_app/model/genral_response_mode.dart';
import 'package:quizzy_app/model/resend_verify_email_model.dart';

abstract class EmailRepository {
  Future<GeneralResponseModel> verifyEmailCode(
      {required String email, required String code});

  Future<ReSendVeifyModel> reSendVerifyEmail({required String email});
}
