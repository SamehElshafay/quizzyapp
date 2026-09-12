import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:quizzy_app/Service/Networking/dio_exception.dart';
import 'package:quizzy_app/Service/api/repository/units_repository.dart';
import 'package:quizzy_app/model/unit_model.dart';
import 'package:quizzy_app/model/units_model.dart';
import 'package:quizzy_app/utils/end_point.dart';

import '../../Networking/dio_helper.dart';

class UnitsRepositoryService implements UnitsRepository {
  @override
  Future<UnitModel> getUnitById({required int id}) async {
    try {
      var response = await DioHelper().get(EndPoint.getUnitById(id: id));
      return UnitModel.fromJson(response);
    } on DioException catch (e, s) {
      debugPrint(s.toString());
      throw DioExceptionHelper.instance.getExceptionMessage(dioException: e);
    } catch (e, s) {
      debugPrint(s.toString());
      rethrow;
    }
  }

  @override
  Future<UnitsModel> getUnits(
      {int? skip,
      int? limit,
      required int subjectId,
      required int bookId,
      String? semester}) async {
    try {
      var response = await DioHelper().get(EndPoint.units, queryParameters: {
        'skip': skip,
        'limit': limit,
        'subject_id': subjectId,
        'book_id': bookId,
        'semester': semester,
      });
      return UnitsModel.fromJson(response);
    } on DioException catch (e, s) {
      debugPrint(s.toString());
      throw DioExceptionHelper.instance.getExceptionMessage(dioException: e);
    } catch (e, s) {
      debugPrint(s.toString());
      rethrow;
    }
  }
}
