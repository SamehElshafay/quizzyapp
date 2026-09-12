import 'package:get/get.dart';
import 'package:quizzy_app/view_model/settings/contact_us_view_model.dart';

class ContactUsBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ContactUsViewModel());
  }
}
