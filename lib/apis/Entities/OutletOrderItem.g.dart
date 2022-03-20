// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'OutletOrderItem.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class OutletOrderItemAdapter extends TypeAdapter<OutletOrderItem> {
  @override
  final int typeId = 4;

  @override
  OutletOrderItem read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return OutletOrderItem(
      fields[0] as int,
      fields[1] as int,
      fields[2] as String,
      fields[3] as int,
      fields[4] as String,
      fields[5] as String,
      fields[6] as int,
      fields[7] as double,
      fields[8] as double,
      deactivated: fields[9] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, OutletOrderItem obj) {
    writer
      ..writeByte(10)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.skuID)
      ..writeByte(2)
      ..write(obj.skuName)
      ..writeByte(3)
      ..write(obj.primaryCount)
      ..writeByte(4)
      ..write(obj.primaryUnit)
      ..writeByte(5)
      ..write(obj.secondaryUnit)
      ..writeByte(6)
      ..write(obj.cf)
      ..writeByte(7)
      ..write(obj.ptr)
      ..writeByte(8)
      ..write(obj.mrp)
      ..writeByte(9)
      ..write(obj.deactivated);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is OutletOrderItemAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
