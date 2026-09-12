// PrivacyPolicyBinding

import 'package:get/get.dart';
import 'package:quizzy_app/view_model/settings/privacy_policy_view_model.dart';

class PrivacyPolicyBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => PrivacyPolicyViewModel());
  }
}
