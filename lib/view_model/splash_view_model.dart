import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quizzy_app/Service/Firebase/social_service/repository_implementaion_service/apple_repository_service.dart';
import 'package:quizzy_app/Service/Firebase/social_service/repository_implementaion_service/facebook_repository_service.dart';
import 'package:quizzy_app/Service/Firebase/social_service/repository_implementaion_service/google_repository_Service.dart';
import 'package:quizzy_app/Service/Firebase/social_service/repository_implementaion_service/social_repository_manger_service.dart';
import 'package:quizzy_app/Service/api/repository_implementaion_service/profile_repository_service.dart';

import 'package:quizzy_app/Service/local/auth_route_service.dart';
import 'package:quizzy_app/Service/local/auth_token_service.dart';
import 'package:quizzy_app/Service/local/cache_notification_service.dart';
import 'package:quizzy_app/Service/local/cache_subject_service.dart';
import 'package:quizzy_app/Service/local/cache_user_service.dart';
import 'package:quizzy_app/Service/nottification/push_notification_service.dart';
import 'package:quizzy_app/model/user_model.dart';
import 'package:quizzy_app/utils/constant.dart';

import 'package:quizzy_app/utils/general_utils.dart';
import 'package:quizzy_app/utils/routes.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:quizzy_app/Service/local/cache_settings_service.dart';
import 'package:quizzy_app/model/settings_model.dart';
import 'dart:math' show max;
import '../Service/Firebase/social_service/repository/social_repository.dart';

class SplashViewModel extends GetxController {
  String splashTextInit = "";
  Future<bool> _isForceUpdateRequired() async {
    try {
      PackageInfo packageInfo = await PackageInfo.fromPlatform();
      String currentVersionName = packageInfo.version;
      int currentVersionCode = int.tryParse(packageInfo.buildNumber) ?? 0;

      SettingsModel settings = CacheSettingsService.instance.getSettings();
      String? serverVersion = settings.settingsData?.version;

      if (serverVersion != null && serverVersion.isNotEmpty) {
        if (RegExp(r'^\d+$').hasMatch(serverVersion)) {
          int minVersionCode = int.tryParse(serverVersion) ?? 0;
          return currentVersionCode < minVersionCode;
        } else {
          return _isNewerVersion(currentVersionName, serverVersion);
        }
      }
    } catch (e) {
      debugPrint("Error checking force update: $e");
    }
    return false;
  }

  bool _isNewerVersion(String currentVersion, String serverVersion) {
    List<int> currentParts =
        currentVersion.split('.').map((e) => int.tryParse(e) ?? 0).toList();
    List<int> serverParts =
        serverVersion.split('.').map((e) => int.tryParse(e) ?? 0).toList();

    for (int i = 0; i < max(currentParts.length, serverParts.length); i++) {
      int currentPart = i < currentParts.length ? currentParts[i] : 0;
      int serverPart = i < serverParts.length ? serverParts[i] : 0;
      if (serverPart > currentPart) return true;
      if (currentPart > serverPart) return false;
    }
    return false;
  }

  @override
  void onInit() async {
    super.onInit();
    await PushNotificationService().initPushNotification();

    // Check for force update
    bool needUpdate = await _isForceUpdateRequired();
    if (needUpdate) {
      Get.offAllNamed(Routes.updateView);
      return;
    }

    Timer(const Duration(milliseconds: 30), () async {
      bool result = AuthRouteService.instance.readRoute();
      debugPrint("-" * 50);
      debugPrint("Route Exit : $result");
      debugPrint("-" * 50);
      if (result) {
        bool isGuest = AuthRouteService.instance.readIsGuest();
        if (isGuest) {
          Get.offAllNamed(Routes.bottomNavgation);
        } else {
          _getProfileService();
        }
      } else {
        Get.offAllNamed(Routes.loginView);
        // if the Account Deleted from the System
        await _logout();
      }
    });
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() async {
    super.onClose();
  }

  void _getProfileService() {
    Future.wait([
      PofileRepositoryService().getProfile().then((value) async {
        if (value.data!.isActive != null && value.data!.isActive!) {
          await CacheUserService.instance
              .updateUser(user: value.data!); // to cache the User Object
          Get.offAllNamed(Routes.bottomNavgation);
        } else {
          Get.offAllNamed(Routes.loginView);
        }
      }).catchError((e) {
        debugPrint(e);
        Get.offAllNamed(Routes.loginView);
      }),
    ]).catchError((e) => debugPrint(e));
  }

  Future<void> _logout() async {
    User _user = CacheUserService.instance.getUser();

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
  }

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
}
