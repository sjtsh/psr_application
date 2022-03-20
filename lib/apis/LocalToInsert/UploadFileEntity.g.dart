// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'UploadFileEntity.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UploadFileEntityAdapter extends TypeAdapter<UploadFileEntity> {
  @override
  final int typeId = 10;

  @override
  UploadFileEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UploadFileEntity(
      fields[0] as String,
      fields[1] as String,
      fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, UploadFileEntity obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.filePath)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.userID);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UploadFileEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
