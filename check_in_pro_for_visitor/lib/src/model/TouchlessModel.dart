import 'package:json_annotation/json_annotation.dart';

part 'TouchlessModel.g.dart';

@JsonSerializable()
class TouchlessModel {
  @JsonKey(name: 'status')
  bool status;

  @JsonKey(name: 'expiredDay')
  int expiredDay;

  @JsonKey(name: 'token')
  String token;

  @JsonKey(name: 'tokenExpiredDate')
  String tokenExpiredDate;

  @JsonKey(name: 'expiredTimestamp')
  int expiredTimestamp;

  TouchlessModel(this.status, this.expiredDay, this.token, this.tokenExpiredDate, this.expiredTimestamp);

  TouchlessModel._();

  factory TouchlessModel.fromJson(Map<String, dynamic> json) => _$TouchlessModelFromJson(json);

  Map<String, dynamic> toJson() => _$TouchlessModelToJson(this);
}
