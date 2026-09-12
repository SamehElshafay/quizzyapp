//SucessPasswordChanged
import 'package:get/get.dart';
import 'package:quizzy_app/view_model/auth/verify_email_view_model.dart';

class VerifyEmailBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(VerifyEmailViewModel()); // imediatly Loading api in onState
  }
}
