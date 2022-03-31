import 'package:moor/moor.dart';
import 'package:uuid/uuid.dart';

@DataClassName('CheckInFlowEntry')
class CheckInFlowEntity extends Table {
  final uuid = Uuid();

  String get tableName => 'cip_check_in_flow';

  TextColumn get templateCode => text().nullable()();

  TextColumn get templateName => text().nullable()();

  TextColumn get stepName => text().nullable()();

  TextColumn get stepCode => text().nullable()();

  TextColumn get stepType => text().nullable()();

  TextColumn get visitorType => text().nullable()();

  IntColumn get isRequired => integer().nullable()();

  TextColumn get sort => text().nullable()();

  TextColumn get createdBy => text().nullable()();

  DateTimeColumn get createdDate => dateTime().nullable()();

  TextColumn get updatedBy => text().nullable()();

  DateTimeColumn get updatedDate => dateTime().nullable()();

  TextColumn get deletedBy => text().nullable()();

  DateTimeColumn get deletedDate => dateTime().nullable()();
}
