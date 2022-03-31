import 'package:moor/moor.dart';

@DataClassName("EventTicketEntry")
class EventTicketEntity extends Table{
  String get tableName => 'cip_event_ticket';

  RealColumn get id => real().nullable()();
  TextColumn get eventName => text().nullable()();
  TextColumn get siteName => text().nullable()();
  TextColumn get siteAddress => text().nullable()();
  TextColumn get eventType => text().nullable()();
  DateTimeColumn get startDate => dateTime().nullable()();
  DateTimeColumn get endDate => dateTime().nullable()();
  TextColumn get description => text().nullable()();
  TextColumn get coverPathFile => text().nullable()();
  RealColumn get coverRepoId => real().nullable()();
  TextColumn get contactPhone => text().nullable()();
  TextColumn get contactEmail => text().nullable()();
  TextColumn get organizersName => text().nullable()();
  TextColumn get organizersInfo => text().nullable()();
  TextColumn get sendReminder => text().nullable()();
  TextColumn get reminderDays => text().nullable()();
  RealColumn get branchId => real().nullable()();
  RealColumn get companyId => real().nullable()();
  BoolColumn get startedState => boolean().nullable()();
  BoolColumn get orderedState => boolean().nullable()();
}
