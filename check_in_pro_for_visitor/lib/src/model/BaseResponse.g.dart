// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'BaseResponse.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BaseResponse _$BaseResponseFromJson(Map<String, dynamic> json) {
  return BaseResponse(
    json['success'] as bool,
    json['data'] as Map<String, dynamic>,
    (json['messages'] as List)?.map((e) => e as String)?.toList(),
    json['typeCard'] as String,
  );
}

Map<String, dynamic> _$BaseResponseToJson(BaseResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'data': instance.data,
      'messages': instance.errors,
      'typeCard': instance.typeCard,
    };
