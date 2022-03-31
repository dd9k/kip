import 'package:check_in_pro_for_visitor/src/model/VisitorCheckIn.dart';
import 'package:check_in_pro_for_visitor/src/model/idCard/IDCardModel.dart';
import 'package:json_annotation/json_annotation.dart';

part 'IDCardOld.g.dart';

@JsonSerializable()
class IDCardOld extends IDCardModel {
  @JsonKey(name: 'id')
  String id;

  @JsonKey(name: 'name')
  String fullName;

  @JsonKey(name: 'birth')
  String dateOfBirth;

  @JsonKey(name: 'home')
  String homeTown;

  @JsonKey(name: 'add')
  String permanentAddress;

  IDCardOld.init();

  IDCardOld(this.id, this.fullName, this.dateOfBirth, this.homeTown, this.permanentAddress);

  factory IDCardOld.fromJson(Map<String, dynamic> json) => _$IDCardOldFromJson(json);

  Map<String, dynamic> toJson() => _$IDCardOldToJson(this);

  @override
  IDCardModel fromJson(Map<String, dynamic> data) => IDCardOld.fromJson(data);

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
    if ((visitorBackup.permanentAddress == null || visitorBackup.permanentAddress.isEmpty) || isReplace) {
      visitorBackup.permanentAddress = permanentAddress;
    }
    if ((visitorBackup.birthDay == null || visitorBackup.birthDay.isEmpty) || isReplace) {
      visitorBackup.birthDay = dateOfBirth;
    }
    return visitorBackup;
  }
}