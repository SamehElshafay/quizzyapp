import 'package:quizzy_app/model/Image_dimensions_model.dart';
import 'package:quizzy_app/model/answers_model.dart';

class QuestionsModel {
  int? id;
  String? name;
  String? type;
  String? description;
  String? photo;
  String? file;
  String? fileType;
  String? level;
  int? lessonId;
  String? semester;
  String? points;
  String? time;
  bool? isActive;
  String? createdAt;
  String? updatedAt;
  String? reference;
  String? notes;
  bool? needReview;
  ImageDimensionsModel? imageDimensions;

  List<AnswersModel>? answers;

  QuestionsModel(
      {this.id,
      this.name,
      this.type,
      this.description,
      this.photo,
      this.reference,
      this.needReview,
      this.semester,
      this.points,
      this.file,
      this.notes,
      this.fileType,
      this.lessonId,
      this.imageDimensions,
      this.level,
      this.answers,
      this.time,
      this.isActive,
      this.createdAt,
      this.updatedAt});

  factory QuestionsModel.fromJson(Map<String, dynamic> json) {
    List<AnswersModel> lisAnswerModel = [];
    if (json['answers'] != null) {
      json['answers'].forEach((v) {
        lisAnswerModel.add(AnswersModel.fromJson(v));
      });
    }
    return QuestionsModel(
        createdAt: json['created_at'],
        updatedAt: json['updated_at'],
        isActive: json['is_active'],
        time: json['time'],
        notes: json['notes'],
        points: json['points'],
        imageDimensions: json['image_dimensions'] != null
            ? ImageDimensionsModel.fromJson(json['image_dimensions'])
            : null,
        reference: json['reference'],
        description: json['description'],
        semester: json['semester'],
        photo: json['photo'],
        type: json['type'],
        name: json['name'],
        id: json['id'],
        file: json['file'],
        fileType: json['file_type'],
        level: json['level'],
        lessonId: json['lesson_id'],
        needReview: json['need_review'],
        answers: lisAnswerModel);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'reference': reference,
      'name': name,
      'notes': notes,
      'type': type,
      'description': description,
      'photo': photo,
      'semester': semester,
      'points': points,
      'time': time,
      'is_active': isActive,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'file': file,
      'file_type': fileType,
      'level': level,
      'image_dimensions':
          imageDimensions != null ? imageDimensions!.toJson() : {},
      'lesson_id': lessonId,
      'need_review': needReview,
      'answers': answers != null ? answers!.map((v) => v.toJson()).toList() : []
    };
  }
}
