// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction_service.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TransactionService _$TransactionServiceFromJson(Map<String, dynamic> json) {
  return TransactionService(
    transactionId: json['idtransaksi'] as String,
    serviceId: json['idlayanan'] as String,
    serviceName: json['nama_layanan'] as String,
    buyQty: json['jumlah_pembelian'] as int,
    servicePrice: json['harga_layanan'] as int,
    priceTotal: json['harga_total'] as int,
  );
}

Map<String, dynamic> _$TransactionServiceToJson(TransactionService instance) =>
    <String, dynamic>{
      'idtransaksi': instance.transactionId,
      'idlayanan': instance.serviceId,
      'nama_layanan': instance.serviceName,
      'jumlah_pembelian': instance.buyQty,
      'harga_layanan': instance.servicePrice,
      'harga_total': instance.priceTotal,
    };
