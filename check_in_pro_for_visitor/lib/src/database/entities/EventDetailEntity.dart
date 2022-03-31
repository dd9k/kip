import 'package:moor/moor.dart';

@DataClassName("EventDetailEntry")
class EventDetailEntity extends Table {

  String get tableName => 'cip_event_detail';

  RealColumn get id => real().nullable()();

  TextColumn get eventName => text().nullable()();

  IntColumn get startDate => integer().nullable()();

  IntColumn get endDate => integer().nullable()();

  TextColumn get badgeTemplate => text().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}
