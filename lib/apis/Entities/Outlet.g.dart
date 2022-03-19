// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Outlet.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class OutletAdapter extends TypeAdapter<Outlet> {
  @override
  final int typeId = 2;

  @override
  Outlet read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Outlet(
      fields[0] as int,
      fields[1] as int,
      fields[2] as int,
      fields[3] as String,
      fields[4] as String,
      fields[5] as double,
      fields[6] as double,
      fields[7] as String,
      fields[8] as String,
      fields[9] as String,
      fields[10] as String,
      fields[11] as String,
      fields[12] as bool,
      fields[13] as bool,
    )
      ..marker = fields[14] as Marker?
      ..dis = fields[15] as double?;
  }

  @override
  void write(BinaryWriter writer, Outlet obj) {
    writer
      ..writeByte(16)
      ..writeByte(0)
      ..write(obj.outletPlanId)
      ..writeByte(1)
      ..write(obj.id)
      ..writeByte(2)
      ..write(obj.beatID)
      ..writeByte(3)
      ..write(obj.name)
      ..writeByte(4)
      ..write(obj.img)
      ..writeByte(5)
      ..write(obj.lat)
      ..writeByte(6)
      ..write(obj.lng)
      ..writeByte(7)
      ..write(obj.mobile)
      ..writeByte(8)
      ..write(obj.pan)
      ..writeByte(9)
      ..write(obj.ownerName)
      ..writeByte(10)
      ..write(obj.category)
      ..writeByte(11)
      ..write(obj.segmentation)
      ..writeByte(12)
      ..write(obj.deactivated)
      ..writeByte(13)
      ..write(obj.isDone)
      ..writeByte(14)
      ..write(obj.marker)
      ..writeByte(15)
      ..write(obj.dis);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is OutletAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
