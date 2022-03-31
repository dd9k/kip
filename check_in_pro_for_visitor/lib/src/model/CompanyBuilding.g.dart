// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'CompanyBuilding.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CompanyBuilding _$CompanyBuildingFromJson(Map<String, dynamic> json) {
  return CompanyBuilding(
    (json['id'] as num)?.toDouble(),
    json['companyName'] as String,
    json['shortName'] as String,
    json['representativeName'] as String,
    json['representativeEmail'] as String,
    (json['representativeId'] as num)?.toDouble(),
    json['floor'] as String,
    json['note'] as String,
    json['isActive'] as int,
    (json['companyId'] as num)?.toDouble(),
    json['logoPath'] as String,
    json['logoRepoId'] as int,
  );
}

Map<String, dynamic> _$CompanyBuildingToJson(CompanyBuilding instance) =>
    <String, dynamic>{
      'id': instance.id,
      'companyName': instance.companyName,
      'shortName': instance.shortName,
      'representativeName': instance.representativeName,
      'representativeEmail': instance.representativeEmail,
      'representativeId': instance.representativeId,
      'floor': instance.floor,
      'note': instance.note,
      'isActive': instance.isActive,
      'companyId': instance.companyId,
      'logoPath': instance.logoPath,
      'logoRepoId': instance.logoRepoId,
    };
