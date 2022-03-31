// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'TouchlessModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TouchlessModel _$TouchlessModelFromJson(Map<String, dynamic> json) {
  return TouchlessModel(
    json['status'] as bool,
    json['expiredDay'] as int,
    json['token'] as String,
    json['tokenExpiredDate'] as String,
    json['expiredTimestamp'] as int,
  );
}

Map<String, dynamic> _$TouchlessModelToJson(TouchlessModel instance) =>
    <String, dynamic>{
      'status': instance.status,
      'expiredDay': instance.expiredDay,
      'token': instance.token,
      'tokenExpiredDate': instance.tokenExpiredDate,
      'expiredTimestamp': instance.expiredTimestamp,
    };
