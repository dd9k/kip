// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ListCheckInFlow.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ListCheckInFlow _$ListCheckInFlowFromJson(Map<String, dynamic> json) {
  return ListCheckInFlow(
    (json['flows'] as List)
        ?.map((e) => e == null
            ? null
            : CheckInFlowObject.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    json['badgeTemplateCode'] as String,
  );
}

Map<String, dynamic> _$ListCheckInFlowToJson(ListCheckInFlow instance) =>
    <String, dynamic>{
      'flows': instance.flows,
      'badgeTemplateCode': instance.badgeTemplateCode,
    };
