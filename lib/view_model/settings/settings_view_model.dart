import 'dart:math';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quizzy_app/Service/Firebase/social_service/repository/social_repository.dart';
import 'package:quizzy_app/Service/Firebase/social_service/repository_implementaion_service/apple_repository_service.dart';
import 'package:quizzy_app/Service/Firebase/social_service/repository_implementaion_service/facebook_repository_service.dart';
import 'package:quizzy_app/Service/Firebase/social_service/repository_implementaion_service/google_repository_Service.dart';
import 'package:quizzy_app/Service/Firebase/social_service/repository_implementaion_service/social_repository_manger_service.dart';
import 'package:quizzy_app/Service/api/repository_implementaion_service/auth_repository_service.dart';
import 'package:quizzy_app/Service/local/auth_route_service.dart';
import 'package:quizzy_app/Service/local/auth_token_service.dart';
import 'package:quizzy_app/Service/local/cache_notification_service.dart';
import 'package:quizzy_app/Service/local/cache_settings_service.dart';
import 'package:quizzy_app/Service/local/cache_subject_service.dart';
import 'package:quizzy_app/Service/local/cache_theme_service.dart';
import 'package:quizzy_app/Service/local/cache_user_service.dart';
import 'package:quizzy_app/Service/nottification/push_notification_service.dart';
import 'package:quizzy_app/model/settings_model.dart';
import 'package:quizzy_app/model/user_model.dart';
import 'package:quizzy_app/utils/constant.dart';
import 'package:quizzy_app/utils/dialog_helper.dart';
import 'package:quizzy_app/utils/dialogs/custom_dialog_balance_widget.dart';
import 'package:quizzy_app/utils/dialogs/custom_dialog_invite_friend.dart';
import 'package:quizzy_app/utils/general_utils.dart';
import 'package:quizzy_app/utils/routes.dart';
import 'package:quizzy_app/utils/snack_bar_helper.dart';
import 'package:quizzy_app/view_model/bottomNavigation/home_view_model.dart';
import 'package:quizzy_app/view_model/utils/theme/theme_view_model.dart';

class SettingsViewModel extends GetxController {
  late User _user;
  late bool _isDarkMode;
  late bool _isNotificationEnabled;
  late SettingsModel _settingsModel;
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getUserFromCahce();
    getCurrentNotificationFromCache();
    getCurrentTheme();
    _getSettingsModelFromCache();
    print("Init Seetings View Model : $showBalance");
  }

//////////////////////////////////////////////// Getter ////////////////////////////////////////////
  String get name => _user.name?.trim() ?? "";
  bool get showBalance =>
      _settingsModel.settingsData!.showBalance == "1" ? true : false;

  bool get showDeleteAccount =>
      _settingsModel.settingsData!.showDeleteAccount == "1" ? true : false;
  String get emailOrPhone =>
      _user.phone?.trim() ??
      _user.email?.trim() ??
      "Sign in with ${_user.providerType}";
  String? get photo => (_user.photo != null &&
          _user.photo !=
              "https://quizzy.quizzy.site/images/students/avatar.png")
      ? _user.photo
      : null;
  bool get isDarkMode => _isDarkMode;
  bool get isNotificationEnabled => _isNotificationEnabled;

  bool get isSocialLogin =>
      (_user.providerType != null && _user.providerId != null) ? true : false;

  bool isUserHasPhoto() => (_user.photo != null &&
      _user.photo != "https://quizzy.quizzy.site/images/students/avatar.png");

////////////////////////////////////////////// update Widget /////////////////////////////////////////

  Future<void> updateNotification() async {
    _isNotificationEnabled = !_isNotificationEnabled;
    PushNotificationService notificationService = PushNotificationService();
    update(['updateNotification']);
    if (!_isNotificationEnabled) {
      notificationService.disableNotification();
    } else {
      notificationService.activeNotification();
    }

    await updateNotificationCache(_isNotificationEnabled);
  }

  Future<void> updatDarkMode() async {
    _isDarkMode = !_isDarkMode;
    await updateCurrentThemeCache(_isDarkMode);
    update(['updatDarkMode']);
    // update(['updatAllTheme']); updatDarkMode
    Get.find<ThemeViewMode>().updateTheme();
  }

/////////////////////////////////////////////// Helper Method //////////////////////////////////////////
  SocialRepository _getObjectTypeOfSocaiLogin(
      {required SocialMediaType socialMediaType}) {
    if (socialMediaType == SocialMediaType.apple) {
      return AppleRepositoryService();
    } else if (socialMediaType == SocialMediaType.google) {
      return GoogleRepositoryService();
    } else {
      //   return FacebookRepositoryService();
      // remove a Google and add Facebook
      return FacebookRepositoryService();
    }
  }
///////////////////////////////////////////////// Service /////////////////////////////////////////////////

  void getUserFromCahce() async {
    _user = CacheUserService.instance.getUser();
    // to cache the User Object
  }

  void getCurrentNotificationFromCache() {
    _isNotificationEnabled =
        CacheNotificationService.instance.isNotificationEnabled();
  }

  void _getSettingsModelFromCache() {
    _settingsModel = CacheSettingsService.instance.getSettings();
  }

  Future<void> updateNotificationCache(bool value) async {
    await CacheNotificationService.instance
        .updateValueOfNotification(value: value);
  }

  void getCurrentTheme() {
    _isDarkMode = CacheThemeService.instance.isDarkTheme();
  }

  Future<void> updateCurrentThemeCache(bool value) async {
    await CacheThemeService.instance.updateTheme(value: value);
  }

  Future<void> updateUserCache({required User userValue}) async {
    _user = userValue;
    await CacheUserService.instance
        .updateUser(user: userValue); // to cache the User Object
    update(['updateTopSectionOfSettingView']); // to update new Information
  }

  Future<void> logout() async {
    DialogHelper.showLoading(
      message: "جاري تسجيل الخروج",
      textDirection: TextDirection.rtl,
    );
    await AuthRepositoryService.instance.logout();

    await Future.wait([
      CacheUserService.instance.deleteUser(),
      CacheNotificationService.instance.delete(),
      // CacheThemeService.instance.deleteTheme(),
      AuthTokenService.instance.delete(),
      CacheSubjectService.instance.deleteSubjects(),
      AuthRouteService.instance.logout(),
    ])
        .then((value) => debugPrint("Delete the All Cache"))
        .catchError((e, s) => debugPrint(s.toString()));

    if (_user.providerType != null) {
      SocialRepository socialRepository = _getObjectTypeOfSocaiLogin(
          socialMediaType: GeneralUtils.instance
              .convertSocialMediaStringToEnum(_user.providerType!));

      await SocialRepositoryMangerService()
          .logout(socialRepository); // apply Polymarphism

      debugPrint("-" * 50);
      debugPrint("Log Out form ${_user.providerType!}");
      debugPrint("-" * 50);
    }
    DialogHelper.hideLoading();
    Get.offAllNamed(Routes.loginView);
  }

////////////////////////////////////////// Route Method /////////////////////////////////////////////////////
  void settingViewPageRoute() {
    Get.toNamed(Routes.settingsView);
  }

  void notificationViewPageRoute() {
    // print(CacheUserService.instance.getUser().academicYearId);
    // Get.toNamed(Routes.notificationView);
  }

  void privacyPolicyRoute() {
    Get.toNamed(Routes.privacyPolicy);
  }

  void contactUsRoute() {
    Get.toNamed(Routes.contactUs);
  }

  void cobonLocationRoute() {
    Get.toNamed(Routes.cobonLocations);
  }

  void termsRoute() {
    Get.toNamed(Routes.termsView);
  }

  void balanceViewRoute() {
    print(showBalance);
    Get.toNamed(Routes.balanceView);
  }

  void inviteFriendDialog(BuildContext context) async {
    await showDialog(
        context: context,
        builder: (BuildContext context) {
          return Container(
              width: 500, height: 200, child: const CustomDialogInviteFriend());
        });
  }

  void updateAccountViewRoute() {
    Get.toNamed(Routes.updateAccountView);
  }

  void updateChangePasswordViewRoute() {
    Get.toNamed(Routes.updateChangePasswordView);
  }

  Future<void> deleteAccount() async {
    DialogHelper.showLoading(
      message: "جاري حذف حسابك",
      textDirection: TextDirection.rtl,
    );

    await Future.wait([
      AuthRepositoryService.instance.deleteAccount(),
      CacheNotificationService.instance.delete(),
      CacheSubjectService.instance.deleteSubjects(),
    ]).catchError((e) => debugPrint(e.toString())).then(
          (value) => AuthTokenService.instance.delete(),
        );

    DialogHelper.hideLoading();
    Get.offAllNamed(Routes.loginView);
  }
}
