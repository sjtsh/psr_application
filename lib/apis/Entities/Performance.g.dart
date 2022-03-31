// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Performance.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PerformanceAdapter extends TypeAdapter<Performance> {
  @override
  final int typeId = 5;

  @override
  Performance read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Performance(
      scheduleVisit: fields[0] as int,
      successVisit: fields[1] as int,
      productiveVisit: fields[2] as int,
      stdQuantitySales: fields[3] as int,
      netValueSales: fields[4] as double,
      rewardPoints: fields[5] as int,
      avgSKU: (fields[6] as List).toSet().cast<int>(),
    );
  }

  @override
  void write(BinaryWriter writer, Performance obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.scheduleVisit)
      ..writeByte(1)
      ..write(obj.successVisit)
      ..writeByte(2)
      ..write(obj.productiveVisit)
      ..writeByte(3)
      ..write(obj.stdQuantitySales)
      ..writeByte(4)
      ..write(obj.netValueSales)
      ..writeByte(5)
      ..write(obj.rewardPoints)
      ..writeByte(6)
      ..write(obj.avgSKU.toList());
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PerformanceAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
