// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Image_dimensions_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ImageDimensionsModelAdapter extends TypeAdapter<ImageDimensionsModel> {
  @override
  final int typeId = 6;

  @override
  ImageDimensionsModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ImageDimensionsModel(
      width: fields[0] as int?,
      height: fields[1] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, ImageDimensionsModel obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.width)
      ..writeByte(1)
      ..write(obj.height);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ImageDimensionsModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
