import 'package:json_annotation/json_annotation.dart';

part 'RepoUpload.g.dart';

@JsonSerializable()
class RepoUpload {
  @JsonKey(name: 'captureFaceFile')
  String captureFaceFile;

  @JsonKey(name: 'captureFaceRepoId')
  double captureFaceRepoId;

  RepoUpload._();

  RepoUpload(this.captureFaceFile, this.captureFaceRepoId);

  factory RepoUpload.fromJson(Map<String, dynamic> json) => _$RepoUploadFromJson(json);

  Map<String, dynamic> toJson() => _$RepoUploadToJson(this);
}
