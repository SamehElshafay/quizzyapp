import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:quizzy_app/Service/Networking/dio_exception.dart';
import 'package:quizzy_app/Service/Networking/dio_helper.dart';
import 'package:quizzy_app/Service/api/repository/questions_repository.dart';
import 'package:quizzy_app/model/send_note_or_wrong_to_question_mode.dart';
import 'package:quizzy_app/utils/end_point.dart';

class QuestionsRepositoryService implements QuestionsRepository {
  @override
  Future<SendNoteOrWrongToQuestionModel> sendNoteOrWrongToQuestionById(
      {required int id,
      required bool needReview,
      required String notes}) async {
    final Map<String, dynamic> data = {
      "notes": notes,
      "need_review": needReview ? 1 : 0
    };

    try {
      var response = await DioHelper().put(
          EndPoint.getSendNoteOrWrongToQuestion(idQuestion: id),
          data: jsonEncode(data)); // pass the body as Raw of Data
      return SendNoteOrWrongToQuestionModel.fromJson(response);
    } on DioException catch (e, s) {
      debugPrint(s.toString());
      throw DioExceptionHelper.instance.getExceptionMessage(dioException: e);
    } catch (e, s) {
      debugPrint(s.toString());
      rethrow;
    }
  }
}
