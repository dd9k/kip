// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ListContact.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ListContact _$ListContactFromJson(Map<String, dynamic> json) {
  return ListContact(
    (json['contactPersons'] as List)
        ?.map((e) => e == null
            ? null
            : ContactPerson.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    json['totalCount'] as int,
  );
}

Map<String, dynamic> _$ListContactToJson(ListContact instance) =>
    <String, dynamic>{
      'contactPersons': instance.listContact,
      'totalCount': instance.totalCount,
    };
