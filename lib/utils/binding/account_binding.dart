//    Get.lazyPut(() => AccountViewModel(), fenix: true);
import 'package:get/get.dart';
import 'package:quizzy_app/view_model/bottomNavigation/account_view_model.dart';

class AccountBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AccountViewModel(), fenix: true);
  }
}
