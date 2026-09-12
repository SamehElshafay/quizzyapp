class LessonsModel {
  int? id;
  String? name;
  String? description;
  String? photo;
  bool? isActive;
  String? createdAt;
  String? updatedAt;

  LessonsModel(
      {this.id,
      this.name,
      this.description,
      this.photo,
      this.isActive,
      this.createdAt,
      this.updatedAt});

  factory LessonsModel.fromJson(Map<String, dynamic> json) {
    return LessonsModel(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      photo: json['photo'],
      isActive: json['is_active'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'photo': photo,
      'is_active': isActive,
      'created_at': createdAt,
      'updated_at': updatedAt
    };
  }
}
