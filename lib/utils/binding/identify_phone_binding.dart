import 'package:get/get.dart';
import 'package:quizzy_app/view_model/auth/identify_phone_view_model.dart';

class IdentifyPhoneBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(IdentifyPhoneViewModel()); // imediatly Loading api in onState
  }
}
