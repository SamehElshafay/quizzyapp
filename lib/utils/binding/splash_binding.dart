import 'package:get/get.dart';
import 'package:quizzy_app/view_model/splash_view_model.dart';

class SplashBinding implements Bindings {
  // SplashBinding() {
  //   Get.put(SplashViewModel());
  // }
  @override
  void dependencies() {
    Get.lazyPut(() => SplashViewModel());
  }
}
