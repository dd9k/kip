import 'package:json_annotation/json_annotation.dart';

part 'CompanyLanguage.g.dart';

@JsonSerializable()
class CompanyLanguage {
  @JsonKey(name: 'languageCode')
  String languageCode;

  @JsonKey(name: 'languageName')
  String languageName;

  CompanyLanguage(String languageCode, String languageName) {
    this.languageCode = languageCode;
    this.languageName = languageName;
  }

  factory CompanyLanguage.fromJson(Map<String, dynamic> json) => _$CompanyLanguageFromJson(json);
}
