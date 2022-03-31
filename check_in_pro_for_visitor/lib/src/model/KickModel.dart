import 'package:json_annotation/json_annotation.dart';

part 'KickModel.g.dart';

@JsonSerializable()
class KickModel {
  @JsonKey(name: 'title')
  String title;

  @JsonKey(name: 'content')
  String content;

  KickModel._();

  KickModel(this.title, this.content);

  factory KickModel.fromJson(Map<String, dynamic> json) => _$KickModelFromJson(json);

  Map<String, dynamic> toJson() => _$KickModelToJson(this);
}
