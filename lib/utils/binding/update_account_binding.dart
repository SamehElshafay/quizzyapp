// UpdateAccountBinding

import 'package:get/get.dart';
import 'package:quizzy_app/view_model/settings/update_account_view_model.dart';

class UpdateAccountBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => UpdateAccountViewModel());
  }
}
