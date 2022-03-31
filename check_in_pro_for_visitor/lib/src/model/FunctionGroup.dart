import 'package:json_annotation/json_annotation.dart';

part 'FunctionGroup.g.dart';

@JsonSerializable()
class FunctionGroup {
  @JsonKey(name: 'functionName')
  String functionName;

  @JsonKey(name: 'permission')
  String permission;

  FunctionGroup._();

  FunctionGroup(this.functionName, this.permission);

  factory FunctionGroup.fromJson(Map<String, dynamic> json) => _$FunctionGroupFromJson(json);

  Map<String, dynamic> toJson() => _$FunctionGroupToJson(this);
}
