// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data_subject_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DataSubjectModelAdapter extends TypeAdapter<DataSubjectModel> {
  @override
  final int typeId = 4;

  @override
  DataSubjectModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DataSubjectModel(
      id: fields[0] as int?,
      name: fields[1] as String?,
      photo: fields[2] as String?,
      imageDimensions: fields[9] as ImageDimensionsModel?,
      academicYearId: fields[4] as int?,
      academicYear: fields[5] as AcademicYearModel?,
      isActive: fields[6] as bool?,
      books: (fields[3] as List?)?.cast<BookModel>(),
      createdAt: fields[7] as String?,
      updatedAt: fields[8] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, DataSubjectModel obj) {
    writer
      ..writeByte(10)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.photo)
      ..writeByte(3)
      ..write(obj.books)
      ..writeByte(4)
      ..write(obj.academicYearId)
      ..writeByte(5)
      ..write(obj.academicYear)
      ..writeByte(6)
      ..write(obj.isActive)
      ..writeByte(7)
      ..write(obj.createdAt)
      ..writeByte(8)
      ..write(obj.updatedAt)
      ..writeByte(9)
      ..write(obj.imageDimensions);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DataSubjectModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
