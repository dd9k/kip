// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'BranchInfor.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BranchInfor _$BranchInforFromJson(Map<String, dynamic> json) {
  return BranchInfor(
    (json['id'] as num)?.toDouble(),
    (json['companyId'] as num)?.toDouble(),
    (json['branchId'] as num)?.toDouble(),
    (json['userId'] as num)?.toDouble(),
    json['branchCode'] as String,
    json['branchName'] as String,
    json['branchAddress'] as String,
    json['companyName'] as String,
    json['badgeTemplateCode'] as String,
  );
}

Map<String, dynamic> _$BranchInforToJson(BranchInfor instance) =>
    <String, dynamic>{
      'id': instance.id,
      'companyId': instance.companyId,
      'branchId': instance.branchId,
      'userId': instance.userId,
      'branchCode': instance.branchCode,
      'branchName': instance.branchName,
      'branchAddress': instance.branchAddress,
      'companyName': instance.companyName,
      'badgeTemplateCode': instance.badgeTemplateCode,
    };
