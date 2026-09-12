import 'package:hive_flutter/hive_flutter.dart';

part 'Image_dimensions_model.g.dart';

@HiveType(typeId: 6)
class ImageDimensionsModel {
  @HiveField(0)
  int? width;
  @HiveField(1)
  int? height;

  ImageDimensionsModel({this.width, this.height});

  factory ImageDimensionsModel.fromJson(Map<String, dynamic> json) {
    return ImageDimensionsModel(height: json['height'], width: json['width']);
  }

  Map<String, dynamic> toJson() {
    return {'width': width, 'height': height};
  }
}
