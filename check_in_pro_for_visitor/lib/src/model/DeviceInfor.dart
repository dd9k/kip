import 'package:json_annotation/json_annotation.dart';

part 'DeviceInfor.g.dart';

@JsonSerializable()
class DeviceInfor {
  @JsonKey(name: 'id')
  int id;

  @JsonKey(name: 'name')
  String name;

  @JsonKey(name: 'type')
  String type;

  @JsonKey(name: 'deviceId')
  String deviceId;

  @JsonKey(name: 'locationId')
  double locationId;

  @JsonKey(name: 'branchId')
  double branchId;

  @JsonKey(name: 'branchCode')
  String branchCode;

  @JsonKey(name: 'osVersion')
  String osVersion;

  @JsonKey(name: 'printAddress')
  String printAddress;

  @JsonKey(name: 'timeout')
  int timeout;

  @JsonKey(name: 'appVersion')
  String appVersion;

  @JsonKey(name: 'ipAddress')
  String ipAddress;

  DeviceInfor.init();

  DeviceInfor(this.id, this.name, this.type, this.deviceId, this.locationId, this.branchId, this.branchCode,
      this.osVersion, this.printAddress, this.timeout, this.appVersion, this.ipAddress);

  factory DeviceInfor.fromJson(Map<String, dynamic> json) => _$DeviceInforFromJson(json);

  Map<String, dynamic> toJson() => _$DeviceInforToJson(this);
}
