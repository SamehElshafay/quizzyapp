import 'package:quizzy_app/model/send_note_or_wrong_to_question_mode.dart';

abstract class QuestionsRepository {
  Future<SendNoteOrWrongToQuestionModel> sendNoteOrWrongToQuestionById(
      {required int id, required bool needReview, required String notes});
}
