class SocialLoginModel {
  String? name;
  String? username;
  String? dateOfBirth;
  String? governorate;
  String? area;
  String? residenceArea;
  String? specialization;
  int? academicYearId;
  String? providerId;
  String? providerType;
  String? deviceToken;
  String? locationArea;
  String? phone;
  String? email;
  String? inviteCode;

  SocialLoginModel({
    this.name,
    this.inviteCode,
    this.locationArea,
    this.username,
    this.phone,
    this.email,
    this.dateOfBirth,
    this.governorate,
    this.area,
    this.residenceArea,
    this.specialization,
    this.academicYearId,
    this.providerId,
    this.providerType,
    this.deviceToken,
  });
}
