import 'package:hive_flutter/hive_flutter.dart';

part 'settings_data_model.g.dart';

@HiveType(typeId: 10)
class SettingsData {
  @HiveField(0)
  String? logo;
  @HiveField(1)
  String? fcmKey;
  @HiveField(2)
  String? applicationName;
  @HiveField(3)
  String? version;
  @HiveField(4)
  String? terms;
  @HiveField(5)
  String? privacyPolicy;
  @HiveField(6)
  String? balanceDefault;
  @HiveField(7)
  String? baseUrlApi;
  @HiveField(8)
  String? isTeacher;
  @HiveField(9)
  String? showBalance;
  @HiveField(10)
  String? inviterGift;
  @HiveField(11)
  String? inviteeGift;
  @HiveField(12)
  String? invitationShareMsg;
  @HiveField(13)
  String? inputInvitationCodeMsg;
  @HiveField(14)
  String? showLoginThirdParty;
  @HiveField(15)
  String? showDeleteAccount;
  SettingsData({
    this.logo,
    this.fcmKey,
    this.applicationName,
    this.version,
    this.terms,
    this.privacyPolicy,
    this.balanceDefault,
    this.baseUrlApi,
    this.isTeacher,
    this.showBalance,
    this.inputInvitationCodeMsg,
    this.invitationShareMsg,
    this.inviteeGift,
    this.inviterGift,
    this.showDeleteAccount,
    this.showLoginThirdParty,
  });

  factory SettingsData.fromJson(Map<String, dynamic> json) {
    return SettingsData(
      logo: json['logo'],
      fcmKey: json['fcm_key'],
      applicationName: json['application_name'],
      version: json['version'],
      terms: json['terms'],
      privacyPolicy: json['privacy_policy'],
      balanceDefault: json['balance_default'],
      baseUrlApi: json['base_url_api'],
      isTeacher: json['block_app'],
      showBalance: json['show_balance'],
      inputInvitationCodeMsg: json['input_invitation_code_msg'],
      invitationShareMsg: json['invitation_share_msg'],
      inviteeGift: json['invitee_gift'],
      inviterGift: json['inviter_gift'],
      showDeleteAccount: json['show_delete_account'],
      showLoginThirdParty: json['show_login_third_party'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'logo': logo,
      'fcm_key': fcmKey,
      'application_name': applicationName,
      'version': version,
      'terms': terms,
      'privacy_policy': privacyPolicy,
      'balance_default': balanceDefault,
      'base_url_api': baseUrlApi,
      'block_app': isTeacher,
      'show_balance': showBalance
    };
  }
}
