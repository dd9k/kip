import 'package:json_annotation/json_annotation.dart';

part 'Configuration.g.dart';

@JsonSerializable()
class Configuration {
  @JsonKey(name: 'id')
  double id;

  @JsonKey(name: 'code')
  String code;

  @JsonKey(name: 'value')
  List<String> value;

  Configuration._();

  Configuration(this.id, this.code, this.value);

  factory Configuration.fromJson(Map<String, dynamic> json) => _$ConfigurationFromJson(json);
}
