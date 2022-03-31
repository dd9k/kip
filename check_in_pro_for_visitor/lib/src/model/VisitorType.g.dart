// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'VisitorType.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VisitorType _$VisitorTypeFromJson(Map<String, dynamic> json) {
  return VisitorType(
    json['settingKey'] as String,
    json['settingValue'] == null
        ? null
        : VisitorValue.fromJson(json['settingValue'] as Map<String, dynamic>),
    json['description'] as String,
    json['isTakePicture'] as bool,
    json['isScanIdCard'] as bool,
    json['isSurvey'] as bool,
    json['isPrintCard'] as bool,
    json['allowToDisplayContactPerson'] as bool,
  );
}

Map<String, dynamic> _$VisitorTypeToJson(VisitorType instance) =>
    <String, dynamic>{
      'settingKey': instance.settingKey,
      'settingValue': instance.settingValue,
      'description': instance.description,
      'isTakePicture': instance.isTakePicture,
      'isScanIdCard': instance.isScanIdCard,
      'isSurvey': instance.isSurvey,
      'isPrintCard': instance.isPrintCard,
      'allowToDisplayContactPerson': instance.allowToDisplayContactPerson,
    };
