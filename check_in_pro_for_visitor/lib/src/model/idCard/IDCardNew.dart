//import 'package:check_in_pro_for_visitor/src/model/VisitorCheckIn.dart';
//import 'package:check_in_pro_for_visitor/src/model/idCard/IDCardModel.dart';
//import 'package:json_annotation/json_annotation.dart';
//
//part 'IDCardNew.g.dart';
//
//@JsonSerializable()
//class IDCardNew extends IDCardModel {
//  @JsonKey(name: 'soThe')
//  String id;
//
//  @JsonKey(name: 'hoTen')
//  String fullName;
//
//  @JsonKey(name: 'gioiTinh')
//  String gender;
//
//  @JsonKey(name: 'ngaySinh')
//  String dateOfBirth;
//
//  @JsonKey(name: 'queQuan')
//  String homeTown;
//
//  @JsonKey(name: 'thuongTru')
//  String permanentAddress;
//
//  @JsonKey(name: 'quocTich')
//  String nationality;
//
//  @JsonKey(name: 'ngayHetHan')
//  String date;
//
//  IDCardNew.init();
//
//  IDCardNew(this.id, this.fullName, this.gender, this.dateOfBirth, this.homeTown, this.permanentAddress,
//      this.nationality, this.date);
//
//  factory IDCardNew.fromJson(Map<String, dynamic> json) => _$IDCardNewFromJson(json);
//
//  Map<String, dynamic> toJson() => _$IDCardNewToJson(this);
//
//  @override
//  IDCardModel fromJson(Map<String, dynamic> data) => IDCardNew.fromJson(data);
//
//  @override
//  String getID() => id;
//
//  @override
//  VisitorCheckIn createVisitor(VisitorCheckIn visitorBackup, bool isReplace) {
//    if ((visitorBackup.idCard == null || visitorBackup.idCard.isEmpty) || isReplace) {
//      visitorBackup.idCard = id;
//    }
//    if ((visitorBackup.fullName == null || visitorBackup.fullName.isEmpty) || isReplace) {
//      visitorBackup.fullName = fullName;
//    }
//    if ((visitorBackup.gender == null) || isReplace) {
//      if (gender == "Nữ") {
//        visitorBackup.gender = 1;
//      } else if (gender == "Nam") {
//        visitorBackup.gender = 0;
//      }
//    }
//    if ((visitorBackup.nationality == null || visitorBackup.nationality.isEmpty) || isReplace) {
//      visitorBackup.nationality = "Việt Nam";
//    }
//    if ((visitorBackup.permanentAddress == null || visitorBackup.permanentAddress.isEmpty) || isReplace) {
//      visitorBackup.permanentAddress = permanentAddress;
//    }
//    if ((visitorBackup.birthDay == null || visitorBackup.birthDay.isEmpty) || isReplace) {
//      visitorBackup.birthDay = dateOfBirth;
//    }
//    return visitorBackup;
//  }
//}

import 'package:check_in_pro_for_visitor/src/model/VisitorCheckIn.dart';
import 'package:check_in_pro_for_visitor/src/model/idCard/IDCardModel.dart';
import 'package:json_annotation/json_annotation.dart';

part 'IDCardNew.g.dart';

@JsonSerializable()
class IDCardNew extends IDCardModel {
  @JsonKey(name: 'id')
  String id;

  @JsonKey(name: 'name')
  String fullName;

  @JsonKey(name: 'gender')
  String gender;

  @JsonKey(name: 'dob')
  String dateOfBirth;

  @JsonKey(name: 'address')
  String homeTown;

  @JsonKey(name: 'Permanent_address')
  String permanentAddress;

  @JsonKey(name: 'nation')
  String nationality;

  @JsonKey(name: 'expire')
  String date;

  IDCardNew.init();

  IDCardNew(this.id, this.fullName, this.gender, this.dateOfBirth, this.homeTown, this.permanentAddress,
      this.nationality, this.date);

  factory IDCardNew.fromJson(Map<String, dynamic> json) => _$IDCardNewFromJson(json);

  Map<String, dynamic> toJson() => _$IDCardNewToJson(this);

  @override
  IDCardModel fromJson(Map<String, dynamic> data) => IDCardNew.fromJson(data);

  @override
  String getID() => id;

  @override
  VisitorCheckIn createVisitor(VisitorCheckIn visitorBackup, bool isReplace) {
    if ((visitorBackup.idCard == null || visitorBackup.idCard.isEmpty) || isReplace) {
      visitorBackup.idCard = id;
    }
    if ((visitorBackup.fullName == null || visitorBackup.fullName.isEmpty) || isReplace) {
      visitorBackup.fullName = fullName;
    }
    if ((visitorBackup.gender == null) || isReplace) {
      if (gender == "Nữ") {
        visitorBackup.gender = 1;
      } else if (gender == "Nam") {
        visitorBackup.gender = 0;
      }
    }
    if ((visitorBackup.nationality == null || visitorBackup.nationality.isEmpty) || isReplace) {
      visitorBackup.nationality = "Việt Nam";
    }
    if ((visitorBackup.permanentAddress == null || visitorBackup.permanentAddress.isEmpty) || isReplace) {
      visitorBackup.permanentAddress = permanentAddress;
    }
    if ((visitorBackup.birthDay == null || visitorBackup.birthDay.isEmpty) || isReplace) {
      visitorBackup.birthDay = dateOfBirth;
    }
    return visitorBackup;
  }
}

