import 'dart:convert';

import 'package:check_in_pro_for_visitor/src/constants/Constants.dart';
import 'package:check_in_pro_for_visitor/src/utilities/AppLocalizations.dart';
import 'package:check_in_pro_for_visitor/src/utilities/Utilities.dart';
import 'package:flutter/widgets.dart';
import 'package:json_annotation/json_annotation.dart';

import 'CheckInFlow.dart';
import 'EventLog.dart';

part 'VisitorCheckIn.g.dart';

@JsonSerializable()
class VisitorCheckIn {
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

  @JsonKey(ignore: true)
  String floor = "";

  @JsonKey(ignore: true)
  String imagePath = "";

  @JsonKey(ignore: true)
  String imageIdPath;

  @JsonKey(name: 'toCompanyId')
  double toCompanyId;

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

  @JsonKey(name: 'surveyId')
  double surveyId;

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

  @JsonKey(name: 'inviteCode')
  String inviteCode;

  @JsonKey(name: 'customStep')
  String customStep;

  VisitorCheckIn.inital();

  VisitorCheckIn.copyWithEventLog(EventLog eventLog) {
    this.id = eventLog.guestId;
    this.fullName = eventLog.fullName;
    this.email = eventLog.email;
    this.idCard = eventLog.idCard;
    this.inviteCode = eventLog.inviteCode;
    this.phoneNumber = eventLog.phoneNumber;
    this.signInType = eventLog.signInType;
    this.imagePath = eventLog.imagePath;
    this.imageIdPath = eventLog.imageIdPath;
    this.visitorType = eventLog.visitorType;
    this.inviteCode = eventLog.inviteCode;
  }

  VisitorCheckIn(
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
      this.toCompanyId,
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
      this.inviteCode,
      this.checkOutTimeExpected,
      this.customStep);

  VisitorCheckIn.initPhone(String phone) {
    this.phoneNumber = phone;
  }

  void removeDelivery() {
    this.goods = "";
    this.receiver = "";
  }

  String getGender(BuildContext context) {
    if (gender == 1) {
      return AppLocalizations.of(context).female;
    }
    if (gender == 0) {
      return AppLocalizations.of(context).male;
    }
    return "";
  }

  factory VisitorCheckIn.fromJson(Map<String, dynamic> json) => _$VisitorCheckInFromJson(json);

  Map<String, dynamic> toJson() => _$VisitorCheckInToJson(this);

  factory VisitorCheckIn.createVisitorByInput(BuildContext context, List<CheckInFlow> flows, List<CheckInFlow> flowInit,
      Map<String, TextEditingController> textEditingControllers, VisitorCheckIn visitorBackup) {
    VisitorCheckIn visitorResult = VisitorCheckIn.inital();
    Map<String, dynamic> body = Map<String, dynamic>();
    Map<String, dynamic> bodyBackup = Map<String, dynamic>();
    if (!Utilities().isStringNullOrEmpty(visitorBackup.customStep)) {
      bodyBackup = json.decode(visitorBackup.customStep);
    }
    for (var item in flowInit) {
      switch (item.stepCode) {
        case StepCode.FULL_NAME:
          {
            if (textEditingControllers[StepCode.FULL_NAME]?.text?.isNotEmpty == true) {
              visitorResult.fullName = textEditingControllers[StepCode.FULL_NAME]?.text;
            } else if (!flows.contains(item)) {
              visitorResult.fullName = visitorBackup.fullName;
            }
            break;
          }
        case StepCode.PHONE_NUMBER:
          {
            if (textEditingControllers[StepCode.PHONE_NUMBER]?.text?.isNotEmpty == true) {
              visitorResult.phoneNumber = textEditingControllers[StepCode.PHONE_NUMBER]?.text;
            } else if (!flows.contains(item)) {
              visitorResult.phoneNumber = visitorBackup.phoneNumber;
            }
            break;
          }
        case StepCode.FROM_COMPANY:
          {
            if (textEditingControllers[StepCode.FROM_COMPANY]?.text?.isNotEmpty == true) {
              visitorResult.fromCompany = textEditingControllers[StepCode.FROM_COMPANY]?.text;
            } else if (!flows.contains(item)) {
              visitorResult.fromCompany = visitorBackup.fromCompany;
            }
            break;
          }
        case StepCode.TO_COMPANY:
          {
            if (textEditingControllers[StepCode.TO_COMPANY]?.text?.isNotEmpty == true) {
              visitorResult.toCompany = textEditingControllers[StepCode.TO_COMPANY]?.text;
            } else if (!flows.contains(item)) {
              visitorResult.toCompany = visitorBackup.toCompany;
              visitorResult.toCompanyId = visitorBackup.toCompanyId;
            }
            break;
          }
        case StepCode.PURPOSE:
          {
            if (textEditingControllers[StepCode.PURPOSE]?.text?.isNotEmpty == true) {
              visitorResult.purpose = textEditingControllers[StepCode.PURPOSE]?.text;
            } else if (!flows.contains(item)) {
              visitorResult.purpose = visitorBackup.purpose;
            }
            break;
          }
        case StepCode.ID_CARD:
          {
            if (textEditingControllers[StepCode.ID_CARD]?.text?.isNotEmpty == true) {
              visitorResult.idCard = textEditingControllers[StepCode.ID_CARD]?.text;
            } else if (!flows.contains(item)) {
              visitorResult.idCard = visitorBackup.idCard;
            }
            break;
          }
        case StepCode.EMAIL:
          {
            if (textEditingControllers[StepCode.EMAIL]?.text?.isNotEmpty == true) {
              visitorResult.email = textEditingControllers[StepCode.EMAIL]?.text;
            } else if (!flows.contains(item)) {
              visitorResult.email = visitorBackup.email;
            }
            break;
          }
        case StepCode.CARD_NO:
          {
            if (textEditingControllers[StepCode.CARD_NO]?.text?.isNotEmpty == true) {
              visitorResult.cardNo = textEditingControllers[StepCode.CARD_NO]?.text;
            } else if (!flows.contains(item)) {
              visitorResult.cardNo = visitorBackup.cardNo;
            }
            break;
          }
        case StepCode.VISITOR_POSITION:
          {
            if (textEditingControllers[StepCode.VISITOR_POSITION]?.text?.isNotEmpty == true) {
              visitorResult.visitorPosition = textEditingControllers[StepCode.VISITOR_POSITION]?.text;
            } else if (!flows.contains(item)) {
              visitorResult.visitorPosition = visitorBackup.visitorPosition;
            }
            break;
          }
        case StepCode.GOODS:
          {
            if (textEditingControllers[StepCode.GOODS]?.text?.isNotEmpty == true) {
              visitorResult.goods = textEditingControllers[StepCode.GOODS]?.text;
            } else if (!flows.contains(item)) {
              visitorResult.goods = visitorBackup.goods;
            }
            break;
          }
        case StepCode.RECEIVER:
          {
            if (textEditingControllers[StepCode.RECEIVER]?.text?.isNotEmpty == true) {
              visitorResult.receiver = textEditingControllers[StepCode.RECEIVER]?.text;
            } else if (!flows.contains(item)) {
              visitorResult.receiver = visitorBackup.receiver;
            }
            break;
          }

        case StepCode.GENDER:
          {
            if (textEditingControllers[StepCode.GENDER]?.text?.isNotEmpty == true) {
              int gender;
              if (textEditingControllers[StepCode.GENDER]?.text == AppLocalizations.of(context).female) {
                gender = 1;
              } else if (textEditingControllers[StepCode.GENDER]?.text == AppLocalizations.of(context).male) {
                gender = 0;
              }
              visitorResult.gender = gender;
            } else if (!flows.contains(item)) {
              visitorResult.gender = visitorBackup.gender;
            }
            break;
          }
        case StepCode.PASSPORT_NO:
          {
            if (textEditingControllers[StepCode.PASSPORT_NO]?.text?.isNotEmpty == true) {
              visitorResult.passportNo = textEditingControllers[StepCode.PASSPORT_NO]?.text;
            } else if (!flows.contains(item)) {
              visitorResult.passportNo = visitorBackup.passportNo;
            }
            break;
          }
        case StepCode.NATIONALITY:
          {
            if (textEditingControllers[StepCode.NATIONALITY]?.text?.isNotEmpty == true) {
              visitorResult.nationality = textEditingControllers[StepCode.NATIONALITY]?.text;
            } else if (!flows.contains(item)) {
              visitorResult.nationality = visitorBackup.nationality;
            }
            break;
          }
        case StepCode.BIRTH_DAY:
          {
            if (textEditingControllers[StepCode.BIRTH_DAY]?.text?.isNotEmpty == true) {
              visitorResult.birthDay = textEditingControllers[StepCode.BIRTH_DAY]?.text;
            } else if (!flows.contains(item)) {
              visitorResult.birthDay = visitorBackup.birthDay;
            }
            break;
          }
        case StepCode.PERMANENT_ADDRESS:
          {
            if (textEditingControllers[StepCode.PERMANENT_ADDRESS]?.text?.isNotEmpty == true) {
              visitorResult.permanentAddress = textEditingControllers[StepCode.PERMANENT_ADDRESS]?.text;
            } else if (!flows.contains(item)) {
              visitorResult.permanentAddress = visitorBackup.permanentAddress;
            }
            break;
          }
        case StepCode.ROOM_NO:
          {
            if (textEditingControllers[StepCode.ROOM_NO]?.text?.isNotEmpty == true) {
              visitorResult.departmentRoomNo = textEditingControllers[StepCode.ROOM_NO]?.text;
            } else if (!flows.contains(item)) {
              visitorResult.departmentRoomNo = visitorBackup.departmentRoomNo;
            }
            break;
          }
        case StepCode.CHECKOUT_TIME_EXPECTED:
          {
            if (textEditingControllers[StepCode.CHECKOUT_TIME_EXPECTED]?.text?.isNotEmpty == true) {
              visitorResult.checkOutTimeExpected = textEditingControllers[StepCode.CHECKOUT_TIME_EXPECTED]?.text;
            } else if (!flows.contains(item)) {
              visitorResult.checkOutTimeExpected = visitorBackup.checkOutTimeExpected;
            }
            break;
          }
        case StepCode.VISITOR_TYPE:
          {
            break;
          }
        case StepCode.SCAN_ID_CARD:
          {
            break;
          }
        case StepCode.CONTACT_PERSON:
          {
            break;
          }
        case StepCode.LEGAL_SIGN:
          {
            break;
          }
        case StepCode.PRINT_CARD:
          {
            break;
          }
        case StepCode.CAPTURE_FACE:
          {
            break;
          }
        default:
          {
            if (textEditingControllers[item.stepCode]?.text?.isNotEmpty == true) {
              body[item.stepCode] = textEditingControllers[item.stepCode]?.text;
            } else if (!flows.contains(item)) {
              body[item.stepCode] = bodyBackup[item.stepCode];
            }
            break;
          }
      }
    }
    visitorResult.survey = visitorBackup.survey;
    if (body.isNotEmpty) {
      visitorResult.customStep = jsonEncode(body);
    }
    return visitorResult;
  }

  factory VisitorCheckIn.createVisitorByFlow(List<CheckInFlow> flows, VisitorCheckIn visitorBackup) {
    VisitorCheckIn visitorResult = VisitorCheckIn.inital();
    Map<String, dynamic> body = Map<String, dynamic>();
    Map<String, dynamic> bodyBackup = Map<String, dynamic>();
    if (!Utilities().isStringNullOrEmpty(visitorBackup.customStep)) {
      bodyBackup = json.decode(visitorBackup.customStep);
    }
    for (var element in flows) {
      switch (element.stepCode) {
        case StepCode.FULL_NAME:
          {
            if (element.getRequestType() != RequestType.ALWAYS && element.getRequestType() != RequestType.ALWAYS_NO) {
              visitorResult.fullName = visitorBackup.fullName;
            }
            break;
          }
        case StepCode.PHONE_NUMBER:
          {
            if (element.getRequestType() != RequestType.ALWAYS && element.getRequestType() != RequestType.ALWAYS_NO) {
              visitorResult.phoneNumber = visitorBackup.phoneNumber;
            }
            break;
          }
        case StepCode.FROM_COMPANY:
          {
            if (element.getRequestType() != RequestType.ALWAYS && element.getRequestType() != RequestType.ALWAYS_NO) {
              visitorResult.fromCompany = visitorBackup.fromCompany;
            }
            break;
          }
        case StepCode.TO_COMPANY:
          {
            if (element.getRequestType() != RequestType.ALWAYS && element.getRequestType() != RequestType.ALWAYS_NO) {
              visitorResult.toCompany = visitorBackup.toCompany;
            }
            break;
          }
        case StepCode.PURPOSE:
          {
            if (element.getRequestType() != RequestType.ALWAYS && element.getRequestType() != RequestType.ALWAYS_NO) {
              visitorResult.purpose = visitorBackup.purpose;
            }
            break;
          }
        case StepCode.ID_CARD:
          {
//            if (element.getRequestType() != RequestType.ALWAYS &&
//                element.getRequestType() != RequestType.ALWAYS_NO) {
            visitorResult.idCard = visitorBackup.idCard;
//            }
            break;
          }
        case StepCode.EMAIL:
          {
            if (element.getRequestType() != RequestType.ALWAYS && element.getRequestType() != RequestType.ALWAYS_NO) {
              visitorResult.email = visitorBackup.email;
            }
            break;
          }
        case StepCode.CARD_NO:
          {
            if (element.getRequestType() != RequestType.ALWAYS && element.getRequestType() != RequestType.ALWAYS_NO) {
              visitorResult.cardNo = visitorBackup.cardNo;
            }
            break;
          }
        case StepCode.VISITOR_POSITION:
          {
            if (element.getRequestType() != RequestType.ALWAYS && element.getRequestType() != RequestType.ALWAYS_NO) {
              visitorResult.visitorPosition = visitorBackup.visitorPosition;
            }
            break;
          }
        case StepCode.GOODS:
          {
            if (element.getRequestType() != RequestType.ALWAYS && element.getRequestType() != RequestType.ALWAYS_NO) {
              visitorResult.goods = visitorBackup.goods;
            }
            break;
          }
        case StepCode.RECEIVER:
          {
            if (element.getRequestType() != RequestType.ALWAYS && element.getRequestType() != RequestType.ALWAYS_NO) {
              visitorResult.receiver = visitorBackup.receiver;
            }
            break;
          }

        case StepCode.GENDER:
          {
//            if (element.getRequestType() != RequestType.ALWAYS &&
//                element.getRequestType() != RequestType.ALWAYS_NO) {
            visitorResult.gender = visitorBackup.gender;
//            }
            break;
          }
        case StepCode.PASSPORT_NO:
          {
//            if (element.getRequestType() != RequestType.ALWAYS &&
//                element.getRequestType() != RequestType.ALWAYS_NO) {
            visitorResult.passportNo = visitorBackup.passportNo;
//            }
            break;
          }
        case StepCode.NATIONALITY:
          {
//            if (element.getRequestType() != RequestType.ALWAYS &&
//                element.getRequestType() != RequestType.ALWAYS_NO) {
            visitorResult.nationality = visitorBackup.nationality;
//            }
            break;
          }
        case StepCode.BIRTH_DAY:
          {
//            if (element.getRequestType() != RequestType.ALWAYS &&
//                element.getRequestType() != RequestType.ALWAYS_NO) {
            visitorResult.birthDay = visitorBackup.birthDay;
//            }
            break;
          }
        case StepCode.PERMANENT_ADDRESS:
          {
//            if (element.getRequestType() != RequestType.ALWAYS &&
//                element.getRequestType() != RequestType.ALWAYS_NO) {
            visitorResult.permanentAddress = visitorBackup.permanentAddress;
//            }
            break;
          }
        case StepCode.ROOM_NO:
          {
            if (element.getRequestType() != RequestType.ALWAYS && element.getRequestType() != RequestType.ALWAYS_NO) {
              visitorResult.departmentRoomNo = visitorBackup.departmentRoomNo;
            }
            break;
          }
        case StepCode.CHECKOUT_TIME_EXPECTED:
          {
            if (element.getRequestType() != RequestType.ALWAYS && element.getRequestType() != RequestType.ALWAYS_NO) {
              visitorResult.checkOutTimeExpected = visitorBackup.checkOutTimeExpected;
            }
            break;
          }
        case StepCode.VISITOR_TYPE:
          {
            break;
          }
        case StepCode.SCAN_ID_CARD:
          {
            break;
          }
        case StepCode.CONTACT_PERSON:
          {
            break;
          }
        case StepCode.LEGAL_SIGN:
          {
            break;
          }
        case StepCode.PRINT_CARD:
          {
            break;
          }
        case StepCode.CAPTURE_FACE:
          {
            break;
          }
        default:
          {
            if (element.getRequestType() != RequestType.ALWAYS && element.getRequestType() != RequestType.ALWAYS_NO) {
              body[element.stepCode] = bodyBackup[element.stepCode];
            }
            break;
          }
      }
    }
    visitorResult.imageIdPath = visitorBackup.imageIdPath;
    visitorResult.imagePath = visitorBackup.imagePath;
    visitorResult.survey = visitorBackup.survey;
//    if (body.isNotEmpty) {
//      visitorResult.customStep = jsonEncode(body);
//    }
    visitorResult.customStep = "{\"6hcslwdo332h\":\"Cuop bien 7 mau\",\"2dh829c63f\":\"Tim xanh buong chuoi\"}";
    return visitorResult;
  }

  @override
  String toString() {
    return 'VisitorCheckIn{id: $id, fullName: $fullName, email: $email, phoneNumber: $phoneNumber, idCard: $idCard, purpose: $purpose, visitorId: $visitorId, visitorType: $visitorType, fromCompany: $fromCompany, toCompany: $toCompany, contactPersonId: $contactPersonId, faceCaptureRepoId: $faceCaptureRepoId, signInBy: $signInBy, signInType: $signInType, imagePath: $imagePath, toCompanyId: $toCompanyId, cardNo: $cardNo, goods: $goods, receiver: $receiver, visitorPosition: $visitorPosition}';
  }
}
