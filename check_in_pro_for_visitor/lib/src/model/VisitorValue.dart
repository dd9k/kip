import 'package:check_in_pro_for_visitor/src/constants/Constants.dart';
import 'package:json_annotation/json_annotation.dart';

part 'VisitorValue.g.dart';

@JsonSerializable()
class VisitorValue {
  @JsonKey(name: 'settingKey', ignore: true)
  String settingKey;

  @JsonKey(name: 'vi')
  String vi;

  @JsonKey(name: 'en')
  String en;

  factory VisitorValue.fromJson(Map<String, dynamic> json) => _$VisitorValueFromJson(json);

  Map<String, dynamic> toJson() => _$VisitorValueToJson(this);

  String getValue(String lang) {
    switch (lang) {
      case Constants.VN_CODE:
        {
          return vi;
        }
      case Constants.EN_CODE:
        {
          return en;
        }
      default:
        {
          return en;
        }
    }
  }

  VisitorValue.init(this.settingKey, this.vi, this.en);

  VisitorValue(this.vi, this.en);

  VisitorValue._();
}
