import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:quizzy_app/Service/Networking/dio_exception.dart';
import 'package:quizzy_app/Service/Networking/dio_helper.dart';
import 'package:quizzy_app/Service/api/repository/attempt_answers_repository.dart';
import 'package:quizzy_app/model/exam_statistics_model.dart';
import 'package:quizzy_app/utils/end_point.dart';

class AttemptAnsweRepositoryService implements AttemptAnsweRepository {
  @override
  Future<ExamStatisticsModel> getAttemptAnswersById(
      {required int examEttemptId}) async {
    try {
      var response = await DioHelper()
          .get(EndPoint.getAttemptAnswers(examAttemptId: examEttemptId));
      return ExamStatisticsModel.fromJson(response);
    } on DioException catch (e, s) {
      debugPrint(s.toString());
      throw DioExceptionHelper.instance.getExceptionMessage(dioException: e);
    } catch (e, s) {
      debugPrint(s.toString());
      rethrow;
    }
  }
}
