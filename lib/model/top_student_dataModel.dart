class TopStudentDataModel {
  String? totalEarnedMarks;
  Student? student;
  bool? isCurrentStudent;

  TopStudentDataModel(
      {this.totalEarnedMarks, this.student, this.isCurrentStudent});

  factory TopStudentDataModel.fromJson(Map<String, dynamic> json) {
    return TopStudentDataModel(
        totalEarnedMarks: json['total_earned_marks'],
        isCurrentStudent: json['is_current_student'],
        student:
            json['student'] != null ? Student.fromJson(json['student']) : null);
  }

  Map<String, dynamic> toJson() {
    return {
      'is_current_student': isCurrentStudent,
      'total_earned_marks': totalEarnedMarks,
      'student': student != null ? student!.toJson() : {}
    };
  }
}

class Student {
  int? id;
  String? username;
  String? name;
  String? email;
  String? photo;

  Student({this.id, this.username, this.name, this.email, this.photo});

  factory Student.fromJson(Map<String, dynamic> json) {
    return Student(
        id: json['id'],
        username: json['username'],
        email: json['email'],
        name: json['name'],
        photo: json['photo']);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'name': name,
      'email': email,
      'photo': photo
    };
  }
}
