import 'package:check_in_pro_for_visitor/src/model/QuestionSurvey.dart';
import 'package:json_annotation/json_annotation.dart';

part 'CustomSurvey.g.dart';

@JsonSerializable()
class CustomSurvey {
  @JsonKey(name: 'surveyId')
  double surveyId;

  @JsonKey(name: 'title')
  String title;

  @JsonKey(name: 'bodyTemperature')
  int bodyTemperature;

  @JsonKey(name: 'questions')
  List<QuestionSurvey> questions;

  CustomSurvey._();

  CustomSurvey(this.surveyId, this.title, this.bodyTemperature, this.questions);

  factory CustomSurvey.fromJson(Map<String, dynamic> json) => _$CustomSurveyFromJson(json);

  Map<String, dynamic> toJson() => _$CustomSurveyToJson(this);
}