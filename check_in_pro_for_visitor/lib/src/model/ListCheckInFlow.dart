import 'package:json_annotation/json_annotation.dart';

import 'CheckInFlowObject.dart';

part 'ListCheckInFlow.g.dart';

@JsonSerializable()
class ListCheckInFlow {
  @JsonKey(name: 'flows')
  List<CheckInFlowObject> flows;

  @JsonKey(name: 'badgeTemplateCode')
  String badgeTemplateCode;

  ListCheckInFlow._();

  ListCheckInFlow(this.flows, this.badgeTemplateCode);

  factory ListCheckInFlow.fromJson(Map<String, dynamic> json) => _$ListCheckInFlowFromJson(json);
}
