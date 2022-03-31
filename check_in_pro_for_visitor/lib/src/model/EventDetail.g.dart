// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'EventDetail.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EventDetail _$EventDetailFromJson(Map<String, dynamic> json) {
  return EventDetail(
    (json['id'] as num)?.toDouble(),
    json['eventName'] as String,
    json['startDate'] as int,
    json['endDate'] as int,
    (json['guests'] as List)
        ?.map((e) =>
            e == null ? null : EventLog.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    json['badgeTemplate'] as String,
  );
}

Map<String, dynamic> _$EventDetailToJson(EventDetail instance) =>
    <String, dynamic>{
      'id': instance.id,
      'eventName': instance.eventName,
      'startDate': instance.startDate,
      'endDate': instance.endDate,
      'guests': instance.guests,
      'badgeTemplate': instance.badgeTemplate,
    };
