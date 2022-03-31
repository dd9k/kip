// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'CustomSurvey.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CustomSurvey _$CustomSurveyFromJson(Map<String, dynamic> json) {
  return CustomSurvey(
    (json['surveyId'] as num)?.toDouble(),
    json['title'] as String,
    json['bodyTemperature'] as int,
    (json['questions'] as List)
        ?.map((e) => e == null
            ? null
            : QuestionSurvey.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$CustomSurveyToJson(CustomSurvey instance) =>
    <String, dynamic>{
      'surveyId': instance.surveyId,
      'title': instance.title,
      'bodyTemperature': instance.bodyTemperature,
      'questions': instance.questions,
    };
