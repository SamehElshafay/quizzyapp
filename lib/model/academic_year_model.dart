import 'package:hive_flutter/hive_flutter.dart';
part 'academic_year_model.g.dart';

@HiveType(typeId: 2)
class AcademicYearModel {
  @HiveField(0)
  int? id;
  @HiveField(1)
  String? name;
  @HiveField(2)
  String? photo;
  @HiveField(3)
  bool? isActive;
  @HiveField(4)
  String? createdAt;
  @HiveField(5)
  String? updatedAt;

  AcademicYearModel(
      {this.id,
      this.name,
      this.photo,
      this.isActive,
      this.createdAt,
      this.updatedAt});

  factory AcademicYearModel.fromJson(Map<String, dynamic> json) {
    return AcademicYearModel(
      id: json['id'],
      name: json['name'],
      createdAt: json['created_at'],
      isActive: json['is_active'],
      photo: json['photo'],
      updatedAt: json['updated_at'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      'name': name,
      'photo': photo,
      'is_active': isActive,
      'created_at': createdAt,
      'updated_at': updatedAt
    };
  }
}
