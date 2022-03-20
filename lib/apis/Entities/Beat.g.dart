// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Beat.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HollowBeatAdapter extends TypeAdapter<HollowBeat> {
  @override
  final int typeId = 1;

  @override
  HollowBeat read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HollowBeat(
      fields[0] as int,
      fields[1] as int,
      fields[2] as bool,
      fields[3] as bool,
      fields[4] as String,
      fields[5] as String,
      fields[6] as String,
      fields[7] as double,
      fields[8] as double,
    );
  }

  @override
  void write(BinaryWriter writer, HollowBeat obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.beatPlanID)
      ..writeByte(1)
      ..write(obj.beatID)
      ..writeByte(2)
      ..write(obj.isDone)
      ..writeByte(3)
      ..write(obj.inProgress)
      ..writeByte(4)
      ..write(obj.beatName)
      ..writeByte(5)
      ..write(obj.distributorID)
      ..writeByte(6)
      ..write(obj.distributorName)
      ..writeByte(7)
      ..write(obj.distributorLat)
      ..writeByte(8)
      ..write(obj.distributorLng);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HollowBeatAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
