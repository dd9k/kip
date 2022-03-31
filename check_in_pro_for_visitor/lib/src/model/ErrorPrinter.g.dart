// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ErrorPrinter.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ErrorPrinter _$ErrorPrinterFromJson(Map<String, dynamic> json) {
  return ErrorPrinter(
    json['status'] as String,
    json['ERROR_CODE'] as String,
    json['message'] as String,
  );
}

Map<String, dynamic> _$ErrorPrinterToJson(ErrorPrinter instance) =>
    <String, dynamic>{
      'status': instance.status,
      'ERROR_CODE': instance.ERROR_CODE,
      'message': instance.message,
    };
