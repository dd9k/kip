import 'package:check_in_pro_for_visitor/src/model/Document.dart';
import 'package:json_annotation/json_annotation.dart';

part 'PrinterInfor.g.dart';

@JsonSerializable()
class PrinterInfor {
  @JsonKey(name: 'actions')
  String actions;

  @JsonKey(name: 'ipAddress')
  String ipAddress;

  @JsonKey(name: 'model')
  String model;

  @JsonKey(name: 'isConnect')
  bool isConnect;

  PrinterInfor._();

  PrinterInfor(this.actions, this.ipAddress, this.model, this.isConnect);

  factory PrinterInfor.fromJson(Map<String, dynamic> json) => _$PrinterInforFromJson(json);

  Map<String, dynamic> toJson() => _$PrinterInforToJson(this);
}
