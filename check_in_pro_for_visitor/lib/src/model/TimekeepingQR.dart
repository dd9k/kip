import 'package:json_annotation/json_annotation.dart';

part 'TimekeepingQR.g.dart';

@JsonSerializable()
class TimekeepingQR {
  @JsonKey(name: 'content')
  String content;

  @JsonKey(name: 'expiredTime')
  int expiredTime;

  TimekeepingQR(this.content, this.expiredTime);

  TimekeepingQR._();

  factory TimekeepingQR.fromJson(Map<String, dynamic> json) => _$TimekeepingQRFromJson(json);

  Map<String, dynamic> toJson() => _$TimekeepingQRToJson(this);
}
