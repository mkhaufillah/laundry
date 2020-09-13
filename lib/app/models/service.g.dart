// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'service.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Service _$ServiceFromJson(Map<String, dynamic> json) {
  return Service(
    serviceId: json['idlayanan'] as String,
    serviceName: json['nama_layanan'] as String,
    qty: json['jumlah'] as int,
    completeDuration: json['durasi_penyelesaian'] as int,
    unitId: json['idsatuan'] as int,
    unitName: json['nama_satuan'] as String,
    price: json['harga'] as int,
    isDelete: json['hapus'] as int,
    createdAt: json['created_at'] == null
        ? null
        : DateTime.parse(json['created_at'] as String),
    updatedAt: json['updated_at'] == null
        ? null
        : DateTime.parse(json['updated_at'] as String),
  );
}

Map<String, dynamic> _$ServiceToJson(Service instance) => <String, dynamic>{
      'idlayanan': instance.serviceId,
      'nama_layanan': instance.serviceName,
      'jumlah': instance.qty,
      'durasi_penyelesaian': instance.completeDuration,
      'idsatuan': instance.unitId,
      'nama_satuan': instance.unitName,
      'harga': instance.price,
      'hapus': instance.isDelete,
      'created_at': instance.createdAt?.toIso8601String(),
      'updated_at': instance.updatedAt?.toIso8601String(),
    };
