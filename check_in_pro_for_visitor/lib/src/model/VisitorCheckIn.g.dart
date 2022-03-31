// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'VisitorCheckIn.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VisitorCheckIn _$VisitorCheckInFromJson(Map<String, dynamic> json) {
  return VisitorCheckIn(
    (json['id'] as num)?.toDouble() ?? 0.0,
    json['fullName'] as String,
    json['email'] as String,
    json['phoneNumber'] as String,
    json['idCard'] as String,
    json['purpose'] as String,
    (json['visitorId'] as num)?.toDouble(),
    json['visitorType'] as String,
    json['fromCompany'] as String,
    json['toCompany'] as String,
    (json['contactPersonId'] as num)?.toDouble(),
    (json['faceCaptureRepoId'] as num)?.toDouble(),
    json['faceCaptureFile'] as String,
    json['signInBy'] as int,
    json['signInType'] as String,
    (json['toCompanyId'] as num)?.toDouble(),
    json['cardNo'] as String,
    json['goods'] as String,
    json['receiver'] as String,
    json['visitorPosition'] as String,
    (json['idCardRepoId'] as num)?.toDouble(),
    json['idCardFile'] as String,
    json['surveyAnswer'] as String,
    json['gender'] as int,
    json['passportNo'] as String,
    json['nationality'] as String,
    json['birthDay'] as String,
    json['permanentAddress'] as String,
    json['departmentRoomNo'] as String,
    (json['surveyId'] as num)?.toDouble(),
    json['inviteCode'] as String,
    json['checkOutTimeExpected'] as String,
    json['customStep'] as String,
  );
}

Map<String, dynamic> _$VisitorCheckInToJson(VisitorCheckIn instance) =>
    <String, dynamic>{
      'id': instance.id,
      'fullName': instance.fullName,
      'email': instance.email,
      'phoneNumber': instance.phoneNumber,
      'idCard': instance.idCard,
      'purpose': instance.purpose,
      'visitorId': instance.visitorId,
      'visitorType': instance.visitorType,
      'checkOutTimeExpected': instance.checkOutTimeExpected,
      'fromCompany': instance.fromCompany,
      'toCompany': instance.toCompany,
      'contactPersonId': instance.contactPersonId,
      'faceCaptureRepoId': instance.faceCaptureRepoId,
      'faceCaptureFile': instance.faceCaptureFile,
      'signInBy': instance.signInBy,
      'signInType': instance.signInType,
      'toCompanyId': instance.toCompanyId,
      'cardNo': instance.cardNo,
      'goods': instance.goods,
      'receiver': instance.receiver,
      'visitorPosition': instance.visitorPosition,
      'idCardRepoId': instance.idCardRepoId,
      'idCardFile': instance.idCardFile,
      'surveyAnswer': instance.survey,
      'surveyId': instance.surveyId,
      'gender': instance.gender,
      'passportNo': instance.passportNo,
      'nationality': instance.nationality,
      'birthDay': instance.birthDay,
      'permanentAddress': instance.permanentAddress,
      'departmentRoomNo': instance.departmentRoomNo,
      'inviteCode': instance.inviteCode,
      'customStep': instance.customStep,
    };
