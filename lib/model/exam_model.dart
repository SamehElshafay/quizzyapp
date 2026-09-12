import 'package:quizzy_app/model/Image_dimensions_model.dart';
import 'package:quizzy_app/model/questions_model.dart';

class ExamModel {
  int? id;
  String? name;
  String? type;
  String? questionTypes;
  String? level;
  String? typeAssessment;
  String? description;
  String? photo;
  String? file; // check it
  String? semester;
  String? points;
  String? time;
  bool? isActive;
  int? subjectId;
  ImageDimensionsModel? imageDimensions;

  List<QuestionsModel>? questions;
  String? createdAt;
  String? updatedAt;

  ExamModel(
      {this.id,
      this.name,
      this.type,
      this.subjectId,
      this.questionTypes,
      this.level,
      this.typeAssessment,
      this.description,
      this.photo,
      this.file,
      this.semester,
      this.points,
      this.time,
      this.imageDimensions,
      this.isActive,
      this.questions,
      this.createdAt,
      this.updatedAt});

  factory ExamModel.fromJson(Map<String, dynamic> json) {
    List<QuestionsModel> listQuestionModel = [];
    if (json['questions'] != null) {
      json['questions'].forEach((v) {
        listQuestionModel.add(QuestionsModel.fromJson(v));
      });
    }

    return ExamModel(
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      id: json['id'],
      imageDimensions: json['image_dimensions'] != null
          ? ImageDimensionsModel.fromJson(json['image_dimensions'])
          : null,
      name: json['name'],
      type: json['type'],
      questionTypes: json['question_types'],
      level: json['level'],
      typeAssessment: json['type_assessment'],
      description: json['description'],
      photo: json['photo'],
      file: json['file'],
      semester: json['semester'],
      points: json['points'],
      time: json['time'],
      isActive: json['is_active'],
      subjectId: json['subject_id'],
      questions: listQuestionModel,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'type': type,
      'question_types': questionTypes,
      'level': level,
      'type_assessment': typeAssessment,
      'description': description,
      'photo': photo,
      'file': file,
      'semester': semester,
      'points': points,
      'subject_id': subjectId,
      'time': time,
      'is_active': isActive,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'image_dimensions':
          imageDimensions != null ? imageDimensions!.toJson() : {},
      'questions':
          questions != null ? questions!.map((v) => v.toJson()).toList() : []
    };
  }
}
