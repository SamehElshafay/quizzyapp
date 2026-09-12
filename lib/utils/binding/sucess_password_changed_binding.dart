//SucessPasswordChanged
import 'package:get/get.dart';

import 'package:quizzy_app/view_model/auth/sucess_password_changed_view_model.dart';

class SucessPasswordChangedBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SucessPasswordChangedViewModel());
  }
}
