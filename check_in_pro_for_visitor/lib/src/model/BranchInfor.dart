import 'package:json_annotation/json_annotation.dart';

part 'BranchInfor.g.dart';

@JsonSerializable()
class BranchInfor {
  @JsonKey(name: 'id')
  double id;

  @JsonKey(name: 'companyId')
  double companyId;

  @JsonKey(name: 'branchId')
  double branchId;

  @JsonKey(name: 'userId')
  double userId;

  @JsonKey(name: 'branchCode')
  String branchCode;

  @JsonKey(name: 'branchName')
  String branchName;

  @JsonKey(name: 'branchAddress')
  String branchAddress;

  @JsonKey(name: 'companyName')
  String companyName;

  @JsonKey(name: 'badgeTemplateCode')
  String badgeTemplateCode;

  @JsonKey(ignore: true)
  bool isSelect = false;

  BranchInfor._();

  BranchInfor(this.id, this.companyId, this.branchId, this.userId, this.branchCode, this.branchName, this.branchAddress,
      this.companyName, this.badgeTemplateCode);

  factory BranchInfor.fromJson(Map<String, dynamic> json) => _$BranchInforFromJson(json);

  Map<String, dynamic> toJson() => _$BranchInforToJson(this);
}
