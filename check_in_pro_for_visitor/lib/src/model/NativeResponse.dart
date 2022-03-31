import 'package:json_annotation/json_annotation.dart';

import 'PrinterInfor.dart';

part 'NativeResponse.g.dart';

@JsonSerializable()
class NativeResponse {
  @JsonKey(name: 'status')
  String status;

  @JsonKey(name: 'data')
  List<Map<String, dynamic>> data;

  @JsonKey(name: 'model')
  String model;

  @JsonKey(name: 'errorCode')
  String errorCode;

  NativeResponse._();

  NativeResponse(this.status, this.data, this.model, this.errorCode);

  factory NativeResponse.fromJson(Map<String, dynamic> json) => _$NativeResponseFromJson(json);

  Map<String, dynamic> toJson() => _$NativeResponseToJson(this);
}
