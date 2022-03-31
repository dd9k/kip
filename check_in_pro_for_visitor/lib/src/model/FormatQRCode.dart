import 'package:json_annotation/json_annotation.dart';

part 'FormatQRCode.g.dart';

@JsonSerializable()
class FormatQRCode {

  static const String INVITATION = "INVITATION";
  static const String EVENT = "EVENT";
  static const String EVENT_TICKET = "EVENT_TICKET";
  static const String CHECK_OUT_PHONE = "CHECK_OUT_PHONE";
  static const String CHECK_OUT_ID = "CHECK_OUT_ID";
  static const String HR = "HR";

  @JsonKey(name: 'type')
  String type;

  @JsonKey(name: 'data')
  String data;

  FormatQRCode._();

  FormatQRCode(this.type, this.data);

  factory FormatQRCode.fromJson(Map<String, dynamic> json) => _$FormatQRCodeFromJson(json);

  Map<String, dynamic> toJson() => _$FormatQRCodeToJson(this);
}
