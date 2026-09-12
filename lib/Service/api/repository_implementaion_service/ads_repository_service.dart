import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:quizzy_app/Service/Networking/dio_exception.dart';
import 'package:quizzy_app/Service/Networking/dio_helper.dart';
import 'package:quizzy_app/Service/api/repository/ads_repository.dart';
import 'package:quizzy_app/model/ads_model.dart';
import 'package:quizzy_app/utils/end_point.dart';

class AdsRepositoryService implements AdsRepository {
  @override
  Future<AdsModel> getAds({int? skip, int? limit}) async {
    try {
      var response = await DioHelper()
          .get(EndPoint.ads, queryParameters: {'skip': skip, 'limit': limit});
      return AdsModel.fromJson(response);
    } on DioException catch (e, s) {
      debugPrint(s.toString());
      throw DioExceptionHelper.instance.getExceptionMessage(dioException: e);
    } catch (e, s) {
      debugPrint(s.toString());
      rethrow;
    }
  }
}
