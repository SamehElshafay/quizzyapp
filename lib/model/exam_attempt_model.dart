import 'package:quizzy_app/model/exam_attempts_model.dart';
import 'package:quizzy_app/model/exam_data_model.dart';

class ExamAttemptModel {
  int? id;
  int? totalQuestions;
  int? totalAnsweredQuestions;
  String? totalMarks;
  String? earnedMarks;
  String? attemptInfo;
  String? attemptStatus;
  String? attemptIp;
  String? attemptStartedAt;
  String? attemptEndedAt;
  bool? isManuallyReviewed; //  review it
  String? manuallyReviewedAt;
  int? examId;
  int? subjectId;
  int? bookId;
  int? studentId;
  String? createdBy;
  String? updatedBy;
  String? createdAt;
  String? updatedAt;
  ExamDataModel? exam;
  // String? book; // reviw
  // Subject? subject; //review
  int? numberCorrectAnswer;
  int? numberWrongAnswer;

  ExamAttemptModel(
      {this.id,
      this.totalQuestions,
      this.totalAnsweredQuestions,
      this.totalMarks,
      this.earnedMarks,
      this.attemptInfo,
      this.attemptStatus,
      this.attemptIp,
      this.attemptStartedAt,
      this.attemptEndedAt,
      this.isManuallyReviewed,
      this.manuallyReviewedAt,
      this.examId,
      this.subjectId,
      this.bookId,
      this.studentId,
      this.createdBy,
      this.updatedBy,
      this.createdAt,
      this.updatedAt,
      this.exam,
      this.numberCorrectAnswer,
      this.numberWrongAnswer});

  factory ExamAttemptModel.fromJson(Map<String, dynamic> json) {
    return ExamAttemptModel(
        numberWrongAnswer: json['number_wrong_answer'],
        numberCorrectAnswer: json['number_correct_answer'],
        // subject: json['subject'],
        // book: json['book'],
        exam:
            json['exam'] != null ? ExamDataModel.fromJson(json['exam']) : null,
        updatedAt: json['updated_at'],
        createdAt: json['created_at'],
        updatedBy: json['updated_by'],
        createdBy: json['created_by'],
        studentId: json['student_id'],
        bookId: json['book_id'],
        subjectId: json['subject_id'],
        examId: json['exam_id'],
        manuallyReviewedAt: json['manually_reviewed_at'],
        isManuallyReviewed: json['is_manually_reviewed'],
        attemptEndedAt: json['attempt_ended_at'],
        attemptStartedAt: json['attempt_started_at'],
        attemptIp: json['attempt_ip'],
        attemptStatus: json['attempt_status'],
        attemptInfo: json['attempt_info'],
        earnedMarks: json['earned_marks'],
        totalMarks: json['total_marks'],
        totalAnsweredQuestions: json['total_answered_questions'],
        totalQuestions: json['total_questions'],
        id: json['id']);
  }

  Map<String, dynamic> toJson() {
    return {
      'attempt_status': attemptStatus,
      'attempt_info': attemptInfo,
      'earned_marks': earnedMarks,
      'total_marks': totalMarks,
      'total_answered_questions': totalAnsweredQuestions,
      'total_questions': totalQuestions,
      'id': id,
      'attempt_ip': attemptIp,
      'created_by': createdBy,
      'student_id': studentId,
      'book_id': bookId,
      'subject_id': subjectId,
      'exam_id': examId,
      'manually_reviewed_at': manuallyReviewedAt,
      'is_manually_reviewed': isManuallyReviewed,
      'attempt_ended_at': attemptEndedAt,
      'attempt_started_at': attemptStartedAt,
      'created_at': createdAt,
      'updated_by': createdBy,
      'updated_at': updatedAt,
      'number_wrong_answer': numberWrongAnswer,
      'number_correct_answer': numberCorrectAnswer,
      // 'subject': subject,
      // 'book': book,
      'exam': exam != null ? exam!.toJson() : {}
    };
  }
}
