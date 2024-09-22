// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'income_expanse_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class IncomeModelAdapter extends TypeAdapter<IncomeModel> {
  @override
  final int typeId = 2;

  @override
  IncomeModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return IncomeModel(
      amount: fields[0] as double,
      title: fields[1] as String,
      description: fields[2] as String,
      createdAt: fields[3] as DateTime,
      id: fields[4] as String,
      currentUserId: fields[5] as String,
    );
  }

  @override
  void write(BinaryWriter writer, IncomeModel obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.amount)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.description)
      ..writeByte(3)
      ..write(obj.createdAt)
      ..writeByte(4)
      ..write(obj.id)
      ..writeByte(5)
      ..write(obj.currentUserId);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is IncomeModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
