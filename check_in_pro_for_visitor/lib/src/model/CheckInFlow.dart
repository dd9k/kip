import 'dart:convert';

import 'package:check_in_pro_for_visitor/src/constants/Constants.dart';
import 'package:check_in_pro_for_visitor/src/utilities/Utilities.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

import 'VisitorCheckIn.dart';

part 'CheckInFlow.g.dart';

enum RequestType { ALWAYS, ALWAYS_NO, FIRST, FIRST_NO, HIDDEN }

@JsonSerializable()
class CheckInFlow {
  @JsonKey(name: 'id')
  double id;

  @JsonKey(name: 'templateCode')
  String templateCode;

  @JsonKey(name: 'templateName')
  String templateName;

  @JsonKey(name: 'stepName')
  String stepName;

  @JsonKey(name: 'stepCode')
  String stepCode;

  @JsonKey(name: 'stepType')
  String stepType;

  @JsonKey(name: 'visitorType')
  String visitorType;

  @JsonKey(name: 'isRequired')
  int isRequired;

  @JsonKey(name: 'sort')
  String sort;

  @JsonKey(ignore: true)
  int index = 0;

  @JsonKey(ignore: true)
  String initValue = '';

  @JsonKey(ignore: true)
  bool isDelivery = false;

  @JsonKey(ignore: true)
  bool isVisible = true;

  CheckInFlow._();

  CheckInFlow(this.id, this.templateCode, this.templateName, this.stepName, this.stepCode, this.stepType,
      this.visitorType, this.isRequired, this.sort);

  CheckInFlow.hardcode(String stepName, String stepCode, String stepType, int isRequired, String sort) {
    this.stepName = stepName;
    this.stepCode = stepCode;
    this.stepType = stepType;
    this.isRequired = isRequired;
    this.stepCode = stepCode;
    this.sort = sort;
  }

  factory CheckInFlow.fromJson(Map<String, dynamic> json) => _$CheckInFlowFromJson(json);

  RequestType getRequestType() {
    switch (isRequired) {
      case 0:
        {
          return RequestType.ALWAYS_NO;
        }
      case 1:
        {
          return RequestType.ALWAYS;
        }
      case 2:
        {
          return RequestType.FIRST_NO;
        }
      case 3:
        {
          return RequestType.FIRST;
        }
      case 4:
        {
          return RequestType.HIDDEN;
        }
      default:
        {
          return RequestType.FIRST;
        }
    }
  }

  String buildInitValue(BuildContext context, VisitorCheckIn visitorCheckIn) {
    var initValue = "";
    switch (stepCode) {
      case StepCode.FULL_NAME:
        {
          initValue = visitorCheckIn.fullName ?? "";
          break;
        }
      case StepCode.PHONE_NUMBER:
        {
          initValue = visitorCheckIn.phoneNumber ?? "";
          break;
        }
      case StepCode.EMAIL:
        {
          initValue = visitorCheckIn.email ?? "";
          break;
        }
      case StepCode.FROM_COMPANY:
        {
          initValue = visitorCheckIn.fromCompany ?? "";
          break;
        }
      case StepCode.TO_COMPANY:
        {
          initValue = visitorCheckIn.toCompany ?? "";
          break;
        }
      case StepCode.PURPOSE:
        {
          initValue = visitorCheckIn.purpose ?? "";
          break;
        }
      case StepCode.ID_CARD:
        {
          initValue = visitorCheckIn.idCard ?? "";
          break;
        }
      case StepCode.CARD_NO:
        {
          initValue = visitorCheckIn.cardNo ?? "";
          break;
        }
      case StepCode.GOODS:
        {
          initValue = visitorCheckIn.goods ?? "";
          break;
        }
      case StepCode.RECEIVER:
        {
          initValue = visitorCheckIn.receiver ?? "";
          break;
        }
      case StepCode.VISITOR_POSITION:
        {
          initValue = visitorCheckIn.visitorPosition ?? "";
          break;
        }
      case StepCode.GENDER:
        {
          initValue = visitorCheckIn.getGender(context);
          break;
        }
      case StepCode.PASSPORT_NO:
        {
          initValue = visitorCheckIn.passportNo ?? "";
          break;
        }
      case StepCode.NATIONALITY:
        {
          initValue = visitorCheckIn.nationality ?? "";
          break;
        }
      case StepCode.BIRTH_DAY:
        {
          initValue = visitorCheckIn.birthDay ?? "";
          break;
        }
      case StepCode.PERMANENT_ADDRESS:
        {
          initValue = visitorCheckIn.permanentAddress ?? "";
          break;
        }
      case StepCode.ROOM_NO:
        {
          initValue = visitorCheckIn.departmentRoomNo ?? "";
          break;
        }
      case StepCode.CHECKOUT_TIME_EXPECTED:
        {
          initValue = visitorCheckIn.checkOutTimeExpected ?? "";
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
          Map<String, dynamic> body = Map<String, dynamic>();
          if (!Utilities().isStringNullOrEmpty(visitorCheckIn.customStep)) {
            body = json.decode(visitorCheckIn.customStep);
          }
          if (body.containsKey(stepCode)) {
            initValue = body[stepCode] ?? "";
          }
          break;
        }
    }
    return initValue;
  }
}
