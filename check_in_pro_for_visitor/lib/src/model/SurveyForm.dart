import 'package:json_annotation/json_annotation.dart';

import 'CovidModel.dart';
import 'CustomSurvey.dart';

part 'SurveyForm.g.dart';

@JsonSerializable()
class SurveyForm {
  static const String EMBEDDED_LINK = "EMBEDDED_LINK";
  static const String CUSTOM_FORM = "CUSTOM_FORM";

  @JsonKey(name: 'status')
  bool status;

  @JsonKey(name: 'type')
  String type;

  @JsonKey(name: 'captureFaceRepoId')
  double captureFaceRepoId;

  @JsonKey(name: 'customFormData')
  CustomSurvey customFormData;

  @JsonKey(name: 'embeddedLinkData')
  CovidModel embeddedLinkData;

  SurveyForm(this.status, this.type, this.captureFaceRepoId, this.customFormData, this.embeddedLinkData);

  SurveyForm._();

  factory SurveyForm.fromJson(Map<String, dynamic> json) => _$SurveyFormFromJson(json);

  Map<String, dynamic> toJson() => _$SurveyFormToJson(this);
}