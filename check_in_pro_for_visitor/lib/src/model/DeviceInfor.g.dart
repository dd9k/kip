// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'DeviceInfor.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DeviceInfor _$DeviceInforFromJson(Map<String, dynamic> json) {
  return DeviceInfor(
    json['id'] as int,
    json['name'] as String,
    json['type'] as String,
    json['deviceId'] as String,
    (json['locationId'] as num)?.toDouble(),
    (json['branchId'] as num)?.toDouble(),
    json['branchCode'] as String,
    json['osVersion'] as String,
    json['printAddress'] as String,
    json['timeout'] as int,
    json['appVersion'] as String,
    json['ipAddress'] as String,
  );
}

Map<String, dynamic> _$DeviceInforToJson(DeviceInfor instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'type': instance.type,
      'deviceId': instance.deviceId,
      'locationId': instance.locationId,
      'branchId': instance.branchId,
      'branchCode': instance.branchCode,
      'osVersion': instance.osVersion,
      'printAddress': instance.printAddress,
      'timeout': instance.timeout,
      'appVersion': instance.appVersion,
      'ipAddress': instance.ipAddress,
    };
