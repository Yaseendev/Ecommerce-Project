// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'name.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class NameAdapter extends TypeAdapter<Name> {
  @override
  final int typeId = 1;

  @override
  Name read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Name(
      first: fields[0] as String,
      last: fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Name obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.first)
      ..writeByte(1)
      ..write(obj.last);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NameAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
