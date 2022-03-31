// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'UserInfor.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserInfor _$UserInforFromJson(Map<String, dynamic> json) {
  return UserInfor(
    json['accountId'] as int,
    json['userName'] as String,
    json['fullName'] as String,
    json['email'] as String,
    json['fingerprint'] as String,
    json['phoneNumber'] as String,
    json['pushNotification'] as String,
    json['pushEmail'] as String,
    json['companyInfo'] == null
        ? null
        : CompanyInfor.fromJson(json['companyInfo'] as Map<String, dynamic>),
    json['locationInfo'] == null
        ? null
        : LocationInfor.fromJson(json['locationInfo'] as Map<String, dynamic>),
    json['deviceInfo'] == null
        ? null
        : DeviceInfor.fromJson(json['deviceInfo'] as Map<String, dynamic>),
    (json['companyLanguage'] as List)
        ?.map((e) => e == null
            ? null
            : CompanyLanguage.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    (json['branchInfo'] as List)
        ?.map((e) =>
            e == null ? null : BranchInfor.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    json['firstLogin'] as bool,
    json['isBuilding'] as bool,
    json['isEventTicket'] as bool,
  );
}

Map<String, dynamic> _$UserInforToJson(UserInfor instance) => <String, dynamic>{
      'accountId': instance.accountId,
      'userName': instance.userName,
      'fullName': instance.fullName,
      'email': instance.email,
      'fingerprint': instance.fingerprint,
      'phoneNumber': instance.phoneNumber,
      'pushNotification': instance.pushNotification,
      'pushEmail': instance.pushEmail,
      'companyInfo': instance.companyInfo,
      'locationInfo': instance.locationInfo,
      'deviceInfo': instance.deviceInfo,
      'companyLanguage': instance.companyLanguage,
      'branchInfo': instance.branchInfo,
      'firstLogin': instance.firstLogin,
      'isBuilding': instance.isBuilding,
      'isEventTicket': instance.isEventTicket,
    };
