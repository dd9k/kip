import 'package:check_in_pro_for_visitor/src/constants/Constants.dart';
import 'package:json_annotation/json_annotation.dart';

part 'VisitorLog.g.dart';

@JsonSerializable()
class VisitorLog {
  @JsonKey(ignore: true)
  String privateKey;

  @JsonKey(name: 'id', defaultValue: 0.0)
  double id;

  @JsonKey(name: 'fullName')
  String fullName;

  @JsonKey(name: 'email')
  String email;

  @JsonKey(name: 'phoneNumber')
  String phoneNumber;

  @JsonKey(name: 'idCard')
  String idCard;

  @JsonKey(name: 'purpose')
  String purpose;

  @JsonKey(name: 'visitorId')
  double visitorId;

  @JsonKey(name: 'visitorType')
  String visitorType;

  @JsonKey(name: 'checkOutTimeExpected')
  String checkOutTimeExpected;

  @JsonKey(name: 'fromCompany')
  String fromCompany;

  @JsonKey(name: 'toCompany')
  String toCompany;

  @JsonKey(name: 'contactPersonId')
  double contactPersonId;

  @JsonKey(name: 'faceCaptureRepoId')
  double faceCaptureRepoId;

  @JsonKey(name: 'faceCaptureFile')
  String faceCaptureFile;

  @JsonKey(name: 'signInBy')
  int signInBy;

  @JsonKey(name: 'signInType')
  String signInType = Constants.TYPE_CHECK;

  @JsonKey(name: 'signOutBy')
  int signOutBy;

  @JsonKey(name: 'signOutType')
  String signOutType = Constants.TYPE_CHECK;

  @JsonKey(ignore: true)
  String imagePath = "";

  @JsonKey(ignore: true)
  String imageIdPath = "";

  @JsonKey(name: 'logId')
  String logId;

  @JsonKey(name: 'signIn')
  int signIn;

  @JsonKey(name: 'signOut')
  int signOut;

  @JsonKey(name: 'branchId')
  double locationId;

  @JsonKey(name: 'createdBy')
  String createdBy;

  @JsonKey(name: 'feedback')
  String feedback;

  @JsonKey(name: 'rating')
  double rating;

  @JsonKey(name: 'cardNo')
  String cardNo;

  @JsonKey(name: 'goods')
  String goods;

  @JsonKey(name: 'receiver')
  String receiver;

  @JsonKey(name: 'visitorPosition')
  String visitorPosition;

  @JsonKey(name: 'idCardRepoId')
  double idCardRepoId;

  @JsonKey(name: 'idCardFile')
  String idCardFile;

  @JsonKey(name: 'surveyAnswer')
  String survey;

  @JsonKey(name: 'gender')
  int gender;

  @JsonKey(name: 'passportNo')
  String passportNo;

  @JsonKey(name: 'nationality')
  String nationality;

  @JsonKey(name: 'birthDay')
  String birthDay;

  @JsonKey(name: 'permanentAddress')
  String permanentAddress;

  @JsonKey(name: 'departmentRoomNo')
  String departmentRoomNo;

  @JsonKey(name: 'surveyId')
  double surveyId;

  @JsonKey(name: 'customStep')
  String customStep;

  VisitorLog(
      this.id,
      this.fullName,
      this.email,
      this.phoneNumber,
      this.idCard,
      this.purpose,
      this.visitorId,
      this.visitorType,
      this.fromCompany,
      this.toCompany,
      this.contactPersonId,
      this.faceCaptureRepoId,
      this.faceCaptureFile,
      this.signInBy,
      this.signInType,
      this.logId,
      this.signIn,
      this.signOut,
      this.feedback,
      this.rating,
      this.cardNo,
      this.goods,
      this.receiver,
      this.visitorPosition,
      this.idCardRepoId,
      this.idCardFile,
      this.survey,
      this.gender,
      this.passportNo,
      this.nationality,
      this.birthDay,
      this.permanentAddress,
      this.departmentRoomNo,
      this.surveyId,
      this.checkOutTimeExpected,
      this.customStep);

  VisitorLog.init(
      this.privateKey,
      this.id,
      this.fullName,
      this.email,
      this.phoneNumber,
      this.idCard,
      this.purpose,
      this.visitorId,
      this.visitorType,
      this.fromCompany,
      this.toCompany,
      this.contactPersonId,
      this.faceCaptureRepoId,
      this.faceCaptureFile,
      this.signInBy,
      this.signInType,
      this.signOutBy,
      this.signOutType,
      this.imagePath,
      this.imageIdPath,
      this.logId,
      this.signIn,
      this.signOut,
      this.locationId,
      this.createdBy,
      this.feedback,
      this.rating,
      this.cardNo,
      this.goods,
      this.receiver,
      this.visitorPosition,
      this.idCardRepoId,
      this.idCardFile,
      this.survey,
      this.gender,
      this.passportNo,
      this.nationality,
      this.birthDay,
      this.permanentAddress,
      this.departmentRoomNo,
      this.surveyId,
      this.checkOutTimeExpected,
      this.customStep);

  factory VisitorLog.fromJson(Map<String, dynamic> json) => _$VisitorLogFromJson(json);

  Map<String, dynamic> toJson() => _$VisitorLogToJson(this);
}
