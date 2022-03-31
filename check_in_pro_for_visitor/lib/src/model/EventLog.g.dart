// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'EventLog.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EventLog _$EventLogFromJson(Map<String, dynamic> json) {
  return EventLog(
    (json['guestId'] as num)?.toDouble() ?? 0.0,
    json['fullName'] as String,
    json['email'] as String,
    json['idCard'] as String,
    json['branchId'] as int,
    json['visitorType'] as String,
    json['inviteCode'] as String,
    json['timeZone'] as String,
    json['phoneNumber'] as String,
    json['signInType'] as String,
    json['signOutType'] as String,
    json['signInBy'] as int,
    (json['eventId'] as num)?.toDouble(),
    json['signIn'] as int,
    json['signOut'] as int,
    json['feedback'] as String,
    json['rating'] as int,
    json['isNew'] as bool,
  )..faceCaptureFile = json['faceCaptureFile'] as String;
}

Map<String, dynamic> _$EventLogToJson(EventLog instance) => <String, dynamic>{
      'guestId': instance.guestId,
      'fullName': instance.fullName,
      'email': instance.email,
      'idCard': instance.idCard,
      'branchId': instance.branchId,
      'visitorType': instance.visitorType,
      'inviteCode': instance.inviteCode,
      'timeZone': instance.timeZone,
      'phoneNumber': instance.phoneNumber,
      'signInType': instance.signInType,
      'signOutType': instance.signOutType,
      'signInBy': instance.signInBy,
      'eventId': instance.eventId,
      'signIn': instance.signIn,
      'signOut': instance.signOut,
      'feedback': instance.feedback,
      'rating': instance.rating,
      'isNew': instance.isNew,
      'faceCaptureFile': instance.faceCaptureFile,
    };
