import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:json_annotation/json_annotation.dart';

part 'Document.g.dart';

@JsonSerializable()
class Document {
  @JsonKey(name: 'documentName')
  String documentName;

  @JsonKey(name: 'description')
  String description;

  Document._();

  Document(String documentName, String description) {
    this.documentName = documentName;
    this.description = description;
  }

  factory Document.fromJson(Map<String, dynamic> json) => _$DocumentFromJson(json);
}
