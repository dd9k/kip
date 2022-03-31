// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'CheckInFlow.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CheckInFlow _$CheckInFlowFromJson(Map<String, dynamic> json) {
  return CheckInFlow(
    (json['id'] as num)?.toDouble(),
    json['templateCode'] as String,
    json['templateName'] as String,
    json['stepName'] as String,
    json['stepCode'] as String,
    json['stepType'] as String,
    json['visitorType'] as String,
    json['isRequired'] as int,
    json['sort'] as String,
  );
}

Map<String, dynamic> _$CheckInFlowToJson(CheckInFlow instance) =>
    <String, dynamic>{
      'id': instance.id,
      'templateCode': instance.templateCode,
      'templateName': instance.templateName,
      'stepName': instance.stepName,
      'stepCode': instance.stepCode,
      'stepType': instance.stepType,
      'visitorType': instance.visitorType,
      'isRequired': instance.isRequired,
      'sort': instance.sort,
    };
