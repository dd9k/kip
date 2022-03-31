// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'BaseListResponse.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BaseListResponse _$BaseListResponseFromJson(Map<String, dynamic> json) {
  return BaseListResponse(
    json['success'] as bool,
    (json['data'] as List)?.map((e) => e as Map<String, dynamic>)?.toList(),
    (json['messages'] as List)?.map((e) => e as String)?.toList(),
  );
}

Map<String, dynamic> _$BaseListResponseToJson(BaseListResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'data': instance.data,
      'messages': instance.errors,
    };
