class AdsModel {
  bool? success;
  List<AdsData>? data;
  String? message;

  AdsModel({this.success, this.data, this.message});

  factory AdsModel.fromJson(Map<String, dynamic> json) {
    List<AdsData> list = [];

    if (json['data'] != null) {
      json['data'].forEach((v) {
        list.add(AdsData.fromJson(v));
      });
    }

    return AdsModel(
        message: json['message'], success: json['success'], data: list);
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'success': success,
      'data': data != null ? data!.map((v) => v.toJson()).toList() : []
    };
  }
}

class AdsData {
  int? id;
  String? title;
  String? photo;
  bool? isActive;
  String? createdAt;
  String? updatedAt;

  AdsData(
      {this.id,
      this.title,
      this.photo,
      this.isActive,
      this.createdAt,
      this.updatedAt});

  factory AdsData.fromJson(Map<String, dynamic> json) {
    return AdsData(
      id: json['id'],
      title: json['title'],
      photo: json['photo'],
      isActive: json['is_active'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'photo': photo,
      'is_active': isActive,
      'created_at': createdAt,
      'updated_at': updatedAt
    };
  }
}
