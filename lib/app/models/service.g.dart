// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'service.dart';

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
