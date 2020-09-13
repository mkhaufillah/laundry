import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'service.g.dart';

@JsonSerializable(explicitToJson: true)
class Service {
  @JsonKey(name: 'idlayanan')
  String serviceId;

  @JsonKey(name: 'nama_layanan')
  String serviceName;

  @JsonKey(name: 'jumlah')
  int qty;

  @JsonKey(name: 'durasi_penyelesaian')
  int completeDuration;

  @JsonKey(name: 'idsatuan')
  int unitId;

  @JsonKey(name: 'nama_satuan')
  String unitName;

  @JsonKey(name: 'harga')
  int price;

  @JsonKey(name: 'hapus')
  int isDelete;

  @JsonKey(name: 'created_at')
  DateTime createdAt;

  @JsonKey(name: 'updated_at')
  DateTime updatedAt;

  Service({
    @required this.serviceId,
    @required this.serviceName,
    @required this.qty,
    @required this.completeDuration,
    @required this.unitId,
    @required this.unitName,
    @required this.price,
    @required this.isDelete,
    @required this.createdAt,
    @required this.updatedAt,
  });

  factory Service.fromJson(Map<String, dynamic> json) =>
      _$ServiceFromJson(json);

  Map<String, dynamic> toJson() => _$ServiceToJson(this);
}
