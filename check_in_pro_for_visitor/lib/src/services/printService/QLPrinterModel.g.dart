// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'QLPrinterModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

QLPrinterModel _$QLPrinterModelFromJson(Map<String, dynamic> json) {
  return QLPrinterModel(
    json['type'] as String,
    json['ipAddress'] as String,
    json['model'] as String,
    json['isConnect'] as bool,
    json['numberOfCopy'] as int,
  );
}

Map<String, dynamic> _$QLPrinterModelToJson(QLPrinterModel instance) =>
    <String, dynamic>{
      'type': instance.type,
      'ipAddress': instance.ipAddress,
      'model': instance.model,
      'isConnect': instance.isConnect,
      'numberOfCopy': instance.numberOfCopy,
    };
