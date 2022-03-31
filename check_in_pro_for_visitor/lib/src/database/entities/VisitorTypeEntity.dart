import 'package:moor/moor.dart';
import 'package:uuid/uuid.dart';

@DataClassName('VisitorTypeEntry')
class VisitorTypeEntity extends Table {
  final uuid = Uuid();

  String get tableName => 'cip_vistor_type';

  TextColumn get id => text().clientDefault(() => uuid.v1())();

  TextColumn get settingKey => text().nullable()();

  TextColumn get settingValue => text().nullable()();

  TextColumn get description => text().nullable()();

  BoolColumn get isTakePicture => boolean().nullable()();

  BoolColumn get isScanIdCard => boolean().nullable()();

  BoolColumn get isSurvey => boolean().nullable()();

  BoolColumn get isPrintCard => boolean().nullable()();

  BoolColumn get allowToDisplayContactPerson => boolean().nullable()();

  DateTimeColumn get createdDate => dateTime().nullable()();

  TextColumn get createdBy => text().nullable()();

  TextColumn get updatedBy => text().nullable()();

  DateTimeColumn get updatedDate => dateTime().nullable()();

  TextColumn get deletedBy => text().nullable()();

  DateTimeColumn get deletedDate => dateTime().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}
