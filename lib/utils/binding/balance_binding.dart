import 'package:get/get.dart';
import 'package:quizzy_app/view_model/settings/balance_view_model.dart';

class BalanceBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => BalanceViewModel());
  }
}
