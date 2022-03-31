// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'CovidModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CovidModel _$CovidModelFromJson(Map<String, dynamic> json) {
  return CovidModel(
    json['status'] as int,
    json['title'] as String,
    json['titleColor'] as String,
    json['description'] as String,
    json['url'] as String,
  );
}

Map<String, dynamic> _$CovidModelToJson(CovidModel instance) =>
    <String, dynamic>{
      'status': instance.status,
      'title': instance.title,
      'titleColor': instance.titleColor,
      'description': instance.description,
      'url': instance.url,
    };
