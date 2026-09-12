import 'package:quizzy_app/model/Image_dimensions_model.dart';

class AnswersModel {
  int? id;
  String? title;
  String? questionType;
  String? answerTwoGapMatch;
  String? answerViewFormat;
  int? answerOrder;
  String? answerSettings;
  String? photo;
  bool? isCorrect;
  String? createdAt;
  String? updatedAt;
  ImageDimensionsModel? imageDimensions;

  AnswersModel(
      {this.id,
      this.title,
      this.questionType,
      this.answerTwoGapMatch,
      this.answerViewFormat,
      this.answerOrder,
      this.answerSettings,
      this.photo,
      this.imageDimensions,
      this.isCorrect,
      this.createdAt,
      this.updatedAt});

  factory AnswersModel.fromJson(Map<String, dynamic> json) {
    return AnswersModel(
        id: json['id'],
        title: json['title'],
        questionType: json['question_type'],
        answerTwoGapMatch: json['answer_two_gap_match'],
        answerViewFormat: json['answer_view_format'],
        answerOrder: json['answer_order'],
        answerSettings: json['answer_settings'],
        photo: json['photo'],
        imageDimensions: json['image_dimensions'] != null
            ? ImageDimensionsModel.fromJson(json['image_dimensions'])
            : null,
        createdAt: json['created_at'],
        isCorrect: json['is_correct'],
        updatedAt: json['updated_at']);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'question_type': questionType,
      'answer_two_gap_match': answerTwoGapMatch,
      'answer_view_format': answerViewFormat,
      'answer_order': answerOrder,
      'answer_settings': answerSettings,
      'photo': photo,
      'is_correct': isCorrect,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'image_dimensions':
          imageDimensions != null ? imageDimensions!.toJson() : {},
    };
  }
}
