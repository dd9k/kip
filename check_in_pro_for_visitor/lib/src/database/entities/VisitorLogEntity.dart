import 'package:moor/moor.dart';
import 'package:uuid/uuid.dart';

@DataClassName('VisitorLogEntry')
class VisitorLogEntity extends Table {
  final uuid = Uuid();

  String get tableName => 'cip_visitor_log';

  TextColumn get id => text().clientDefault(() => uuid.v1())();

  TextColumn get visitorId => text()();

  TextColumn get logId => text().clientDefault(() => uuid.v1())();

  DateTimeColumn get signIn => dateTime().nullable()();

  DateTimeColumn get signOut => dateTime().nullable()();

  RealColumn get companyId => real().nullable()();

  RealColumn get branchId => real().nullable()();

  IntColumn get signOutBy => integer().nullable()();

  TextColumn get signOutType => text().nullable()();

  TextColumn get checkOutTimeExpected => text().nullable()();

  TextColumn get customStep => text().nullable()();

  TextColumn get feedBack => text().nullable()();

  RealColumn get rating => real().nullable()();

  TextColumn get cardNo => text().nullable()();

  TextColumn get goods => text().nullable()();

  TextColumn get receiver => text().nullable()();

  TextColumn get visitorPosition => text().nullable()();

  TextColumn get imageIdPath => text().nullable()();

  RealColumn get idCardRepoId => real().nullable()();

  RealColumn get surveyId => real().nullable()();

  TextColumn get idCardFile => text().nullable()();

  TextColumn get createdBy => text().nullable()();

  DateTimeColumn get createdDate => dateTime().nullable()();

  TextColumn get updatedBy => text().nullable()();

  DateTimeColumn get updatedDate => dateTime().nullable()();

  TextColumn get deletedBy => text().nullable()();

  DateTimeColumn get deletedDate => dateTime().nullable()();

  TextColumn get survey => text().nullable()();

  IntColumn get gender => integer().nullable()();

  TextColumn get passportNo => text().nullable()();

  TextColumn get nationality => text().nullable()();

  TextColumn get birthDay => text().nullable()();

  TextColumn get permanentAddress => text().nullable()();

  TextColumn get departmentRoomNo => text().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}
