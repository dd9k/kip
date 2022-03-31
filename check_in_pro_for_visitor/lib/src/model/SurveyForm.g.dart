// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'SurveyForm.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SurveyForm _$SurveyFormFromJson(Map<String, dynamic> json) {
  return SurveyForm(
    json['status'] as bool,
    json['type'] as String,
    (json['captureFaceRepoId'] as num)?.toDouble(),
    json['customFormData'] == null
        ? null
        : CustomSurvey.fromJson(json['customFormData'] as Map<String, dynamic>),
    json['embeddedLinkData'] == null
        ? null
        : CovidModel.fromJson(json['embeddedLinkData'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$SurveyFormToJson(SurveyForm instance) =>
    <String, dynamic>{
      'status': instance.status,
      'type': instance.type,
      'captureFaceRepoId': instance.captureFaceRepoId,
      'customFormData': instance.customFormData,
      'embeddedLinkData': instance.embeddedLinkData,
    };
