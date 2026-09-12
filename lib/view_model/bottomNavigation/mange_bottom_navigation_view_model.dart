import 'dart:io';

import 'package:curved_labeled_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quizzy_app/Service/local/cache_settings_service.dart';
import 'package:quizzy_app/Service/local/auth_route_service.dart';
import 'package:quizzy_app/utils/snack_bar_helper.dart';
import 'package:quizzy_app/utils/routes.dart';
import 'package:quizzy_app/utils/constant.dart';
import 'package:quizzy_app/view/screens/exam/manage_exam_view.dart';
import 'package:quizzy_app/view_model/exam/manage_exam_view_model.dart';

import '../../view/screens/bottomNavigation/account_view.dart';
import '../../view/screens/bottomNavigation/chat_view.dart';
import '../../view/screens/bottomNavigation/home_view.dart';

class ManageBottomNavigationViewModel extends GetxController {
  ManageExamViewModel manageExamViewModel = Get.find<ManageExamViewModel>();
  late List<Widget> myScreen;

  int _currentIndex = 0;

  int get currentIndex => _currentIndex;

  void changeIndex(int value) {
    if (Platform.isIOS && !isShowCopon()) {
      if (_currentIndex == 1 && value != 1) {
        print("Resest The MangeVieModel");
        manageExamViewModel.resetController();
      }
      _currentIndex = value;
      update();
      return;
    }
    if (_currentIndex == 2 && value != 2) {
      print("Resest The MangeVieModel");
      manageExamViewModel.resetController();
    }
    _currentIndex = value;
    update();
  }

  @override
  void onInit() {
    print("Intlize the Bottom Navigation");
    super.onInit();

    myScreen = [
      const HomeView(),
      if (Platform.isAndroid || isShowCopon()) const ChatView(),
      const ManageExamView(),
      const AccountView(),
    ];
  }

  @override
  void onReady() {
    // TODO: implement onReady
    print("On Read");
    super.onReady();
  }

  bool isShowCopon() {
    return CacheSettingsService.instance
                .getSettings()
                .settingsData!
                .showBalance ==
            "1"
        ? true
        : false;
  }

  void gotToExamPageManuallyWithoutClickOnIt() {
    manageExamViewModel.resetController();

    if (Platform.isIOS && !isShowCopon()) {
      _currentIndex = 1;
    } else {
      _currentIndex = 2;
    }

    final dynamic curvedNavigation = bottomNavgationGlobalKey
        .currentState; // bottomNavgationGlobalKey on the Curver
    curvedNavigation.setPage(_currentIndex);
    // use it to change the index without click on the Screen
    update();
  }

  void gotToHomePageManuallyWithoutClickOnIt() {
    _currentIndex = 0;
    final dynamic curvedNavigation = bottomNavgationGlobalKey
        .currentState; // bottomNavgationGlobalKey on the Curver
    curvedNavigation.setPage(0);
    // use it to change the index without click on the Screen
    update();
  }

  bool isCurrentHomePage() => (currentIndex == 0);
}
