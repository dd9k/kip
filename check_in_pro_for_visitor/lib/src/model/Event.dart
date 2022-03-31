import 'package:json_annotation/json_annotation.dart';

part 'Event.g.dart';

@JsonSerializable()
class Event {
  @JsonKey(name: 'id')
  double id;

  @JsonKey(name: 'eventName')
  String eventName;

  @JsonKey(name: 'branchId')
  double branchId;

  @JsonKey(name: 'contactPersonId')
  double contactPersonId;

  @JsonKey(name: 'visitorType')
  String visitorType;

  @JsonKey(name: 'startDate')
  String startDate;

  @JsonKey(name: 'endDate')
  String endDate;

  @JsonKey(name: 'description')
  String description;

  @JsonKey(name: 'coverPathFile')
  String coverPathFile;

  @JsonKey(name: 'coverRepoId')
  double coverRepoId;

  @JsonKey(name: 'companyId')
  double companyId;

  @JsonKey(name: 'siteName')
  String siteName;

  @JsonKey(name: 'siteAddress')
  String siteAddress;

  @JsonKey(ignore: true)
  bool isSelect = false;

  Event._();

  Event(this.id, this.eventName, this.branchId, this.contactPersonId, this.visitorType, this.startDate, this.endDate,
      this.description, this.coverPathFile, this.coverRepoId, this.companyId, this.siteName, this.siteAddress);

  factory Event.fromJson(Map<String, dynamic> json) => _$EventFromJson(json);

  Map<String, dynamic> toJson() => _$EventToJson(this);
}
