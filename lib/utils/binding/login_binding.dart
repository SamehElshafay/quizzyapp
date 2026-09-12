import 'package:get/get.dart';
import 'package:quizzy_app/view_model/auth/login_view_model.dart';

class LoginBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LoginViewModel());
  }
}
