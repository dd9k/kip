// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'RepoUpload.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RepoUpload _$RepoUploadFromJson(Map<String, dynamic> json) {
  return RepoUpload(
    json['captureFaceFile'] as String,
    (json['captureFaceRepoId'] as num)?.toDouble(),
  );
}

Map<String, dynamic> _$RepoUploadToJson(RepoUpload instance) =>
    <String, dynamic>{
      'captureFaceFile': instance.captureFaceFile,
      'captureFaceRepoId': instance.captureFaceRepoId,
    };
