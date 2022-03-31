// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'VisitorLog.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VisitorLog _$VisitorLogFromJson(Map<String, dynamic> json) {
  return VisitorLog(
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
    json['logId'] as String,
    json['signIn'] as int,
    json['signOut'] as int,
    json['feedback'] as String,
    (json['rating'] as num)?.toDouble(),
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
    json['checkOutTimeExpected'] as String,
    json['customStep'] as String,
  )
    ..signOutBy = json['signOutBy'] as int
    ..signOutType = json['signOutType'] as String
    ..locationId = (json['branchId'] as num)?.toDouble()
    ..createdBy = json['createdBy'] as String;
}

Map<String, dynamic> _$VisitorLogToJson(VisitorLog instance) =>
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
      'signOutBy': instance.signOutBy,
      'signOutType': instance.signOutType,
      'logId': instance.logId,
      'signIn': instance.signIn,
      'signOut': instance.signOut,
      'branchId': instance.locationId,
      'createdBy': instance.createdBy,
      'feedback': instance.feedback,
      'rating': instance.rating,
      'cardNo': instance.cardNo,
      'goods': instance.goods,
      'receiver': instance.receiver,
      'visitorPosition': instance.visitorPosition,
      'idCardRepoId': instance.idCardRepoId,
      'idCardFile': instance.idCardFile,
      'surveyAnswer': instance.survey,
      'gender': instance.gender,
      'passportNo': instance.passportNo,
      'nationality': instance.nationality,
      'birthDay': instance.birthDay,
      'permanentAddress': instance.permanentAddress,
      'departmentRoomNo': instance.departmentRoomNo,
      'surveyId': instance.surveyId,
      'customStep': instance.customStep,
    };
