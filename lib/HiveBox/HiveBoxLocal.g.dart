// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'HiveBoxLocal.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HiveBoxLocalAdapter extends TypeAdapter<HiveBoxLocal> {
  @override
  final int typeId = 12;

  @override
  HiveBoxLocal read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HiveBoxLocal(
      outletOrders: (fields[1] as List).cast<OutletOrderEntity>(),
      outletCloseds: (fields[0] as List).cast<OutletClosedEntity>(),
      uploadFiles: (fields[2] as List).cast<UploadFileEntity>(),
    );
  }

  @override
  void write(BinaryWriter writer, HiveBoxLocal obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.outletCloseds)
      ..writeByte(1)
      ..write(obj.outletOrders)
      ..writeByte(2)
      ..write(obj.uploadFiles);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HiveBoxLocalAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
