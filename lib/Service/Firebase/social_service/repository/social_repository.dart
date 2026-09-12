import 'package:quizzy_app/model/social_service_response_model.dart';

abstract class SocialRepository {
  Future<SocialServiceResponseModel> login();
  Future<bool> logout();
}
