// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserModelAdapter extends TypeAdapter<UserModel> {
  @override
  final int typeId = 1;

  @override
  UserModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserModel()
      ..id = fields[0] as String?
      ..fname = fields[1] as String?
      ..type = fields[2] as String?
      ..email = fields[3] as String?
      ..dob = fields[4] as String?
      ..phone = fields[5] as String?
      ..postalCode = fields[6] as String?
      ..ville = fields[7] as String?
      ..presentation = fields[8] as String?
      ..lname = fields[9] as String?;
  }

  @override
  void write(BinaryWriter writer, UserModel obj) {
    writer
      ..writeByte(10)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.fname)
      ..writeByte(2)
      ..write(obj.type)
      ..writeByte(3)
      ..write(obj.email)
      ..writeByte(4)
      ..write(obj.dob)
      ..writeByte(5)
      ..write(obj.phone)
      ..writeByte(6)
      ..write(obj.postalCode)
      ..writeByte(7)
      ..write(obj.ville)
      ..writeByte(8)
      ..write(obj.presentation)
      ..writeByte(9)
      ..write(obj.lname);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
