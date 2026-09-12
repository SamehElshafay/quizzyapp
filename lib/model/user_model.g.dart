// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserAdapter extends TypeAdapter<User> {
  @override
  final int typeId = 1;

  @override
  User read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return User(
      id: fields[0] as int?,
      name: fields[1] as String?,
      username: fields[2] as String?,
      email: fields[3] as String?,
      phone: fields[4] as String?,
      photo: fields[5] as String?,
      locationArea: fields[21] as String?,
      hasVerifiedEmail: fields[19] as bool?,
      dateOfBirth: fields[6] as String?,
      governorate: fields[7] as String?,
      area: fields[8] as String?,
      balance: fields[22] as int?,
      imageDimensionsModel: fields[23] as ImageDimensionsModel?,
      residenceArea: fields[9] as String?,
      specialization: fields[10] as String?,
      academicYearId: fields[11] as int?,
      providerId: fields[12] as String?,
      providerType: fields[13] as String?,
      deviceToken: fields[14] as String?,
      academicYear: fields[15] as AcademicYearModel?,
      isActive: fields[16] as bool?,
      phoneVerified: fields[20] as bool?,
      createdAt: fields[17] as String?,
      updatedAt: fields[18] as String?,
      invitationCode: fields[24] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, User obj) {
    writer
      ..writeByte(25)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.username)
      ..writeByte(3)
      ..write(obj.email)
      ..writeByte(4)
      ..write(obj.phone)
      ..writeByte(5)
      ..write(obj.photo)
      ..writeByte(6)
      ..write(obj.dateOfBirth)
      ..writeByte(7)
      ..write(obj.governorate)
      ..writeByte(8)
      ..write(obj.area)
      ..writeByte(9)
      ..write(obj.residenceArea)
      ..writeByte(10)
      ..write(obj.specialization)
      ..writeByte(11)
      ..write(obj.academicYearId)
      ..writeByte(12)
      ..write(obj.providerId)
      ..writeByte(13)
      ..write(obj.providerType)
      ..writeByte(14)
      ..write(obj.deviceToken)
      ..writeByte(15)
      ..write(obj.academicYear)
      ..writeByte(16)
      ..write(obj.isActive)
      ..writeByte(17)
      ..write(obj.createdAt)
      ..writeByte(18)
      ..write(obj.updatedAt)
      ..writeByte(19)
      ..write(obj.hasVerifiedEmail)
      ..writeByte(20)
      ..write(obj.phoneVerified)
      ..writeByte(21)
      ..write(obj.locationArea)
      ..writeByte(22)
      ..write(obj.balance)
      ..writeByte(23)
      ..write(obj.imageDimensionsModel)
      ..writeByte(24)
      ..write(obj.invitationCode);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
