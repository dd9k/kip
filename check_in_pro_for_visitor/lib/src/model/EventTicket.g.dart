// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'EventTicket.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EventTicket _$EventTicketFromJson(Map<String, dynamic> json) {
  return EventTicket(
    (json['id'] as num)?.toDouble(),
    json['eventName'] as String,
    json['siteName'] as String,
    json['siteAddress'] as String,
    json['eventType'] as String,
    json['startDate'] as String,
    json['endDate'] as String,
    json['description'] as String,
    json['coverPathFile'] as String,
    (json['coverRepoId'] as num)?.toDouble(),
    json['contactPhone'] as String,
    json['contactEmail'] as String,
    json['organizersName'] as String,
    json['organizersInfo'] as String,
    json['reminderDays'] as String,
    (json['branchId'] as num)?.toDouble(),
    (json['companyId'] as num)?.toDouble(),
    json['startedState'] as bool,
    json['orderedState'] as bool,
  )..sendReminder = json['sendReminder'] as String;
}

Map<String, dynamic> _$EventTicketToJson(EventTicket instance) =>
    <String, dynamic>{
      'id': instance.id,
      'eventName': instance.eventName,
      'siteName': instance.siteName,
      'siteAddress': instance.siteAddress,
      'eventType': instance.eventType,
      'startDate': instance.startDate,
      'endDate': instance.endDate,
      'description': instance.description,
      'coverPathFile': instance.coverPathFile,
      'coverRepoId': instance.coverRepoId,
      'contactPhone': instance.contactPhone,
      'contactEmail': instance.contactEmail,
      'organizersName': instance.organizersName,
      'organizersInfo': instance.organizersInfo,
      'sendReminder': instance.sendReminder,
      'reminderDays': instance.reminderDays,
      'branchId': instance.branchId,
      'companyId': instance.companyId,
      'startedState': instance.startedState,
      'orderedState': instance.orderedState,
    };
