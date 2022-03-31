import 'package:moor/moor.dart';
import 'package:uuid/uuid.dart';

@DataClassName("ContactPersonEntry")
class ContactPersonEntity extends Table {
  final uuid = Uuid();

  String get tableName => 'cip_contact_person';

  TextColumn get id => text().clientDefault(() => uuid.v1())();

  RealColumn get idContactPerson => real()();

  TextColumn get userName => text().nullable()();

  TextColumn get email => text().nullable()();

  TextColumn get phone => text().nullable()();

  TextColumn get description => text().nullable()();

  TextColumn get fullName => text().nullable()();

  TextColumn get fullNameUnsigned => text().nullable()();

  TextColumn get firstName => text().nullable()();

  TextColumn get lastName => text().nullable()();

  TextColumn get companyName => text().nullable()();

  TextColumn get avatarFileName => text().nullable()();

  TextColumn get gender => text().nullable()();

  TextColumn get workPhoneExt => text().nullable()();

  TextColumn get workPhoneNumber => text().nullable()();

  TextColumn get jobTitle => text().nullable()();

  TextColumn get createdBy => text().nullable()();

  DateTimeColumn get createdDate => dateTime().nullable()();

  TextColumn get updatedBy => text().nullable()();

  DateTimeColumn get updatedDate => dateTime().nullable()();

  TextColumn get deletedBy => text().nullable()();

  DateTimeColumn get deletedDate => dateTime().nullable()();

  TextColumn get logoPathLocal => text().nullable()();

  IntColumn get index => integer().nullable()();

  TextColumn get department => text().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}
