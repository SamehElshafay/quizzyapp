import 'package:get/get.dart';
import 'package:quizzy_app/view_model/auth/verify_phone_view_model.dart';

class VerifyPhoneBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(VerifyPhoneViewModel()); // imediatly Loading api in onState
  }
}
