import 'package:quizzy_app/model/exam_statistics_model.dart';

abstract class AttemptAnsweRepository {
  Future<ExamStatisticsModel> getAttemptAnswersById(
      {required int examEttemptId});
}
