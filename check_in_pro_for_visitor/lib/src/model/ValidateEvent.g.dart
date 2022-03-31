// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ValidateEvent.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ValidateEvent _$ValidateEventFromJson(Map<String, dynamic> json) {
  return ValidateEvent(
    json['status'] as String,
    json['visitorLog'] == null
        ? null
        : VisitorCheckIn.fromJson(json['visitorLog'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$ValidateEventToJson(ValidateEvent instance) =>
    <String, dynamic>{
      'status': instance.status,
      'visitorLog': instance.visitor,
    };
