// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'academic_year_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AcademicYearModelAdapter extends TypeAdapter<AcademicYearModel> {
  @override
  final int typeId = 2;

  @override
  AcademicYearModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AcademicYearModel(
      id: fields[0] as int?,
      name: fields[1] as String?,
      photo: fields[2] as String?,
      isActive: fields[3] as bool?,
      createdAt: fields[4] as String?,
      updatedAt: fields[5] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, AcademicYearModel obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.photo)
      ..writeByte(3)
      ..write(obj.isActive)
      ..writeByte(4)
      ..write(obj.createdAt)
      ..writeByte(5)
      ..write(obj.updatedAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AcademicYearModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
