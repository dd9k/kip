// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'NativeRequest.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NativeRequest _$NativeRequestFromJson(Map<String, dynamic> json) {
  return NativeRequest(
    json['actions'] as String,
    json['data'] as Map<String, dynamic>,
  );
}

Map<String, dynamic> _$NativeRequestToJson(NativeRequest instance) =>
    <String, dynamic>{
      'actions': instance.actions,
      'data': instance.data,
    };
