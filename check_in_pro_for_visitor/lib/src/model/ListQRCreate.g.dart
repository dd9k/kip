// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ListQRCreate.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ListQRCreate _$ListQRCreateFromJson(Map<String, dynamic> json) {
  return ListQRCreate(
    (json['qrCodes'] as List)
        ?.map((e) => e == null
            ? null
            : TimekeepingQR.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    json['status'] as bool,
    json['refreshTime'] as int,
  );
}

Map<String, dynamic> _$ListQRCreateToJson(ListQRCreate instance) =>
    <String, dynamic>{
      'qrCodes': instance.qrCodes,
      'status': instance.status,
      'refreshTime': instance.refreshTime,
    };
