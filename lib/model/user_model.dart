import 'package:hive_flutter/hive_flutter.dart';
import 'package:quizzy_app/model/Image_dimensions_model.dart';

import 'academic_year_model.dart';
part 'user_model.g.dart';

@HiveType(typeId: 1)
class User {
  @HiveField(0)
  int? id;
  @HiveField(1)
  String? name;
  @HiveField(2)
  String? username;
  @HiveField(3)
  String? email;
  @HiveField(4)
  String? phone;
  @HiveField(5)
  String? photo;
  @HiveField(6)
  String? dateOfBirth;
  @HiveField(7)
  String? governorate;
  @HiveField(8)
  String? area;
  @HiveField(9)
  String? residenceArea;
  @HiveField(10)
  String? specialization;
  @HiveField(11)
  int? academicYearId;
  @HiveField(12)
  String? providerId;
  @HiveField(13)
  String? providerType;
  @HiveField(14)
  String? deviceToken;
  @HiveField(15)
  AcademicYearModel? academicYear;
  @HiveField(16)
  bool? isActive;
  @HiveField(17)
  String? createdAt;
  @HiveField(18)
  String? updatedAt;
  @HiveField(19)
  bool? hasVerifiedEmail;
  @HiveField(20)
  bool? phoneVerified;
  @HiveField(21)
  String? locationArea;
  @HiveField(22)
  int? balance;
  @HiveField(23)
  ImageDimensionsModel? imageDimensionsModel;
  @HiveField(24)
  String? invitationCode;

  User(
      {this.id,
      this.name,
      this.username,
      this.email,
      this.phone,
      this.photo,
      this.locationArea,
      this.hasVerifiedEmail,
      this.dateOfBirth,
      this.governorate,
      this.area,
      this.balance,
      this.imageDimensionsModel,
      this.residenceArea,
      this.specialization,
      this.academicYearId,
      this.providerId,
      this.providerType,
      this.deviceToken,
      this.academicYear,
      this.isActive,
      this.phoneVerified,
      this.createdAt,
      this.updatedAt,
      this.invitationCode});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        id: json['id'],
        name: json['name'],
        invitationCode: json['invitation_code'],
        username: json['username'],
        email: json['email'],
        phone: json['phone'],
        photo: json['photo'],
        balance: json['balance'],
        dateOfBirth: json['date_of_birth'],
        governorate: json['governorate'],
        area: json['area'],
        residenceArea: json['residence_area'],
        specialization: json['specialization'],
        academicYearId: json['academic_year_id'],
        providerId: json['provider_id'],
        providerType: json['provider_type'],
        deviceToken: json['device_token'],
        academicYear: json['academic_year'] != null
            ? AcademicYearModel.fromJson(json['academic_year'])
            : null,
        imageDimensionsModel: json['image_dimensions'] != null
            ? ImageDimensionsModel.fromJson(json['image_dimensions'])
            : null,
        isActive: json['is_active'],
        hasVerifiedEmail: json['hasVerifiedEmail'],
        createdAt: json['created_at'],
        phoneVerified: json['phone_verified'],
        locationArea: json['location_area'],
        updatedAt: json['updated_at']);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'username': username,
      'email': email,
      'phone': phone,
      'photo': photo,
      'balance': balance,
      'date_of_birth': dateOfBirth,
      'governorate': governorate,
      'area': area,
      'residence_area': residenceArea,
      'specialization': specialization,
      'academic_year_id': academicYearId,
      'provider_id': providerId,
      'provider_type': providerType,
      'device_token': deviceToken,
      'is_active': isActive,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'hasVerifiedEmail': hasVerifiedEmail,
      'academic_year': academicYear != null ? academicYear!.toJson() : {},
      'image_dimensions':
          imageDimensionsModel != null ? imageDimensionsModel!.toJson() : {},
      'location_area': locationArea,
      'phone_verified': phoneVerified,
      'invitation_code': invitationCode
    };
  }
}
