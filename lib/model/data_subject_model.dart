import 'package:hive_flutter/hive_flutter.dart';
import 'package:quizzy_app/model/Image_dimensions_model.dart';
import 'package:quizzy_app/model/academic_year_model.dart';
import 'package:quizzy_app/model/book_model.dart';

part 'data_subject_model.g.dart';

@HiveType(typeId: 4)
class DataSubjectModel {
  @HiveField(0)
  int? id;
  @HiveField(1)
  String? name;
  @HiveField(2)
  String? photo;
  @HiveField(3)
  List<BookModel>? books;
  @HiveField(4)
  int? academicYearId;
  @HiveField(5)
  AcademicYearModel? academicYear;
  @HiveField(6)
  bool? isActive;
  @HiveField(7)
  String? createdAt;
  @HiveField(8)
  String? updatedAt;
  @HiveField(9)
  ImageDimensionsModel? imageDimensions;

  DataSubjectModel(
      {this.id,
      this.name,
      this.photo,
      this.imageDimensions,
      this.academicYearId,
      this.academicYear,
      this.isActive,
      this.books,
      this.createdAt,
      this.updatedAt});

  factory DataSubjectModel.fromJson(Map<String, dynamic> json) {
    List<BookModel> listBookModel = [];
    if (json['books'] != null) {
      json['books'].forEach((v) {
        listBookModel.add(BookModel.fromJson(v));
      });
    }
    return DataSubjectModel(
        id: json['id'],
        academicYearId: json['academic_year_id'],
        name: json['name'],
        photo: json['photo'],
        imageDimensions: json['image_dimensions'] != null
            ? ImageDimensionsModel.fromJson(json['image_dimensions'])
            : null,
        isActive: json['is_active'],
        createdAt: json['created_at'],
        updatedAt: json['updated_at'],
        books: listBookModel,
        academicYear: json['academic_year'] != null
            ? AcademicYearModel.fromJson(json['academic_year'])
            : null);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'photo': photo,
      'academic_year_id': academicYearId,
      'is_active': isActive,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'image_dimensions':
          imageDimensions != null ? imageDimensions!.toJson() : {},
      'academic_year': academicYear != null ? academicYear!.toJson() : {}
    };
  }
}
