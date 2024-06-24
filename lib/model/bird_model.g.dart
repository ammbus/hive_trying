

part of 'bird_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BirdModelAdapter extends TypeAdapter<BirdModel> {
  @override
  final int typeId = 0;

  @override
  BirdModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return BirdModel(
      name: fields[0] as String,
      family: fields[1] as String,
      image: fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, BirdModel obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.family)
      ..writeByte(2)
      ..write(obj.image);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BirdModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
