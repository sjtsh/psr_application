// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'HiveBox.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HiveBoxAdapter extends TypeAdapter<HiveBox> {
  @override
  final int typeId = 0;

  @override
  HiveBox read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HiveBox(
      performances: (fields[0] as List).cast<Performance>(),
      outletOrders: (fields[1] as List).cast<OutletOrder>(),
      outlets: (fields[2] as List).cast<Outlet>(),
      subgroups: (fields[3] as List).cast<SubGroup>(),
      beats: (fields[4] as List).cast<HollowBeat>(),
      user: fields[5] as User,
    );
  }

  @override
  void write(BinaryWriter writer, HiveBox obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.performances)
      ..writeByte(1)
      ..write(obj.outletOrders)
      ..writeByte(2)
      ..write(obj.outlets)
      ..writeByte(3)
      ..write(obj.subgroups)
      ..writeByte(4)
      ..write(obj.beats)
      ..writeByte(5)
      ..write(obj.user);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HiveBoxAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
