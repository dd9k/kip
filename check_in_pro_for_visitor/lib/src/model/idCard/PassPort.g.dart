// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'PassPort.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PassPort _$PassPortFromJson(Map<String, dynamic> json) {
  return PassPort(
    json['documentNumber'] as String,
    json['documentType'] as String,
    json['firstName'] as String,
    json['lastName'] as String,
    json['gender'] as String,
    json['dateOfBirth'] as String,
    json['nationalityIso'] as String,
    json['issuingCountryIso'] as String,
    json['expireDate'] as String,
  );
}

Map<String, dynamic> _$PassPortToJson(PassPort instance) => <String, dynamic>{
      'documentNumber': instance.passportNo,
      'documentType': instance.documentType,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'gender': instance.gender,
      'dateOfBirth': instance.dateOfBirth,
      'nationalityIso': instance.nationality,
      'issuingCountryIso': instance.issuingCountryIso,
      'expireDate': instance.date,
    };
