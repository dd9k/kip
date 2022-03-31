import 'package:json_annotation/json_annotation.dart';

part 'LocationInfor.g.dart';

@JsonSerializable()
class LocationInfor {
  @JsonKey(name: 'id')
  double id;

  @JsonKey(name: 'code')
  String code;

  @JsonKey(name: 'name')
  String name;

  @JsonKey(name: 'address')
  String address;

  @JsonKey(name: 'locationPhone')
  String locationPhone;

  LocationInfor(double id, String code, String name, String address, String locationPhone) {
    this.id = id;
    this.code = code;
    this.name = name;
    this.address = address;
    this.locationPhone = locationPhone;
  }

  LocationInfor._();

  factory LocationInfor.fromJson(Map<String, dynamic> json) => _$LocationInforFromJson(json);
}
