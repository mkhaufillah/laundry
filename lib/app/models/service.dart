import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'service.g.dart';

@JsonSerializable(explicitToJson: true)
@HiveType(typeId: 0)
class Service {
  @JsonKey(name: 'idlayanan')
  @HiveField(0)
  String id;

  @JsonKey(name: 'nama_layanan')
  @HiveField(1)
  String name;

  @JsonKey(name: 'jumlah')
  @HiveField(2)
  int qty;

  @JsonKey(name: 'durasi_penyelesaian')
  @HiveField(3)
  int completeDuration;

  @JsonKey(name: 'idsatuan')
  @HiveField(4)
  int unitId;

  @JsonKey(name: 'nama_satuan')
  @HiveField(5)
  String unitName;

  @JsonKey(name: 'harga')
  @HiveField(6)
  int price;

  @JsonKey(name: 'hapus')
  @HiveField(7)
  int isDelete;

  @JsonKey(name: 'create_at')
  @HiveField(8)
  String createAt;

  @JsonKey(name: 'update_at')
  @HiveField(9)
  String updateAt;

  bool isSearched;

  Service({
    this.id,
    this.name,
    this.qty,
    this.completeDuration,
    this.unitId,
    this.unitName,
    this.price,
    this.isDelete,
    this.createAt,
    this.updateAt,
  });

  factory Service.fromJson(Map<String, dynamic> json) =>
      _$ServiceFromJson(json);

  Map<String, dynamic> toJson() => _$ServiceToJson(this);
}
