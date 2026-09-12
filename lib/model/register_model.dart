import 'package:flutter/material.dart';

class RegisterModel {
  String? name;
  String? username;
  String? email;
  String? phone;
  String? photo;
  String? dateOfBirth;
  String? governorate;
  String? area;
  String? residenceArea;
  String? specialization;
  int? academicYearId;
  String? providerId;
  String? providerType;
  String? deviceToken;
  String? password;
  String? locationArea;
  String? inviteCode;

  set setPassword(password) => this.password = password;
  RegisterModel(
      {this.name,
      this.username,
      this.inviteCode,
      this.locationArea,
      this.email,
      this.phone,
      this.photo,
      this.dateOfBirth,
      this.governorate,
      this.area,
      this.residenceArea,
      this.specialization,
      this.academicYearId,
      this.providerId,
      this.providerType,
      this.deviceToken,
      this.password});

  @override
  String toString() {
    return "providerId:$providerId \n password:$password \n providerType:$providerType \n deviceToken:$deviceToken \n  residenceArea:$residenceArea \n specialization:$specialization \n academicYearId:$academicYearId \n   name:$name \n username:$username  \n email:$email   \n phone:$phone  \n photo:$photo  \n dateOfBirth:$dateOfBirth  \n governorate:$governorate  \n area:$area";
  }

  void printModel() {
    debugPrint(
        "providerId:$providerId \n password:$password \n providerType:$providerType \n deviceToken:$deviceToken \n  residenceArea:$residenceArea \n specialization:$specialization \n academicYearId:$academicYearId \n   name:$name \n username:$username  \n email:$email   \n phone:$phone  \n photo:$photo  \n dateOfBirth:$dateOfBirth  \n governorate:$governorate  \n area:$area");
  }
}
