import 'package:json_annotation/json_annotation.dart';

part 'Authenticate.g.dart';

@JsonSerializable()
class Authenticate {
  @JsonKey(name: 'accessToken')
  String accessToken;

  @JsonKey(name: 'refreshToken')
  String refreshToken;

  @JsonKey(name: 'expired')
  String expired;

  @JsonKey(name: 'tokenType')
  String tokenType;

  Authenticate._();

  Authenticate(String accessToken, String refreshToken, String expired, String tokenType) {
    this.accessToken = accessToken;
    this.refreshToken = refreshToken;
    this.expired = expired;
    this.tokenType = tokenType;
  }

  factory Authenticate.fromJson(Map<String, dynamic> json) => _$AuthenticateFromJson(json);

  Map<String, dynamic> toJson() => _$AuthenticateToJson(this);
}
