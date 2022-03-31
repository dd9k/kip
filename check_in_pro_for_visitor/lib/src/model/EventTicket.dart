import 'package:check_in_pro_for_visitor/src/constants/Constants.dart';
import 'package:check_in_pro_for_visitor/src/database/Database.dart';
import 'package:check_in_pro_for_visitor/src/utilities/Utilities.dart';
import 'package:json_annotation/json_annotation.dart';

part 'EventTicket.g.dart';

@JsonSerializable()
class EventTicket {
  @JsonKey(name: 'id')
  double id;

  @JsonKey(name: 'eventName')
  String eventName;

  @JsonKey(name: 'siteName')
  String siteName;

  @JsonKey(name: 'siteAddress')
  String siteAddress;

  @JsonKey(name: 'eventType')
  String eventType;

  @JsonKey(name: 'startDate')
  String startDate;

  @JsonKey(name: 'endDate')
  String endDate;

  @JsonKey(name: 'description')
  String description;

  @JsonKey(name: 'coverPathFile')
  String coverPathFile;

  @JsonKey(name: 'coverRepoId')
  double coverRepoId;

  @JsonKey(name: 'contactPhone')
  String contactPhone;

  @JsonKey(name: "contactEmail")
  String contactEmail;

  @JsonKey(name: 'organizersName')
  String organizersName;

  @JsonKey(name: 'organizersInfo')
  String organizersInfo;

  @JsonKey(name: 'sendReminder')
  String sendReminder;

  @JsonKey(name: 'reminderDays')
  String reminderDays;

  @JsonKey(name: 'branchId')
  double branchId;

  @JsonKey(name: 'companyId')
  double companyId;

  @JsonKey(name: 'startedState')
  bool startedState;

  @JsonKey(name: 'orderedState')
  bool orderedState;

  @JsonKey(ignore: true)
  bool isSelect = false;

  EventTicket.copyWithEntity(EventTicketEntry eventTicketEntry) {
    this.id = eventTicketEntry.id;
    this.eventName = eventTicketEntry.eventName;
    this.siteName = eventTicketEntry.siteName;
    this.siteAddress = eventTicketEntry.siteAddress;
    this.eventType = eventTicketEntry.eventType;
    this.startDate = Utilities().convertDateToString(eventTicketEntry.startDate, Constants.FORMAT_DATE_BASIC);
    this.endDate = Utilities().convertDateToString(eventTicketEntry.endDate, Constants.FORMAT_DATE_BASIC);
    this.description = eventTicketEntry.description;
    this.coverPathFile = eventTicketEntry.coverPathFile;
    this.coverRepoId = eventTicketEntry.coverRepoId;
    this.contactPhone = eventTicketEntry.contactPhone;
    this.contactEmail = eventTicketEntry.contactEmail;
    this.organizersName = eventTicketEntry.organizersName;
    this.organizersInfo = eventTicketEntry.organizersInfo;
    this.reminderDays = eventTicketEntry.reminderDays;
    this.branchId = eventTicketEntry.branchId;
    this.companyId = eventTicketEntry.companyId;
    this.startedState = eventTicketEntry.startedState;
    this.orderedState = eventTicketEntry.orderedState;
  }

  EventTicket(
    this.id,
    this.eventName,
    this.siteName,
    this.siteAddress,
    this.eventType,
    this.startDate,
    this.endDate,
    this.description,
    this.coverPathFile,
    this.coverRepoId,
    this.contactPhone,
    this.contactEmail,
    this.organizersName,
    this.organizersInfo,
    this.reminderDays,
    this.branchId,
    this.companyId,
    this.startedState,
    this.orderedState,
  );

  EventTicket.local(
    this.id,
    this.eventName,
    this.siteName,
    this.siteAddress,
    this.eventType,
    this.startDate,
    this.endDate,
    this.description,
    this.coverPathFile,
    this.coverRepoId,
    this.contactPhone,
    this.contactEmail,
    this.organizersName,
    this.organizersInfo,
    this.reminderDays,
    this.branchId,
    this.companyId,
    this.startedState,
    this.orderedState,
  );

  EventTicket.init();

  factory EventTicket.fromJson(Map<String, dynamic> json) => _$EventTicketFromJson(json);

  Map<String, dynamic> toJson() => _$EventTicketToJson(this);
}
