// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ListData.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ListData _$ListDataFromJson(Map<String, dynamic> json) {
  return ListData(
    (json['data'] as List)
        ?.map((e) =>
            e == null ? null : Document.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    json['totalData'] as int,
  );
}

Map<String, dynamic> _$ListDataToJson(ListData instance) => <String, dynamic>{
      'data': instance.data,
      'totalData': instance.totalData,
    };
