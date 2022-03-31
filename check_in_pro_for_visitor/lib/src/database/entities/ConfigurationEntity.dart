import 'package:moor/moor.dart';
import 'package:uuid/uuid.dart';

@DataClassName("ConfigurationEntry")
class ConfigurationEntity extends Table {
  final uuid = Uuid();

  String get tableName => 'cip_configuration';

  TextColumn get id => text().clientDefault(() => uuid.v1())();

  TextColumn get code => text()();

  TextColumn get value => text().nullable()();

  TextColumn get createdBy => text().nullable()();

  DateTimeColumn get createdDate => dateTime().nullable()();

  TextColumn get updatedBy => text().nullable()();

  DateTimeColumn get updatedDate => dateTime().nullable()();

  TextColumn get deletedBy => text().nullable()();

  DateTimeColumn get deletedDate => dateTime().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}
