import 'package:get/get.dart';

import 'package:quizzy_app/view_model/settings/update_change_password_view_model.dart';

class UpdateChangePasswordBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => UpdateChangePasswordViewModel());
  }
}
