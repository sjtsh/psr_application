// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'OutletOrderEntity.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class OutletOrderEntityAdapter extends TypeAdapter<OutletOrderEntity> {
  @override
  final int typeId = 9;

  @override
  OutletOrderEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return OutletOrderEntity(
      (fields[0] as Map).map((dynamic k, dynamic v) =>
          MapEntry(k as SubGroup, (v as Map).cast<SKU, int>())),
      fields[1] as String,
      fields[2] as int,
      fields[3] as String,
      fields[4] as String,
      (fields[5] as Map).cast<SubGroup, String>(),
      (fields[6] as Map).map((dynamic k, dynamic v) =>
          MapEntry(k as SubGroup, (v as Map).cast<String, String>())),
      (fields[7] as Map).cast<SubGroup, String>(),
    );
  }

  @override
  void write(BinaryWriter writer, OutletOrderEntity obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.singularOrder)
      ..writeByte(1)
      ..write(obj.remarks)
      ..writeByte(2)
      ..write(obj.outletPlanID)
      ..writeByte(3)
      ..write(obj.signatureImgUrl)
      ..writeByte(4)
      ..write(obj.ownerImgUrl)
      ..writeByte(5)
      ..write(obj.competitiveExistingStock)
      ..writeByte(6)
      ..write(obj.ownExistingStock)
      ..writeByte(7)
      ..write(obj.noOrderReasons);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is OutletOrderEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
