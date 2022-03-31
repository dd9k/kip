import 'package:json_annotation/json_annotation.dart';

part 'SaverModel.g.dart';

@JsonSerializable()
class SaverModel {
  @JsonKey(name: 'status')
  bool status;

  @JsonKey(name: 'timeout')
  int timeout;

  @JsonKey(name: 'images')
  List<String> images = List();

  SaverModel(this.status, this.timeout, this.images);

  SaverModel._();

  factory SaverModel.fromJson(Map<String, dynamic> json) => _$SaverModelFromJson(json);

  Map<String, dynamic> toJson() => _$SaverModelToJson(this);
}