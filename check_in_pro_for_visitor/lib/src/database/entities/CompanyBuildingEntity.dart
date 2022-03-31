import 'package:moor/moor.dart';
import 'package:uuid/uuid.dart';

@DataClassName("CompanyBuildingEntry")
class CompanyBuildingEntity extends Table {
  final uuid = Uuid();

  String get tableName => 'cip_company_building';

  TextColumn get idLocal => text().clientDefault(() => uuid.v1())();

  RealColumn get id => real()();

  TextColumn get companyName => text()();

  TextColumn get companyNameUnsigned => text().withDefault(const Constant(''))();

  TextColumn get shortName => text().nullable()();

  TextColumn get shortNameUnsigned => text().nullable()();

  TextColumn get representativeName => text().nullable()();

  TextColumn get representativeEmail => text().nullable()();

  RealColumn get representativeId => real().nullable()();

  TextColumn get floor => text().nullable()();

  TextColumn get note => text().nullable()();

  IntColumn get isActive => integer().nullable()();

  RealColumn get companyId => real().nullable()();

  TextColumn get logoPath => text().nullable()();

  TextColumn get logoPathLocal => text().nullable()();

  IntColumn get logoRepoId => integer().nullable()();

  IntColumn get indexSort => integer().nullable()();

  TextColumn get createdBy => text().nullable()();

  DateTimeColumn get createdDate => dateTime().nullable()();

  TextColumn get updatedBy => text().nullable()();

  DateTimeColumn get updatedDate => dateTime().nullable()();

  TextColumn get deletedBy => text().nullable()();

  DateTimeColumn get deletedDate => dateTime().nullable()();

  @override
  Set<Column> get primaryKey => {idLocal};
}
