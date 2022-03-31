// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'LocationInfor.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LocationInfor _$LocationInforFromJson(Map<String, dynamic> json) {
  return LocationInfor(
    (json['id'] as num)?.toDouble(),
    json['code'] as String,
    json['name'] as String,
    json['address'] as String,
    json['locationPhone'] as String,
  );
}

Map<String, dynamic> _$LocationInforToJson(LocationInfor instance) =>
    <String, dynamic>{
      'id': instance.id,
      'code': instance.code,
      'name': instance.name,
      'address': instance.address,
      'locationPhone': instance.locationPhone,
    };
