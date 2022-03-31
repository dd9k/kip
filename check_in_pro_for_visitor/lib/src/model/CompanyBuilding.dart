import 'package:json_annotation/json_annotation.dart';

part 'CompanyBuilding.g.dart';

@JsonSerializable()
class CompanyBuilding {
  @JsonKey(name: 'id')
  double id;

  @JsonKey(name: 'companyName')
  String companyName;

  @JsonKey(name: 'shortName')
  String shortName;

  @JsonKey(name: 'representativeName')
  String representativeName;

  @JsonKey(name: 'representativeEmail')
  String representativeEmail;

  @JsonKey(name: 'representativeId')
  double representativeId;

  @JsonKey(name: 'floor')
  String floor;

  @JsonKey(name: 'note')
  String note;

  @JsonKey(name: 'isActive')
  int isActive;

  @JsonKey(name: 'companyId')
  double companyId;

  @JsonKey(name: 'logoPath')
  String logoPath;

  @JsonKey(ignore: true)
  String logoPathLocal;

  @JsonKey(ignore: true)
  int index;

  @JsonKey(name: 'logoRepoId')
  int logoRepoId;

  CompanyBuilding._();

  CompanyBuilding(this.id, this.companyName, this.shortName, this.representativeName, this.representativeEmail, this.representativeId,
      this.floor, this.note, this.isActive, this.companyId, this.logoPath, this.logoRepoId);

  CompanyBuilding.init(
      this.id,
      this.companyName,
      this.shortName,
      this.representativeName,
      this.representativeEmail,
      this.representativeId,
      this.floor,
      this.note,
      this.isActive,
      this.companyId,
      this.logoPath,
      this.logoPathLocal,
      this.logoRepoId,
      this.index);

  factory CompanyBuilding.fromJson(Map<String, dynamic> json) => _$CompanyBuildingFromJson(json);

  Map<String, dynamic> toJson() => _$CompanyBuildingToJson(this);
}
