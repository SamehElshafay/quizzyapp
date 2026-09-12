// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settings_data_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SettingsDataAdapter extends TypeAdapter<SettingsData> {
  @override
  final int typeId = 10;

  @override
  SettingsData read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SettingsData(
      logo: fields[0] as String?,
      fcmKey: fields[1] as String?,
      applicationName: fields[2] as String?,
      version: fields[3] as String?,
      terms: fields[4] as String?,
      privacyPolicy: fields[5] as String?,
      balanceDefault: fields[6] as String?,
      baseUrlApi: fields[7] as String?,
      isTeacher: fields[8] as String?,
      showBalance: fields[9] as String?,
      inputInvitationCodeMsg: fields[13] as String?,
      invitationShareMsg: fields[12] as String?,
      inviteeGift: fields[11] as String?,
      inviterGift: fields[10] as String?,
      showDeleteAccount: fields[15] as String?,
      showLoginThirdParty: fields[14] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, SettingsData obj) {
    writer
      ..writeByte(16)
      ..writeByte(0)
      ..write(obj.logo)
      ..writeByte(1)
      ..write(obj.fcmKey)
      ..writeByte(2)
      ..write(obj.applicationName)
      ..writeByte(3)
      ..write(obj.version)
      ..writeByte(4)
      ..write(obj.terms)
      ..writeByte(5)
      ..write(obj.privacyPolicy)
      ..writeByte(6)
      ..write(obj.balanceDefault)
      ..writeByte(7)
      ..write(obj.baseUrlApi)
      ..writeByte(8)
      ..write(obj.isTeacher)
      ..writeByte(9)
      ..write(obj.showBalance)
      ..writeByte(10)
      ..write(obj.inviterGift)
      ..writeByte(11)
      ..write(obj.inviteeGift)
      ..writeByte(12)
      ..write(obj.invitationShareMsg)
      ..writeByte(13)
      ..write(obj.inputInvitationCodeMsg)
      ..writeByte(14)
      ..write(obj.showLoginThirdParty)
      ..writeByte(15)
      ..write(obj.showDeleteAccount);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SettingsDataAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
