import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'transaction_service.g.dart';

@JsonSerializable(explicitToJson: true)
class TransactionService {
  @JsonKey(name: 'idtransaksi')
  String transactionId;

  @JsonKey(name: 'idlayanan')
  String serviceId;

  @JsonKey(name: 'nama_layanan')
  String serviceName;

  @JsonKey(name: 'jumlah_pembelian')
  int buyQty;

  @JsonKey(name: 'harga_layanan')
  int servicePrice;

  @JsonKey(name: 'harga_total')
  int priceTotal;

  @JsonKey(ignore: true)
  int completeDuration;

  @JsonKey(ignore: true)
  String unitName;

  TransactionService({
    @required this.transactionId,
    @required this.serviceId,
    @required this.serviceName,
    @required this.buyQty,
    @required this.servicePrice,
    @required this.priceTotal,
    this.completeDuration,
    this.unitName,
  });

  factory TransactionService.fromJson(Map<String, dynamic> json) =>
      _$TransactionServiceFromJson(json);

  Map<String, dynamic> toJson() => _$TransactionServiceToJson(this);
}
