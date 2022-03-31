// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ConfigKiosk.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ConfigKiosk _$ConfigKioskFromJson(Map<String, dynamic> json) {
  return ConfigKiosk(
    (json['visitorType'] as List)
        ?.map((e) =>
            e == null ? null : VisitorType.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    json['visitorTypeLang'] as String,
    json['isTakePicture'] as bool,
    json['picCountdownInterval'] as int,
    json['isScanIdCard'] as bool,
    json['isPrintCard'] as bool,
    json['isSurvey'] as bool,
    json['ratingType'] as String,
    json['allowToDisplayContactPerson'] as bool,
    json['touchless'] == null
        ? null
        : TouchlessModel.fromJson(json['touchless'] as Map<String, dynamic>),
    json['waiting'] == null
        ? null
        : SaverModel.fromJson(json['waiting'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$ConfigKioskToJson(ConfigKiosk instance) =>
    <String, dynamic>{
      'visitorType': instance.visitorType,
      'visitorTypeLang': instance.visitorTypeLang,
      'isTakePicture': instance.isTakePicture,
      'picCountdownInterval': instance.picCountdownInterval,
      'isScanIdCard': instance.isScanIdCard,
      'isPrintCard': instance.isPrintCard,
      'isSurvey': instance.isSurvey,
      'ratingType': instance.ratingType,
      'allowToDisplayContactPerson': instance.allowToDisplayContactPerson,
      'touchless': instance.touchlessModel,
      'waiting': instance.saverModel,
    };
