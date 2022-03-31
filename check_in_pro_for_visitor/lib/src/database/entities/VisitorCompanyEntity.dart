import 'package:moor/moor.dart';
import 'package:uuid/uuid.dart';

@DataClassName('VisitorCompanyEntry')
class VisitorCompanyEntity extends Table {
  final uuid = Uuid();

  String get tableName => 'cip_visitor_company';

  TextColumn get id => text().clientDefault(() => uuid.v1())();

  TextColumn get fromCompany => text().nullable()();

  TextColumn get fromCompanyUnsigned => text().nullable()();

  TextColumn get createdBy => text().nullable()();

  DateTimeColumn get createdDate => dateTime().nullable()();

  TextColumn get updatedBy => text().nullable()();

  DateTimeColumn get updatedDate => dateTime().nullable()();

  TextColumn get deletedBy => text().nullable()();

  DateTimeColumn get deletedDate => dateTime().nullable()();
}
