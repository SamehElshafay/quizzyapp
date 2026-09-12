import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:quizzy_app/Service/Networking/dio_exception.dart';
import 'package:quizzy_app/Service/Networking/dio_helper.dart';
import 'package:quizzy_app/Service/api/repository/exam_repository.dart';
import 'package:quizzy_app/model/achievement_model.dart';
import 'package:quizzy_app/model/answer_question_model.dart';
import 'package:quizzy_app/model/exam_attempts_model.dart';
import 'package:quizzy_app/model/exams_model.dart';
import 'package:quizzy_app/model/show_exam_attempts_model.dart';
import 'package:quizzy_app/model/start_quiz_model.dart';
import 'package:quizzy_app/model/store_exam_model.dart';
import 'package:quizzy_app/model/top_student_point_model.dart';
import 'package:quizzy_app/model/validation_erro_model.dart';
import 'package:quizzy_app/utils/end_point.dart';

class ExamRepositoryService implements ExamRepository {
  @override
  Future<ExamsModel> getExams(
      {int? skip,
      int? limit,
      required String type,
      required int subjectId,
      String? typeAssessment}) async {
    try {
      var response = await DioHelper().get(EndPoint.exams, queryParameters: {
        'skip': skip,
        'limit': limit,
        'type': type,
        'subject_id': subjectId,
        'typeAssessment': typeAssessment
      });
      return ExamsModel.fromJson(response);
    } on DioException catch (e, s) {
      debugPrint(s.toString());
      throw DioExceptionHelper.instance.getExceptionMessage(dioException: e);
    } catch (e, s) {
      debugPrint(s.toString());
      rethrow;
    }
  }

  @override
  Future<ExamsModel> showExam({required int id}) {
    // TODO: implement showExam
    throw UnimplementedError();
  }

  @override
  Future<ExamsModel> storeExam({required StoreExamModel storeExamModel}) async {
    try {
      var reponse = await DioHelper().post(EndPoint.storeExams, data: {
        'name': storeExamModel.name,
        'type': storeExamModel.type,
        'question_types': storeExamModel.questionTypes,
        'level': storeExamModel.level,
        'type_assessment': storeExamModel.typeAssessment,
        'description': storeExamModel.description,
        'photo': storeExamModel.photo,
        'semester': storeExamModel.semester,
        'is_active': storeExamModel.isActive,
        'unit_id': storeExamModel.unitId,
        'lesson_id': storeExamModel.lessonId,
        'subject_id': storeExamModel.subjectId,
        'time': storeExamModel.time,
        'book_id': storeExamModel.bookId
      });

      return ExamsModel.fromJson(reponse);
    } on DioException catch (e) {
      print("-" * 50);
      debugPrint('${e.response!.data}');
      print("-" * 50);

      throw ValidationErroModel.fromJson(e.response!.data).message.toString();
    } catch (e, s) {
      debugPrint(s.toString());
      rethrow;
    }
  }

  @override
  Future<AnswerQuestionModel> answerQuestion(
      {required int questionId,
      required int examAttemptId,
      required int timeSpent,
      required var givenAnswer}) async {
    try {
      var reponse = await DioHelper().post(EndPoint.answerQuestion, data: {
        'exam_attempt_id': examAttemptId,
        'question_id': questionId,
        'given_answer': givenAnswer,
        'time_spent': timeSpent
      });

      return AnswerQuestionModel.fromJson(reponse);
    } on DioException catch (e, s) {
      debugPrint(s.toString());
      throw ValidationErroModel.fromJson(e.response!.data).message.toString();
    } catch (e, s) {
      debugPrint(s.toString());
      rethrow;
    }
  }

  @override
  Future<StartQuizModel> startQuiz({required int examId}) async {
    try {
      var reponse =
          await DioHelper().post(EndPoint.startQuiz, data: {'exam_id': examId});

      return StartQuizModel.fromJson(reponse);
    } on DioException catch (e) {
      throw ValidationErroModel.fromJson(e.response!.data).message.toString();
    } catch (e, s) {
      debugPrint(s.toString()); // to print the Erro Stack Lines
      rethrow;
    }
  }

  @override
  Future<AchievementModel> getAchievement({int? subjectId}) async {
    try {
      var response =
          await DioHelper().get(EndPoint.achievements, queryParameters: {
        'subject_id': subjectId,
      });
      return AchievementModel.fromJson(response);
    } on DioException catch (e, s) {
      debugPrint(s.toString());
      throw DioExceptionHelper.instance.getExceptionMessage(dioException: e);
    } catch (e, s) {
      debugPrint(s.toString());
      rethrow;
    }
  }

  @override
  Future<ExamAttemptsModel> getExamAttempts({int? page, int? limit}) async {
    try {
      var response = await DioHelper().get(EndPoint.examAttempts,
          queryParameters: {'page': page, 'limit': limit});
      return ExamAttemptsModel.fromJson(response);
    } on DioException catch (e, s) {
      debugPrint(s.toString());
      throw DioExceptionHelper.instance.getExceptionMessage(dioException: e);
    } catch (e, s) {
      debugPrint(s.toString());
      rethrow;
    }
  }

  @override
  Future<ShowExamAttemptsModel> showExamAttempts({required int id}) async {
    try {
      var response = await DioHelper().get(EndPoint.showExamAttempt(id: id));
      return ShowExamAttemptsModel.fromJson(response);
    } on DioException catch (e, s) {
      debugPrint(s.toString());
      throw DioExceptionHelper.instance.getExceptionMessage(dioException: e);
    } catch (e, s) {
      debugPrint(s.toString());
      rethrow;
    }
  }

  @override
  Future<TopStudentPointModel> getTopStudentPoints(
      {int? examIdOfStartQuiz,
      int? selectedSubjectId,
      int? page,
      int? limit}) async {
    try {
      var response =
          await DioHelper().get(EndPoint.topStudent, queryParameters: {
        'selected_subject_id': selectedSubjectId,
        'selected_exam_id': examIdOfStartQuiz,
        'page': page,
        'limit': limit
      });
      return TopStudentPointModel.fromJson(response);
    } on DioException catch (e, s) {
      debugPrint(s.toString());
      throw DioExceptionHelper.instance.getExceptionMessage(dioException: e);
    } catch (e, s) {
      debugPrint(s.toString());
      rethrow;
    }
  }
}
