// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'subjects_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SubjectsModelAdapter extends TypeAdapter<SubjectsModel> {
  @override
  final int typeId = 3;

  @override
  SubjectsModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SubjectsModel(
      success: fields[0] as bool?,
      data: (fields[1] as List?)?.cast<DataSubjectModel>(),
      message: fields[2] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, SubjectsModel obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.success)
      ..writeByte(1)
      ..write(obj.data)
      ..writeByte(2)
      ..write(obj.message);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SubjectsModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
