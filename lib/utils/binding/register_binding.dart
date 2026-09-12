import 'package:get/get.dart';
import 'package:quizzy_app/view_model/auth/register_view_model.dart';

class RegisterBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => RegisterViewModel());
  }
}
