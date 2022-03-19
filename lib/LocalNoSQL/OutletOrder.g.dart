// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'OutletOrder.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class OutletOrderLocalAdapter extends TypeAdapter<OutletOrderLocal> {
  @override
  final int typeId = 1;

  @override
  OutletOrderLocal read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return OutletOrderLocal(
      fields[0] as int,
      fields[1] as DateTime,
      fields[2] as String,
      fields[3] as String,
      fields[4] as String,
      fields[5] as int,
      (fields[6] as List).cast<OutletOrderItem>(),
    );
  }

  @override
  void write(BinaryWriter writer, OutletOrderLocal obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.outletPlanID)
      ..writeByte(1)
      ..write(obj.timeCreated)
      ..writeByte(2)
      ..write(obj.remarks)
      ..writeByte(3)
      ..write(obj.beatName)
      ..writeByte(4)
      ..write(obj.outletName)
      ..writeByte(5)
      ..write(obj.outletID)
      ..writeByte(6)
      ..write(obj.items);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is OutletOrderLocalAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
