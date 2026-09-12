import 'package:get/get.dart';

import 'package:quizzy_app/utils/routes.dart';

class SucessPasswordChangedViewModel extends GetxController {
  void backLoginPage() {
    // Get.offAllNamed(Routes.loginView);

    Get.offNamedUntil(Routes.loginView, ((route) => false));
  }
}
