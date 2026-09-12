import 'package:hive_flutter/hive_flutter.dart';
import 'package:quizzy_app/model/settings_data_model.dart';
part 'settings_model.g.dart';

@HiveType(typeId: 8)
class SettingsModel {
  @HiveField(0)
  bool? success;
  @HiveField(1)
  SettingsData? settingsData;
  @HiveField(2)
  String? message;

  SettingsModel({this.success, this.settingsData, this.message});

  factory SettingsModel.fromJson(Map<String, dynamic> json) {
    return SettingsModel(
        settingsData:
            json['data'] != null ? SettingsData.fromJson(json['data']) : null,
        message: json['message'],
        success: json['success']);
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'success': success,
      'data': settingsData != null ? settingsData!.toJson() : {}
    };
  }
}
