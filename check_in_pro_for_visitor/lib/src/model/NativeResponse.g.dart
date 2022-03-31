// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'NativeResponse.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NativeResponse _$NativeResponseFromJson(Map<String, dynamic> json) {
  return NativeResponse(
    json['status'] as String,
    (json['data'] as List)?.map((e) => e as Map<String, dynamic>)?.toList(),
    json['model'] as String,
    json['errorCode'] as String,
  );
}

Map<String, dynamic> _$NativeResponseToJson(NativeResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'data': instance.data,
      'model': instance.model,
      'errorCode': instance.errorCode,
    };
