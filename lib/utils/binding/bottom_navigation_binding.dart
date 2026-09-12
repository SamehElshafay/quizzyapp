import 'package:get/get.dart';
import 'package:quizzy_app/view_model/bottomNavigation/account_view_model.dart';
import 'package:quizzy_app/view_model/bottomNavigation/chat_view_model.dart';
import 'package:quizzy_app/view_model/bottomNavigation/home_view_model.dart';
import 'package:quizzy_app/view_model/exam/filter_questions_view_model.dart';
import 'package:quizzy_app/view_model/settings/settings_view_model.dart';
import 'package:quizzy_app/view_model/utils/multiselectDropdown/multiselect_dropdown_view_model.dart';

import '../../view_model/bottomNavigation/mange_bottom_navigation_view_model.dart';
import '../../view_model/exam/manage_exam_view_model.dart';

class BottomNavigationBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ManageBottomNavigationViewModel());

    Get.put(HomeViewModel());
    Get.put(ChatViewModel());
    Get.put(ManageExamViewModel());
    Get.put(SettingsViewModel());
    // Get.lazyPut(() => AccountViewModel(), fenix: true);
    Get.lazyPut(() => FilterQuestionsViewModel(), fenix: true);
    Get.lazyPut(() => MultiSelectDropDownViewModel(), fenix: true);
    Get.lazyPut(() => AccountViewModel(), fenix: true);
  }
}
