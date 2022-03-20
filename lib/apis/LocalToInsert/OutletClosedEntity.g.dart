// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'OutletClosedEntity.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class OutletClosedEntityAdapter extends TypeAdapter<OutletClosedEntity> {
  @override
  final int typeId = 11;

  @override
  OutletClosedEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return OutletClosedEntity(
      fields[0] as String,
      fields[1] as String,
      fields[2] as String,
      fields[3] as String,
      fields[4] as int,
      fields[5] as String,
    );
  }

  @override
  void write(BinaryWriter writer, OutletClosedEntity obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.filePath)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.userID)
      ..writeByte(3)
      ..write(obj.remarks)
      ..writeByte(4)
      ..write(obj.outletPlanID)
      ..writeByte(5)
      ..write(obj.timeCreated);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is OutletClosedEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
