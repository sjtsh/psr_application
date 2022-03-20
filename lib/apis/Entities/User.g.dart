// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'User.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserAdapter extends TypeAdapter<User> {
  @override
  final int typeId = 8;

  @override
  User read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return User(
      fields[0] as String,
      fields[1] as DateTime,
      fields[2] as String,
      fields[3] as String,
      fields[5] as int,
      fields[4] as bool,
    )..sessionID = fields[6] as String?;
  }

  @override
  void write(BinaryWriter writer, User obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.lastLogin)
      ..writeByte(2)
      ..write(obj.name)
      ..writeByte(3)
      ..write(obj.reportingManager)
      ..writeByte(4)
      ..write(obj.deactivated)
      ..writeByte(5)
      ..write(obj.rewardPoints)
      ..writeByte(6)
      ..write(obj.sessionID);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
