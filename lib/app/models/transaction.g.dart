// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Transaction _$TransactionFromJson(Map<String, dynamic> json) {
  return Transaction(
    transactionId: json['idtransaksi'] as String,
    customerName: json['nama_pelanggan'] as String,
    billTotal: json['total_tagihan'] as int,
    additionalInfo: json['keterangan'] as String,
    createdDate: json['tanggal_buat'] == null
        ? null
        : DateTime.parse(json['tanggal_buat'] as String),
    finishedDate: json['tanggal_selesai'] == null
        ? null
        : DateTime.parse(json['tanggal_selesai'] as String),
    services: (json['layanan'] as List)
        ?.map((e) => e == null
            ? null
            : TransactionService.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$TransactionToJson(Transaction instance) =>
    <String, dynamic>{
      'idtransaksi': instance.transactionId,
      'nama_pelanggan': instance.customerName,
      'total_tagihan': instance.billTotal,
      'keterangan': instance.additionalInfo,
      'tanggal_buat': instance.createdDate?.toIso8601String(),
      'tanggal_selesai': instance.finishedDate?.toIso8601String(),
      'layanan': instance.services?.map((e) => e?.toJson())?.toList(),
    };
