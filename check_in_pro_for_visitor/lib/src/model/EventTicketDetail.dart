import 'package:check_in_pro_for_visitor/src/model/EventTicket.dart';
import 'package:json_annotation/json_annotation.dart';

import 'ETOrderInfo.dart';

part 'EventTicketDetail.g.dart';

@JsonSerializable()
class EventTicketDetail {
  @JsonKey(name: 'eventInfo')
  EventTicket eventInfo;

  @JsonKey(name: 'orderInfo')
  List<ETOrderInfo> orderInfo;

  EventTicketDetail.init();

  EventTicketDetail(this.eventInfo, this.orderInfo);

  factory EventTicketDetail.fromJson(Map<String, dynamic> json) => _$EventTicketDetailFromJson(json);

  Map<String, dynamic> toJson() => _$EventTicketDetailToJson(this);
}