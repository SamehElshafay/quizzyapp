import 'package:get/get.dart';
import 'package:quizzy_app/view_model/settings/cobon_location_view_model.dart';

class CobonLocctionBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CobonLocationViewModel());
  }
}
