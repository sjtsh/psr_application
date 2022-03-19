// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'SubGroup.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SubGroupAdapter extends TypeAdapter<SubGroup> {
  @override
  final int typeId = 7;

  @override
  SubGroup read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SubGroup(
      fields[0] as String,
      fields[1] as String,
      (fields[2] as List).cast<SKU>(),
    );
  }

  @override
  void write(BinaryWriter writer, SubGroup obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.productName)
      ..writeByte(2)
      ..write(obj.skus);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SubGroupAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
