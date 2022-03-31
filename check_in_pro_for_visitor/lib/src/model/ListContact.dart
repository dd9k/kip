import 'package:check_in_pro_for_visitor/src/model/ContactPerson.dart';
import 'package:json_annotation/json_annotation.dart';

part 'ListContact.g.dart';

@JsonSerializable()
class ListContact {
  @JsonKey(name: 'contactPersons')
  List<ContactPerson> listContact = List();

  @JsonKey(name: 'totalCount')
  int totalCount;

  ListContact._();

  ListContact(this.listContact, this.totalCount);

  factory ListContact.fromJson(Map<String, dynamic> json) => _$ListContactFromJson(json);
}
