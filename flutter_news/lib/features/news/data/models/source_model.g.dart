// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'source_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SourceModelAdapter extends TypeAdapter<SourceModel> {
  @override
  final int typeId = 1;

  @override
  SourceModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SourceModel(
      name: fields[0] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, SourceModel obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.name);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SourceModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
