import 'package:get/get.dart';
import 'package:quizzy_app/view_model/settings/notification_view_model.dart';

class NotificationBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => NotificationViewModel());
  }
}
