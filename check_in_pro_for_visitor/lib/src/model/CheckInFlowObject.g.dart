// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'CheckInFlowObject.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CheckInFlowObject _$CheckInFlowObjectFromJson(Map<String, dynamic> json) {
  return CheckInFlowObject(
    (json['flow'] as List)
        ?.map((e) =>
            e == null ? null : CheckInFlow.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    json['settingKey'] as String,
  );
}

Map<String, dynamic> _$CheckInFlowObjectToJson(CheckInFlowObject instance) =>
    <String, dynamic>{
      'flow': instance.flow,
      'settingKey': instance.settingKey,
    };
