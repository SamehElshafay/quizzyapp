import 'package:get/get.dart';
import 'package:quizzy_app/Service/local/cache_settings_service.dart';
import 'package:quizzy_app/Service/local/cache_user_service.dart';

class InviteFriendViewModel extends GetxController {
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  String getInvitationCode() {
    return CacheUserService.instance.getUser().invitationCode ??
        'لايوجد لك رمز دعوة';
  }

  String getMessageHelperOfInvitition() {
    return CacheSettingsService.instance
            .getSettings()
            .settingsData!
            .invitationShareMsg ??
        '';
    /*
بكل سهولة يمكنك إضافة رصيد مجاني إلي رصيدك عند دعوة صديق لك كل ماعليك هو نسخ هذا الكود وإرساله إلي صديقك وسوف يستخدمه صديقك أثناء عملية تسجيل الحساب
        */
  }
}
