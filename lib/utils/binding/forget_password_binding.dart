import 'package:get/get.dart';
import 'package:quizzy_app/view_model/auth/forget_password_view_model.dart';

class ForgetPasswordBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ForgetPasswordViewModel());
  }
}
