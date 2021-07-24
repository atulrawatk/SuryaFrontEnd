// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'isLogin.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class IsLoginAdapter extends TypeAdapter<IsLogin> {
  @override
  final int typeId = 0;

  @override
  IsLogin read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return IsLogin(
      isLogin: fields[0] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, IsLogin obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.isLogin);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is IsLoginAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
