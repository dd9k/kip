// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Configuration.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Configuration _$ConfigurationFromJson(Map<String, dynamic> json) {
  return Configuration(
    (json['id'] as num)?.toDouble(),
    json['code'] as String,
    (json['value'] as List)?.map((e) => e as String)?.toList(),
  );
}

Map<String, dynamic> _$ConfigurationToJson(Configuration instance) =>
    <String, dynamic>{
      'id': instance.id,
      'code': instance.code,
      'value': instance.value,
    };
