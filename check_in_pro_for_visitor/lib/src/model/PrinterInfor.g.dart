// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'PrinterInfor.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PrinterInfor _$PrinterInforFromJson(Map<String, dynamic> json) {
  return PrinterInfor(
    json['actions'] as String,
    json['ipAddress'] as String,
    json['model'] as String,
    json['isConnect'] as bool,
  );
}

Map<String, dynamic> _$PrinterInforToJson(PrinterInfor instance) =>
    <String, dynamic>{
      'actions': instance.actions,
      'ipAddress': instance.ipAddress,
      'model': instance.model,
      'isConnect': instance.isConnect,
    };
