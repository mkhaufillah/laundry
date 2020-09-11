import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:laundry/app/models/service.dart';

part 'transaction.g.dart';

@JsonSerializable(explicitToJson: true)
@HiveType(typeId: 1)
class Transaction extends HiveObject {
  @JsonKey(name: 'id')
  @HiveField(0)
  String id;

  @JsonKey(name: 'nama_pelanggan')
  @HiveField(1)
  String customerName;

  @JsonKey(name: 'nama_layanan')
  @HiveField(2)
  Service service;

  @JsonKey(name: 'kuantitas')
  @HiveField(3)
  int quantity;

  @JsonKey(name: 'tanggal_pembuatan')
  @HiveField(4)
  DateTime createdDate;

  @JsonKey(name: 'tanggal_selesai')
  @HiveField(5)
  DateTime finishedDate;

  @JsonKey(name: 'keterangan')
  @HiveField(6)
  String additionalInfo;

  Transaction({
    this.customerName,
    this.service,
    this.quantity,
    this.createdDate,
    this.finishedDate,
    this.additionalInfo,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) =>
      _$TransactionFromJson(json);

  Map<String, dynamic> toJson() => _$TransactionToJson(this);
}
