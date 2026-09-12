class StartQuizModel {
  bool? success;
  StartQuizData? data;
  String? message;

  StartQuizModel({this.success, this.data, this.message});

  factory StartQuizModel.fromJson(Map<String, dynamic> json) {
    return StartQuizModel(
        message: json['message'],
        success: json['success'],
        data:
            json['data'] != null ? StartQuizData.fromJson(json['data']) : null);
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'message': message,
      'data': data != null ? data!.toJson() : {}
    };
  }
}

class StartQuizData {
  int? examId;
  int? totalQuestions;
  int? totalMarks;
  int? totalAnsweredQuestions;
  String? attemptStatus;
  String? attemptIp;
  String? attemptStartedAt;
  int? bookId;
  int? studentId;
  String? updatedAt;
  String? createdAt;
  int? id;

  StartQuizData(
      {this.examId,
      this.totalQuestions,
      this.totalMarks,
      this.totalAnsweredQuestions,
      this.attemptStatus,
      this.attemptIp,
      this.attemptStartedAt,
      this.bookId,
      this.studentId,
      this.updatedAt,
      this.createdAt,
      this.id});

  factory StartQuizData.fromJson(Map<String, dynamic> json) {
    return StartQuizData(
        examId: json['exam_id'],
        totalQuestions: json['total_questions'],
        totalMarks: json['total_marks'],
        totalAnsweredQuestions: json['total_answered_questions'],
        attemptStatus: json['attempt_status'],
        attemptIp: json['attempt_ip'],
        attemptStartedAt: json['attempt_started_at'],
        bookId: json['book_id'],
        studentId: json['student_id'],
        updatedAt: json['updated_at'],
        createdAt: json['created_at'],
        id: json['id']);
  }

  Map<String, dynamic> toJson() {
    return {
      'exam_id': examId,
      'total_questions': totalQuestions,
      'total_marks': totalMarks,
      'total_answered_questions': totalAnsweredQuestions,
      'attempt_status': attemptStatus,
      'attempt_ip': attemptIp,
      'attempt_started_at': attemptStartedAt,
      'book_id': bookId,
      'student_id': studentId,
      'updated_at': updatedAt,
      'created_at': createdAt,
      'id': id
    };
  }
}
