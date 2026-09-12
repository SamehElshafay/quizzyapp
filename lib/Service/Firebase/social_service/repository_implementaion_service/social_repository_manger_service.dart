import 'package:quizzy_app/Service/Firebase/social_service/repository/social_repository.dart';
import 'package:quizzy_app/model/social_service_response_model.dart';

// Apply polymorphism
class SocialRepositoryMangerService {
  Future<SocialServiceResponseModel> login(
      SocialRepository socialRepository) async {
    return await socialRepository.login();
  }

  Future<bool> logout(SocialRepository socialRepository) async {
    return await socialRepository.logout();
  }
}
