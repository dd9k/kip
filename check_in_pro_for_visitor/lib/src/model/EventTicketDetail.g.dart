// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'EventTicketDetail.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EventTicketDetail _$EventTicketDetailFromJson(Map<String, dynamic> json) {
  return EventTicketDetail(
    json['eventInfo'] == null
        ? null
        : EventTicket.fromJson(json['eventInfo'] as Map<String, dynamic>),
    (json['orderInfo'] as List)
        ?.map((e) =>
            e == null ? null : ETOrderInfo.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$EventTicketDetailToJson(EventTicketDetail instance) =>
    <String, dynamic>{
      'eventInfo': instance.eventInfo,
      'orderInfo': instance.orderInfo,
    };
