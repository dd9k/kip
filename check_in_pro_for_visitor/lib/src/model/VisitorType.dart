import 'package:json_annotation/json_annotation.dart';

import 'VisitorValue.dart';

part 'VisitorType.g.dart';

@JsonSerializable()
class VisitorType {
  @JsonKey(name: 'settingKey')
  String settingKey;

  @JsonKey(name: 'settingValue')
  VisitorValue settingValue;

  @JsonKey(name: 'description')
  String description;

  @JsonKey(name: 'isTakePicture')
  bool isTakePicture;

  @JsonKey(name: 'isScanIdCard')
  bool isScanIdCard;

  @JsonKey(name: 'isSurvey')
  bool isSurvey;

  @JsonKey(name: 'isPrintCard')
  bool isPrintCard;

  @JsonKey(name: 'allowToDisplayContactPerson')
  bool allowToDisplayContactPerson;

  factory VisitorType.fromJson(Map<String, dynamic> json) => _$VisitorTypeFromJson(json);

  VisitorType(this.settingKey, this.settingValue, this.description, this.isTakePicture, this.isScanIdCard,
      this.isSurvey, this.isPrintCard, this.allowToDisplayContactPerson);

  Map<String, dynamic> toJson() => _$VisitorTypeToJson(this);

  VisitorType._();
}
