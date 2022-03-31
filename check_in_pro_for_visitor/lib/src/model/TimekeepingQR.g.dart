// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'TimekeepingQR.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TimekeepingQR _$TimekeepingQRFromJson(Map<String, dynamic> json) {
  return TimekeepingQR(
    json['content'] as String,
    json['expiredTime'] as int,
  );
}

Map<String, dynamic> _$TimekeepingQRToJson(TimekeepingQR instance) =>
    <String, dynamic>{
      'content': instance.content,
      'expiredTime': instance.expiredTime,
    };
