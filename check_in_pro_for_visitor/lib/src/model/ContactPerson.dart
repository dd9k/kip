import 'package:json_annotation/json_annotation.dart';

part 'ContactPerson.g.dart';

@JsonSerializable()
class ContactPerson {
  @JsonKey(name: 'id')
  double id;

  @JsonKey(name: 'userName')
  String userName;

  @JsonKey(name: 'email')
  String email;

  @JsonKey(name: 'phone')
  String phone;

  @JsonKey(name: 'description')
  String description;

  @JsonKey(name: 'fullName')
  String fullName;

  @JsonKey(name: 'firstName')
  String firstName;

  @JsonKey(name: 'lastName')
  String lastName;

  @JsonKey(name: 'companyName')
  String companyName;

  @JsonKey(name: 'avatarFileName')
  String avatarFileName;

  @JsonKey(name: 'gender')
  String gender;

  @JsonKey(name: 'workPhoneExt')
  String workPhoneExt;

  @JsonKey(name: 'workPhoneNumber')
  String workPhoneNumber;

  @JsonKey(name: 'jobTitle')
  String jobTitle;

  @JsonKey(name: 'department')
  String department;

  @JsonKey(ignore: true)
  String logoPathLocal;

  @JsonKey(ignore: true)
  int index;

  ContactPerson._();

  ContactPerson(
      this.id,
      this.userName,
      this.email,
      this.phone,
      this.description,
      this.fullName,
      this.firstName,
      this.lastName,
      this.companyName,
      this.avatarFileName,
      this.gender,
      this.workPhoneExt,
      this.workPhoneNumber,
      this.jobTitle,
      this.department);

  ContactPerson.init(
      this.id,
      this.userName,
      this.email,
      this.phone,
      this.description,
      this.fullName,
      this.firstName,
      this.lastName,
      this.companyName,
      this.avatarFileName,
      this.gender,
      this.workPhoneExt,
      this.workPhoneNumber,
      this.jobTitle,
      this.logoPathLocal,
      this.index,
      this.department);

  factory ContactPerson.fromJson(Map<String, dynamic> json) => _$ContactPersonFromJson(json);

  Map<String, dynamic> toJson() => _$ContactPersonToJson(this);
}
