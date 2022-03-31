// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Document.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Document _$DocumentFromJson(Map<String, dynamic> json) {
  return Document(
    json['documentName'] as String,
    json['description'] as String,
  );
}

Map<String, dynamic> _$DocumentToJson(Document instance) => <String, dynamic>{
      'documentName': instance.documentName,
      'description': instance.description,
    };
