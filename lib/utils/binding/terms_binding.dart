import 'package:get/get.dart';
import 'package:quizzy_app/view_model/settings/terms_view_model.dart';

class TermsBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => TermsViewModel());
  }
}
