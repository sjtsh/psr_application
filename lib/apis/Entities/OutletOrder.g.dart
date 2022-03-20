// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'OutletOrder.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class OutletOrderAdapter extends TypeAdapter<OutletOrder> {
  @override
  final int typeId = 3;

  @override
  OutletOrder read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return OutletOrder(
      fields[0] as int,
      fields[1] as int,
      fields[2] as DateTime,
      fields[3] as String,
      fields[5] as String,
      fields[6] as String,
      fields[7] as int,
      (fields[8] as List).cast<OutletOrderItem>(),
      deactivated: fields[4] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, OutletOrder obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.outletPlanID)
      ..writeByte(2)
      ..write(obj.timeCreated)
      ..writeByte(3)
      ..write(obj.remarks)
      ..writeByte(4)
      ..write(obj.deactivated)
      ..writeByte(5)
      ..write(obj.beatName)
      ..writeByte(6)
      ..write(obj.outletName)
      ..writeByte(7)
      ..write(obj.outletID)
      ..writeByte(8)
      ..write(obj.items);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is OutletOrderAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
