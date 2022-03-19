// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'SKU.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SKUAdapter extends TypeAdapter<SKU> {
  @override
  final int typeId = 6;

  @override
  SKU read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SKU(
      fields[0] as int,
      fields[1] as String,
      fields[2] as double,
      fields[3] as double,
      fields[4] as String,
      fields[5] as String,
      fields[6] as String,
      fields[7] as int,
      fields[8] as bool,
      fields[9] as bool,
      fields[10] as bool,
      fields[11] as int,
      fields[12] as String,
    );
  }

  @override
  void write(BinaryWriter writer, SKU obj) {
    writer
      ..writeByte(13)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.mrp)
      ..writeByte(3)
      ..write(obj.ptr)
      ..writeByte(4)
      ..write(obj.img)
      ..writeByte(5)
      ..write(obj.primaryUnit)
      ..writeByte(6)
      ..write(obj.secondaryUnit)
      ..writeByte(7)
      ..write(obj.cf)
      ..writeByte(8)
      ..write(obj.isTrending)
      ..writeByte(9)
      ..write(obj.isPromoted)
      ..writeByte(10)
      ..write(obj.isNew)
      ..writeByte(11)
      ..write(obj.reward)
      ..writeByte(12)
      ..write(obj.erpID);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SKUAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
