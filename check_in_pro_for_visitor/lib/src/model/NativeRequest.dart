import 'package:json_annotation/json_annotation.dart';

part 'NativeRequest.g.dart';

@JsonSerializable()
class NativeRequest {
  @JsonKey(name: 'actions')
  String actions;

  @JsonKey(name: 'data')
  Map<String, dynamic> data;

  NativeRequest(this.actions, this.data);

  NativeRequest._();

  factory NativeRequest.fromJson(Map<String, dynamic> json) => _$NativeRequestFromJson(json);

  Map<String, dynamic> toJson() => _$NativeRequestToJson(this);
}
