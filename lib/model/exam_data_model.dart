class ExamDataModel {
  int? id;
  String? name;
  String? type;
  String? questionTypes;
  String? level;
  String? typeAssessment;
  String? description;
  String? photo;
  String? semester;
  String? points;
  String? time;
  int? subjectId;
  int? bookId;
  int? unitId;
  int? lessonId;
  bool? isActive;
  String? createdAt;
  String? updatedAt;

  ExamDataModel(
      {this.id,
      this.name,
      this.type,
      this.questionTypes,
      this.level,
      this.typeAssessment,
      this.description,
      this.photo,
      this.semester,
      this.points,
      this.time,
      this.subjectId,
      this.bookId,
      this.unitId,
      this.lessonId,
      this.isActive,
      this.createdAt,
      this.updatedAt});

  ExamDataModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    type = json['type'];
    questionTypes = json['question_types'];
    level = json['level'];
    typeAssessment = json['type_assessment'];
    description = json['description'];
    photo = json['photo'];
    semester = json['semester'];
    points = json['points'];
    time = json['time'];
    subjectId = json['subject_id'];
    bookId = json['book_id'];
    unitId = json['unit_id'];
    lessonId = json['lesson_id'];
    isActive = json['is_active'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['type'] = this.type;
    data['question_types'] = this.questionTypes;
    data['level'] = this.level;
    data['type_assessment'] = this.typeAssessment;
    data['description'] = this.description;
    data['photo'] = this.photo;
    data['semester'] = this.semester;
    data['points'] = this.points;
    data['time'] = this.time;
    data['subject_id'] = this.subjectId;
    data['book_id'] = this.bookId;
    data['unit_id'] = this.unitId;
    data['lesson_id'] = this.lessonId;
    data['is_active'] = this.isActive;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
