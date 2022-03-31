//import 'package:json_annotation/json_annotation.dart';
//
//part 'CustomStep.g.dart';
//
//@JsonSerializable()
//class CustomStep {
//  @JsonKey(name: 'visitorType')
//  List<VisitorType> visitorType;
//
//  @JsonKey(name: 'visitorTypeLang')
//  String visitorTypeLang;
//
//  @JsonKey(name: 'isTakePicture')
//  bool isTakePicture;
//
//  @JsonKey(name: 'picCountdownInterval')
//  int picCountdownInterval;
//
//  @JsonKey(name: 'isScanIdCard')
//  bool isScanIdCard;
//
//  @JsonKey(name: 'isPrintCard')
//  bool isPrintCard;
//
//  @JsonKey(name: 'isSurvey')
//  bool isSurvey;
//
////  @JsonKey(name: 'healthDeclarationInfo')
////  CovidModel covidModel;
//
//  @JsonKey(name: 'ratingType')
//  String ratingType;
//
//  @JsonKey(name: 'allowToDisplayContactPerson')
//  bool allowToDisplayContactPerson;
//
//  @JsonKey(name: 'touchless')
//  TouchlessModel touchlessModel;
//
//  @JsonKey(name: 'waitingConfig')
//  SaverModel saverModel;
//
//  ConfigKiosk(this.visitorType, this.visitorTypeLang, this.isTakePicture, this.picCountdownInterval, this.isScanIdCard,
//      this.isPrintCard, this.isSurvey, this.ratingType, this.allowToDisplayContactPerson, this.touchlessModel, this.saverModel);
//
//  factory ConfigKiosk.fromJson(Map<String, dynamic> json) => _$ConfigKioskFromJson(json);
//
//  Map<String, dynamic> toJson() => _$ConfigKioskToJson(this);
//}
