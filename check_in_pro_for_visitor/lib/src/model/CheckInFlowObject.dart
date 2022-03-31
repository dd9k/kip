import 'package:check_in_pro_for_visitor/src/model/CheckInFlow.dart';
import 'package:json_annotation/json_annotation.dart';

part 'CheckInFlowObject.g.dart';

@JsonSerializable()
class CheckInFlowObject {
  @JsonKey(name: 'flow')
  List<CheckInFlow> flow;

  @JsonKey(name: 'settingKey')
  String settingKey;

  CheckInFlowObject._();

  CheckInFlowObject(this.flow, this.settingKey);

  factory CheckInFlowObject.fromJson(Map<String, dynamic> json) => _$CheckInFlowObjectFromJson(json);
}
