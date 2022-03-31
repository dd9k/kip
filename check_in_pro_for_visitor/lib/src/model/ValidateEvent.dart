import 'package:check_in_pro_for_visitor/src/model/VisitorCheckIn.dart';
import 'package:json_annotation/json_annotation.dart';

part 'ValidateEvent.g.dart';

@JsonSerializable()
class ValidateEvent {
  @JsonKey(name: 'status')
  String status;

  @JsonKey(name: 'visitorLog')
  VisitorCheckIn visitor;

  ValidateEvent._();

  ValidateEvent(this.status, this.visitor);

  factory ValidateEvent.fromJson(Map<String, dynamic> json) => _$ValidateEventFromJson(json);
}
