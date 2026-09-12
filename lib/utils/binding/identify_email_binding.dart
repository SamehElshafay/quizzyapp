//SucessPasswordChanged
import 'package:get/get.dart';
import 'package:quizzy_app/view_model/auth/identify_email_view_model.dart';

class IdentifyEmailBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(IdentifyEmailViewModel()); // imediatly Loading api in onState
  }
}
