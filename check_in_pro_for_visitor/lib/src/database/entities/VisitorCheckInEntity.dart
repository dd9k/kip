import 'package:moor/moor.dart';
import 'package:uuid/uuid.dart';

@DataClassName("VisitorCheckInEntry")
class VisitorCheckInEntity extends Table {
  final uuid = Uuid();

  String get tableName => 'cip_vistor_checkin';

  TextColumn get id => text().clientDefault(() => uuid.v1())();

  TextColumn get fullName => text().nullable()();

  TextColumn get email => text().nullable()();

  TextColumn get phoneNumber => text().nullable()();

  TextColumn get idCard => text().nullable()();

  TextColumn get purpose => text().nullable()();

  TextColumn get visitorId => text().nullable().clientDefault(() => uuid.v1())();

  TextColumn get visitorType => text().nullable()();

  TextColumn get checkOutTimeExpected => text().nullable()();

  TextColumn get customStep => text().nullable()();

  TextColumn get fromCompany => text().nullable()();

  TextColumn get toCompany => text().nullable()();

  RealColumn get contactPersonId => real().nullable()();

  RealColumn get faceCaptureRepoId => real().nullable()();

  IntColumn get signInBy => integer().nullable()();

  TextColumn get signInType => text().nullable()();

  TextColumn get imagePath => text().nullable()();

  RealColumn get companyId => real().nullable()();

  RealColumn get idCardRepoId => real().nullable()();

  RealColumn get surveyId => real().nullable()();

  TextColumn get idCardFile => text().nullable()();

  TextColumn get faceCaptureFile => text().nullable()();

  TextColumn get createdBy => text().nullable()();

  DateTimeColumn get createdDate => dateTime().nullable()();

  TextColumn get updatedBy => text().nullable()();

  DateTimeColumn get updatedDate => dateTime().nullable()();

  TextColumn get deletedBy => text().nullable()();

  DateTimeColumn get deletedDate => dateTime().nullable()();

  TextColumn get cardNo => text().nullable()();

  TextColumn get goods => text().nullable()();

  TextColumn get receiver => text().nullable()();

  TextColumn get visitorPosition => text().nullable()();

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
