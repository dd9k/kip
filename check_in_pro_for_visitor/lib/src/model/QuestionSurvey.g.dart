// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'QuestionSurvey.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

QuestionSurvey _$QuestionSurveyFromJson(Map<String, dynamic> json) {
  return QuestionSurvey(
    json['question'] as String,
    json['id'] as int,
    json['answerOption'] as List,
    (json['answer'] as List)?.map((e) => e as String)?.toList(),
    json['type'] as String,
    json['subType'] as String,
    json['isRequired'] as int,
    json['isHidden'] as int,
    json['sort'] as int,
  );
}

Map<String, dynamic> _$QuestionSurveyToJson(QuestionSurvey instance) =>
    <String, dynamic>{
      'question': instance.question,
      'id': instance.id,
      'answerOption': instance.answerOption,
      'answer': instance.answer,
      'type': instance.type,
      'subType': instance.subType,
      'isRequired': instance.isRequired,
      'isHidden': instance.isHidden,
      'sort': instance.sort,
    };
