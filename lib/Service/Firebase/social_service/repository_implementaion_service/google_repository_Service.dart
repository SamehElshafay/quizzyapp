import 'package:google_sign_in/google_sign_in.dart';
import 'package:quizzy_app/Service/Firebase/social_service/repository/social_repository.dart';
import 'package:quizzy_app/model/social_service_response_model.dart';

class GoogleRepositoryService implements SocialRepository {
  @override
  Future<SocialServiceResponseModel> login() async {
    try {
      // Trigger the authentication flow

      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      // Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      return SocialServiceResponseModel(
          status: true,
          providerId: googleUser!.id,
          providertype: 'google',
          message: 'تم تسجيل الدخول بنجاح');
    } catch (e) {
      return SocialServiceResponseModel(
          status: false, message: 'حدث خطأ أثناء تسجيل الدخول');
    }
  }

  @override
  Future<bool> logout() async {
    try {
      await GoogleSignIn()
          .disconnect(); // Disconnects the current user from the app
      // await GoogleSignIn().signOut();
      return true;
    } catch (e) {
      return false;
    }
  }
}
