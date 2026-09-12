import 'package:quizzy_app/model/settings_model.dart';

abstract class SettingsRepository {
  Future<SettingsModel> getSettings();
  getNotifications();
}
