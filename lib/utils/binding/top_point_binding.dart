// TopPointBinding
import 'package:get/get.dart';
import 'package:quizzy_app/view_model/exam/top_point_view_model.dart';

class TopPointBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => TopPointViewModel());
  }
}
