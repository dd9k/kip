import 'package:json_annotation/json_annotation.dart';

part 'IDScanResult.g.dart';

@JsonSerializable()
class IDScanResult {
  @JsonKey(name: 'fullName')
  String fullName;

  @JsonKey(name: 'idCard')
  String id;

  IDScanResult._();

  IDScanResult(this.fullName, this.id);

  factory IDScanResult.fromJson(Map<String, dynamic> json) => _$IDScanResultFromJson(json);

  Map<String, dynamic> toJson() => _$IDScanResultToJson(this);
}
