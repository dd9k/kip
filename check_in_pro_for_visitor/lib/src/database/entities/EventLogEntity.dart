import 'package:moor/moor.dart';
import 'package:uuid/uuid.dart';

@DataClassName("EventLogEntry")
class EventLogEntity extends Table {

  String get tableName => 'cip_event_log';

  final uuid = Uuid();

  TextColumn get id => text().clientDefault(() => uuid.v1())();

  RealColumn get guestId => real().nullable()();

  TextColumn get fullName => text().nullable()();

  TextColumn get email => text().nullable()();

  TextColumn get phoneNumber => text().nullable()();

  TextColumn get inviteCode => text().nullable()();

  TextColumn get timeZone => text().nullable()();

  TextColumn get idCard => text().nullable()();

  TextColumn get signInType => text().nullable()();

  TextColumn get signOutType => text().nullable()();

  IntColumn get signInBy => integer().nullable()();

  TextColumn get imagePath => text().nullable()();

  TextColumn get imageIdPath => text().nullable()();

  RealColumn get eventId => real().nullable()();

  IntColumn get signIn => integer().nullable()();

  IntColumn get signOut => integer().nullable()();

  TextColumn get feedback => text().nullable()();

  TextColumn get status => text().nullable()();

  TextColumn get visitorType => text().nullable()();

  IntColumn get branchId => integer().nullable()();

  IntColumn get rating => integer().nullable()();

  BoolColumn get syncFail => boolean().nullable()();

  BoolColumn get isNew => boolean().nullable()();

  TextColumn get faceCaptureFile => text().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}
