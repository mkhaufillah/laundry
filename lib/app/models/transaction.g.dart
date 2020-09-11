// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction.dart';

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
