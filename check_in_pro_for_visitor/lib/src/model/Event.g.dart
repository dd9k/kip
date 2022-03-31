// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Event.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Event _$EventFromJson(Map<String, dynamic> json) {
  return Event(
    (json['id'] as num)?.toDouble(),
    json['eventName'] as String,
    (json['branchId'] as num)?.toDouble(),
    (json['contactPersonId'] as num)?.toDouble(),
    json['visitorType'] as String,
    json['startDate'] as String,
    json['endDate'] as String,
    json['description'] as String,
    json['coverPathFile'] as String,
    (json['coverRepoId'] as num)?.toDouble(),
    (json['companyId'] as num)?.toDouble(),
    json['siteName'] as String,
    json['siteAddress'] as String,
  );
}

Map<String, dynamic> _$EventToJson(Event instance) => <String, dynamic>{
      'id': instance.id,
      'eventName': instance.eventName,
      'branchId': instance.branchId,
      'contactPersonId': instance.contactPersonId,
      'visitorType': instance.visitorType,
      'startDate': instance.startDate,
      'endDate': instance.endDate,
      'description': instance.description,
      'coverPathFile': instance.coverPathFile,
      'coverRepoId': instance.coverRepoId,
      'companyId': instance.companyId,
      'siteName': instance.siteName,
      'siteAddress': instance.siteAddress,
    };
