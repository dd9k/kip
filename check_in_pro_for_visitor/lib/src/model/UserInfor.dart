import 'package:check_in_pro_for_visitor/src/model/BranchInfor.dart';
import 'package:check_in_pro_for_visitor/src/model/CompanyInfor.dart';
import 'package:check_in_pro_for_visitor/src/model/DeviceInfor.dart';
import 'package:check_in_pro_for_visitor/src/model/LocationInfor.dart';
import 'package:json_annotation/json_annotation.dart';

import 'CompanyLanguage.dart';

part 'UserInfor.g.dart';

@JsonSerializable()
class UserInfor {
  @JsonKey(name: 'accountId')
  int accountId;

  @JsonKey(name: 'userName')
  String userName;

  @JsonKey(name: 'fullName')
  String fullName;

  @JsonKey(name: 'email')
  String email;

  @JsonKey(name: 'fingerprint')
  String fingerprint;

  @JsonKey(name: 'phoneNumber')
  String phoneNumber;

  @JsonKey(name: 'pushNotification')
  String pushNotification;

  @JsonKey(name: 'pushEmail')
  String pushEmail;

  @JsonKey(name: 'companyInfo')
  CompanyInfor companyInfo;

  @JsonKey(name: 'locationInfo')
  LocationInfor locationInfo;

  @JsonKey(name: 'deviceInfo')
  DeviceInfor deviceInfo;

  @JsonKey(name: 'companyLanguage')
  List<CompanyLanguage> companyLanguage;

  @JsonKey(name: 'branchInfo')
  List<BranchInfor> branchInfo;

  @JsonKey(name: 'firstLogin')
  bool firstLogin;

  @JsonKey(name: 'isBuilding')
  bool isBuilding;

  @JsonKey(name: 'isEventTicket')
  bool isEventTicket;

  UserInfor(
      this.accountId,
      this.userName,
      this.fullName,
      this.email,
      this.fingerprint,
      this.phoneNumber,
      this.pushNotification,
      this.pushEmail,
      this.companyInfo,
      this.locationInfo,
      this.deviceInfo,
      this.companyLanguage,
      this.branchInfo,
      this.firstLogin,
      this.isBuilding,
      this.isEventTicket);

  UserInfor._();

  factory UserInfor.fromJson(Map<String, dynamic> json) => _$UserInforFromJson(json);
}
