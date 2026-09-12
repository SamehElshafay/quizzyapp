import 'package:hive_flutter/hive_flutter.dart';
import 'package:quizzy_app/model/Image_dimensions_model.dart';
part 'book_model.g.dart';

@HiveType(typeId: 5)
class BookModel {
  @HiveField(0)
  int? id;
  @HiveField(1)
  String? name;
  @HiveField(2)
  String? photo;
  @HiveField(3)
  ImageDimensionsModel? imageDimensions;
  @HiveField(4)
  bool? isActive;
  @HiveField(5)
  String? createdAt;
  @HiveField(6)
  String? updatedAt;

  BookModel(
      {this.id,
      this.name,
      this.photo,
      this.imageDimensions,
      this.isActive,
      this.createdAt,
      this.updatedAt});

  factory BookModel.fromJson(Map<String, dynamic> json) {
    return BookModel(
        updatedAt: json['updated_at'],
        createdAt: json['created_at'],
        isActive: json['is_active'],
        id: json['id'],
        name: json['name'],
        photo: json['photo'],
        imageDimensions: json['image_dimensions'] != null
            ? ImageDimensionsModel.fromJson(json['image_dimensions'])
            : null);
  }

  Map<String, dynamic> toJson() {
    return {
      'updated_at': updatedAt,
      'created_at': createdAt,
      'is_active': isActive,
      'photo': photo,
      'name': name,
      'id': id,
      'image_dimensions':
          imageDimensions != null ? imageDimensions!.toJson() : {}
    };
  }
}
