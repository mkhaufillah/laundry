import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:laundry/app/models/transaction_service.dart';

part 'transaction.g.dart';

@JsonSerializable(explicitToJson: true)
class Transaction {
  @JsonKey(name: 'idtransaksi')
  String transactionId;

  @JsonKey(name: 'nama_pelanggan')
  String customerName;

  @JsonKey(name: 'total_tagihan')
  int billTotal;

  @JsonKey(name: 'keterangan')
  String additionalInfo;

  @JsonKey(name: 'tanggal_buat')
  DateTime createdDate;

  @JsonKey(name: 'tanggal_selesai')
  DateTime finishedDate;

  @JsonKey(name: 'layanan')
  List<TransactionService> services;

  Transaction({
    @required this.transactionId,
    @required this.customerName,
    @required this.billTotal,
    @required this.additionalInfo,
    @required this.createdDate,
    @required this.finishedDate,
    @required this.services,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) =>
      _$TransactionFromJson(json);

  Map<String, dynamic> toJson() => _$TransactionToJson(this);
}
