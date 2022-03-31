import 'package:check_in_pro_for_visitor/src/model/VisitorCheckIn.dart';
import 'package:check_in_pro_for_visitor/src/model/idCard/IDCardModel.dart';
import 'package:check_in_pro_for_visitor/src/utilities/Utilities.dart';
import 'package:intl/intl.dart';
import 'package:json_annotation/json_annotation.dart';

part 'PassPort.g.dart';

@JsonSerializable()
class PassPort extends IDCardModel {
  @JsonKey(name: 'documentNumber')
  String passportNo;

  @JsonKey(name: 'documentType')
  String documentType;

  @JsonKey(name: 'firstName')
  String firstName;

  @JsonKey(name: 'lastName')
  String lastName;

  @JsonKey(name: 'gender')
  String gender;

  @JsonKey(name: 'dateOfBirth')
  String dateOfBirth;

  @JsonKey(name: 'nationalityIso')
  String nationality;

  @JsonKey(name: 'issuingCountryIso')
  String issuingCountryIso;

  @JsonKey(name: 'expireDate')
  String date;

  PassPort.init();

  PassPort(this.passportNo, this.documentType, this.firstName, this.lastName, this.gender, this.dateOfBirth,
      this.nationality, this.issuingCountryIso, this.date);

  factory PassPort.fromJson(Map<String, dynamic> json) => _$PassPortFromJson(json);

  Map<String, dynamic> toJson() => _$PassPortToJson(this);

  @override
  IDCardModel fromJson(Map<String, dynamic> data) => PassPort.fromJson(data);

  @override
  String getID() => passportNo;

  @override
  VisitorCheckIn createVisitor(VisitorCheckIn visitorBackup, bool isReplace) {
    if ((visitorBackup.idCard == null || visitorBackup.idCard.isEmpty) || isReplace) {
      visitorBackup.idCard = passportNo;
    }
    if ((visitorBackup.passportNo == null || visitorBackup.passportNo.isEmpty) || isReplace) {
      visitorBackup.passportNo = passportNo;
    }
    if ((visitorBackup.fullName == null || visitorBackup.fullName.isEmpty) || isReplace) {
      visitorBackup.fullName = firstName + " " + lastName;
    }
    if ((visitorBackup.gender == null) || isReplace) {
      visitorBackup.gender = (gender == "Nữ") ? 1 : 0;
    }
    if ((visitorBackup.nationality == null || visitorBackup.nationality.isEmpty) || isReplace) {
      visitorBackup.nationality = nationality;
    }
    if ((visitorBackup.birthDay == null || visitorBackup.birthDay.isEmpty) || isReplace) {
      String dayString = dateOfBirth;
      try {
        DateFormat oldFormat = DateFormat("yyyy-MM-ddTHH:mm:ss");
        DateTime dateTime = oldFormat.parse(dateOfBirth);
        DateFormat newFormat = DateFormat("dd-MM-yyyy");
        dayString = newFormat.format(dateTime);
      } catch (e) {
        Utilities().printLog("wrong format $e");
      }
      visitorBackup.birthDay = dayString;
    }
    return visitorBackup;
  }
}
