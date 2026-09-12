import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:quizzy_app/Service/Networking/dio_exception.dart';
import 'package:quizzy_app/Service/api/repository/settings_repository.dart';
import 'package:quizzy_app/model/settings_model.dart';
import 'package:quizzy_app/utils/end_point.dart';

import '../../Networking/dio_helper.dart';

class SettingsRepositoryService implements SettingsRepository {
  @override
  getNotifications() {
    // TODO: implement getNotifications
    throw UnimplementedError();
  }

  @override
  Future<SettingsModel> getSettings() async {
    try {
      var response = await DioHelper().get(EndPoint.settings);
      return SettingsModel.fromJson(response);
    } on DioException catch (e, s) {
      // debugPrint(s.toString());
      throw DioExceptionHelper.instance.getExceptionMessage(dioException: e);
    } catch (e, s) {
      debugPrint(s.toString());
      rethrow;
    }
  }
}
