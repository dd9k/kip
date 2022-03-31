import 'package:json_annotation/json_annotation.dart';

part 'LangModel.g.dart';

@JsonSerializable()
class LangModel {
  @JsonKey(name: 'vi')
  String vi;

  @JsonKey(name: 'en')
  String en;

  LangModel._();

  LangModel(String vi, String en);

  factory LangModel.fromJson(Map<String, dynamic> json) => _$LangModelFromJson(json);
}
