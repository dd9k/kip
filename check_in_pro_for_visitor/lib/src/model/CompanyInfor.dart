import 'package:json_annotation/json_annotation.dart';

part 'CompanyInfor.g.dart';

@JsonSerializable()
class CompanyInfor {
  @JsonKey(name: 'code')
  String code;

  @JsonKey(name: 'companyName')
  String name;

  @JsonKey(name: 'companyId')
  double id;

  @JsonKey(name: 'address')
  String address;

  @JsonKey(name: 'limitStorage')
  double limitStorage;

  @JsonKey(name: 'usageStorage')
  double usageStorage;

  CompanyInfor(String code, String name, double id, String address, double limitStorage, double usageStorage) {
    this.code = code;
    this.name = name;
    this.id = id;
    this.address = address;
    this.limitStorage = limitStorage;
    this.usageStorage = usageStorage;
  }

  factory CompanyInfor.fromJson(Map<String, dynamic> json) => _$CompanyInforFromJson(json);

  double getPercentStorage() {
    try {
      return (usageStorage / limitStorage) * 100;
    } catch(e) {
      return 0;
    }
  }

  bool isWarning() {
    return getPercentStorage() >= 90;
  }
}
