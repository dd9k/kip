// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ContactPerson.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ContactPerson _$ContactPersonFromJson(Map<String, dynamic> json) {
  return ContactPerson(
    (json['id'] as num)?.toDouble(),
    json['userName'] as String,
    json['email'] as String,
    json['phone'] as String,
    json['description'] as String,
    json['fullName'] as String,
    json['firstName'] as String,
    json['lastName'] as String,
    json['companyName'] as String,
    json['avatarFileName'] as String,
    json['gender'] as String,
    json['workPhoneExt'] as String,
    json['workPhoneNumber'] as String,
    json['jobTitle'] as String,
    json['department'] as String,
  );
}

Map<String, dynamic> _$ContactPersonToJson(ContactPerson instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userName': instance.userName,
      'email': instance.email,
      'phone': instance.phone,
      'description': instance.description,
      'fullName': instance.fullName,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'companyName': instance.companyName,
      'avatarFileName': instance.avatarFileName,
      'gender': instance.gender,
      'workPhoneExt': instance.workPhoneExt,
      'workPhoneNumber': instance.workPhoneNumber,
      'jobTitle': instance.jobTitle,
      'department': instance.department,
    };
