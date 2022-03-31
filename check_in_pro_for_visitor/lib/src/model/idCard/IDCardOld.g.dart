// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'IDCardOld.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

IDCardOld _$IDCardOldFromJson(Map<String, dynamic> json) {
  return IDCardOld(
    json['id'] as String,
    json['name'] as String,
    json['birth'] as String,
    json['home'] as String,
    json['add'] as String,
  );
}

Map<String, dynamic> _$IDCardOldToJson(IDCardOld instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.fullName,
      'birth': instance.dateOfBirth,
      'home': instance.homeTown,
      'add': instance.permanentAddress,
    };
