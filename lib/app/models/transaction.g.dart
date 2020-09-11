// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TransactionAdapter extends TypeAdapter<Transaction> {
  @override
  final int typeId = 1;

  @override
  Transaction read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Transaction(
      customerName: fields[1] as String,
      service: fields[2] as Service,
      quantity: fields[3] as int,
      createdDate: fields[4] as DateTime,
      finishedDate: fields[5] as DateTime,
      additionalInfo: fields[6] as String,
    )..id = fields[0] as String;
  }

  @override
  void write(BinaryWriter writer, Transaction obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.customerName)
      ..writeByte(2)
      ..write(obj.service)
      ..writeByte(3)
      ..write(obj.quantity)
      ..writeByte(4)
      ..write(obj.createdDate)
      ..writeByte(5)
      ..write(obj.finishedDate)
      ..writeByte(6)
      ..write(obj.additionalInfo);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TransactionAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Transaction _$TransactionFromJson(Map<String, dynamic> json) {
  return Transaction(
    customerName: json['nama_pelanggan'] as String,
    service: json['nama_layanan'] == null
        ? null
        : Service.fromJson(json['nama_layanan'] as Map<String, dynamic>),
    quantity: json['kuantitas'] as int,
    createdDate: json['tanggal_pembuatan'] == null
        ? null
        : DateTime.parse(json['tanggal_pembuatan'] as String),
    finishedDate: json['tanggal_selesai'] == null
        ? null
        : DateTime.parse(json['tanggal_selesai'] as String),
    additionalInfo: json['keterangan'] as String,
  )..id = json['id'] as String;
}

Map<String, dynamic> _$TransactionToJson(Transaction instance) =>
    <String, dynamic>{
      'id': instance.id,
      'nama_pelanggan': instance.customerName,
      'nama_layanan': instance.service?.toJson(),
      'kuantitas': instance.quantity,
      'tanggal_pembuatan': instance.createdDate?.toIso8601String(),
      'tanggal_selesai': instance.finishedDate?.toIso8601String(),
      'keterangan': instance.additionalInfo,
    };
