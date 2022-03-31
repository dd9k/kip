import 'package:json_annotation/json_annotation.dart';

part 'CovidModel.g.dart';

@JsonSerializable()
class CovidModel {
  @JsonKey(name: 'status')
  int status;

  @JsonKey(name: 'title')
  String title;

  @JsonKey(name: 'titleColor')
  String titleColor;

  @JsonKey(name: 'description')
  String description;

  @JsonKey(name: 'url')
  String url;

  CovidModel._();

  CovidModel(this.status, this.title, this.titleColor, this.description, this.url);

  factory CovidModel.fromJson(Map<String, dynamic> json) => _$CovidModelFromJson(json);

  Map<String, dynamic> toJson() => _$CovidModelToJson(this);
}
