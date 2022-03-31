// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'FunctionGroup.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FunctionGroup _$FunctionGroupFromJson(Map<String, dynamic> json) {
  return FunctionGroup(
    json['functionName'] as String,
    json['permission'] as String,
  );
}

Map<String, dynamic> _$FunctionGroupToJson(FunctionGroup instance) =>
    <String, dynamic>{
      'functionName': instance.functionName,
      'permission': instance.permission,
    };
