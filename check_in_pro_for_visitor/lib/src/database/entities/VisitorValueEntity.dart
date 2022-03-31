import 'package:moor/moor.dart';
import 'package:uuid/uuid.dart';

@DataClassName('VisitorValueEntry')
class VisitorValueEntity extends Table {
  final uuid = Uuid();

  String get tableName => 'cip_visitor_value';

  TextColumn get settingKey => text().nullable()();

  TextColumn get vi => text().nullable()();

  TextColumn get en => text().nullable()();

  TextColumn get createdBy => text().nullable()();

  DateTimeColumn get createdDate => dateTime().nullable()();

  TextColumn get updatedBy => text().nullable()();

  DateTimeColumn get updatedDate => dateTime().nullable()();

  TextColumn get deletedBy => text().nullable()();

  DateTimeColumn get deletedDate => dateTime().nullable()();
}
