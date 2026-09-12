import 'package:get/get.dart';
import 'package:quizzy_app/view_model/exam/exam_statistics_view_model.dart';

class ExamStatisticsBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ExamStatisticsViewModel());
  }
}
