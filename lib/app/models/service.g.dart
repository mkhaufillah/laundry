// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'service.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ServiceAdapter extends TypeAdapter<Service> {
  @override
  final int typeId = 0;

  @override
  Service read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Service(
      id: fields[0] as String,
      name: fields[1] as String,
      qty: fields[2] as int,
      completeDuration: fields[3] as int,
      unitId: fields[4] as int,
      unitName: fields[5] as String,
      price: fields[6] as int,
      isDelete: fields[7] as int,
      createAt: fields[8] as String,
      updateAt: fields[9] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Service obj) {
    writer
      ..writeByte(10)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.qty)
      ..writeByte(3)
      ..write(obj.completeDuration)
      ..writeByte(4)
      ..write(obj.unitId)
      ..writeByte(5)
      ..write(obj.unitName)
      ..writeByte(6)
      ..write(obj.price)
      ..writeByte(7)
      ..write(obj.isDelete)
      ..writeByte(8)
      ..write(obj.createAt)
      ..writeByte(9)
      ..write(obj.updateAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ServiceAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Service _$ServiceFromJson(Map<String, dynamic> json) {
  return Service(
    id: json['idlayanan'] as String,
    name: json['nama_layanan'] as String,
    qty: json['jumlah'] as int,
    completeDuration: json['durasi_penyelesaian'] as int,
    unitId: json['idsatuan'] as int,
    unitName: json['nama_satuan'] as String,
    price: json['harga'] as int,
    isDelete: json['hapus'] as int,
    createAt: json['create_at'] as String,
    updateAt: json['update_at'] as String,
  );
}

Map<String, dynamic> _$ServiceToJson(Service instance) => <String, dynamic>{
      'idlayanan': instance.id,
      'nama_layanan': instance.name,
      'jumlah': instance.qty,
      'durasi_penyelesaian': instance.completeDuration,
      'idsatuan': instance.unitId,
      'nama_satuan': instance.unitName,
      'harga': instance.price,
      'hapus': instance.isDelete,
      'create_at': instance.createAt,
      'update_at': instance.updateAt,
    };
