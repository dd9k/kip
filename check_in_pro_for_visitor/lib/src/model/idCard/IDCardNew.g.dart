// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'IDCardNew.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

IDCardNew _$IDCardNewFromJson(Map<String, dynamic> json) {
  return IDCardNew(
    json['id'] as String,
    json['name'] as String,
    json['gender'] as String,
    json['dob'] as String,
    json['address'] as String,
    json['Permanent_address'] as String,
    json['nation'] as String,
    json['expire'] as String,
  );
}

Map<String, dynamic> _$IDCardNewToJson(IDCardNew instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.fullName,
      'gender': instance.gender,
      'dob': instance.dateOfBirth,
      'address': instance.homeTown,
      'Permanent_address': instance.permanentAddress,
      'nation': instance.nationality,
      'expire': instance.date,
    };
