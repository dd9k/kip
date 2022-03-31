// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'XPrinterModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

XPrinterModel _$XPrinterModelFromJson(Map<String, dynamic> json) {
  return XPrinterModel(
    json['type'] as String,
    json['ipAddress'] as String,
    json['model'] as String,
    json['isConnect'] as bool,
    json['numberOfCopy'] as int,
  );
}

Map<String, dynamic> _$XPrinterModelToJson(XPrinterModel instance) =>
    <String, dynamic>{
      'type': instance.type,
      'ipAddress': instance.ipAddress,
      'model': instance.model,
      'isConnect': instance.isConnect,
      'numberOfCopy': instance.numberOfCopy,
    };
