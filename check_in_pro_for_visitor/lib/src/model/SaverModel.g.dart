// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'SaverModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SaverModel _$SaverModelFromJson(Map<String, dynamic> json) {
  return SaverModel(
    json['status'] as bool,
    json['timeout'] as int,
    (json['images'] as List)?.map((e) => e as String)?.toList(),
  );
}

Map<String, dynamic> _$SaverModelToJson(SaverModel instance) =>
    <String, dynamic>{
      'status': instance.status,
      'timeout': instance.timeout,
      'images': instance.images,
    };
