import 'package:check_in_pro_for_visitor/src/model/TimekeepingQR.dart';
import 'package:json_annotation/json_annotation.dart';

part 'ListQRCreate.g.dart';

@JsonSerializable()
class ListQRCreate {
  @JsonKey(name: 'qrCodes')
  List<TimekeepingQR> qrCodes;

  @JsonKey(name: 'status')
  bool status;

  @JsonKey(name: 'refreshTime')
  int refreshTime;

  ListQRCreate(this.qrCodes, this.status, this.refreshTime);

  ListQRCreate._();

  factory ListQRCreate.fromJson(Map<String, dynamic> json) => _$ListQRCreateFromJson(json);

  Map<String, dynamic> toJson() => _$ListQRCreateToJson(this);
}
