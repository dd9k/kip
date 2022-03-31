import 'package:check_in_pro_for_visitor/src/database/Database.dart';
import 'package:check_in_pro_for_visitor/src/model/EventLog.dart';
import 'package:check_in_pro_for_visitor/src/utilities/Utilities.dart';
import 'package:json_annotation/json_annotation.dart';

part 'EventDetail.g.dart';

@JsonSerializable()
class EventDetail {
  @JsonKey(name: 'id')
  double id;

  @JsonKey(name: 'eventName')
  String eventName;

  @JsonKey(name: 'startDate')
  int startDate;

  @JsonKey(name: 'endDate')
  int endDate;

  @JsonKey(name: 'guests')
  List<EventLog> guests;

  @JsonKey(name: 'badgeTemplate')
  String badgeTemplate;

  EventDetail._();

  EventDetail(this.id, this.eventName, this.startDate, this.endDate, this.guests, this.badgeTemplate);

  EventDetail.copyWith(EventDetail eventDetail) {
    this.id = eventDetail.id;
    this.eventName = eventDetail.eventName;
    this.startDate = eventDetail.startDate;
    this.endDate = eventDetail.endDate;
    this.guests = eventDetail.guests;
    this.badgeTemplate = eventDetail.badgeTemplate;
  }

  EventDetail.copyWithEntity(EventDetailEntry eventDetailEntry) {
    this.id = eventDetailEntry.id;
    this.eventName = eventDetailEntry.eventName;
    this.startDate = eventDetailEntry.startDate;
    this.endDate = eventDetailEntry.endDate;
    this.badgeTemplate = eventDetailEntry.badgeTemplate;
  }

  String getBadgeTemplate(String lang) {
    return Utilities().getStringByLang(badgeTemplate, lang);
  }

  factory EventDetail.fromJson(Map<String, dynamic> json) => _$EventDetailFromJson(json);

  Map<String, dynamic> toJson() => _$EventDetailToJson(this);
}
