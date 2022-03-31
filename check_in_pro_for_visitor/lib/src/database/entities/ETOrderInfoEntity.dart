import 'package:moor/moor.dart';

@DataClassName("ETOderInfoEntry")
class ETOrderInfoEntity extends Table {
  String get tableName => 'cip_et_order';

  RealColumn get id => real().nullable()();
  TextColumn get orderNo => text().nullable()();
  RealColumn get guestId => real().nullable()();
  RealColumn get eventId => real().nullable()();
  TextColumn get paymentType => text().nullable()();
  RealColumn get totalAmount => real().nullable()();
  TextColumn get status => text().nullable()();
  RealColumn get quantity => real().nullable()();
  TextColumn get guestName => text().nullable()();
  TextColumn get guestPhone => text().nullable()();
  TextColumn get guestEmail => text().nullable()();
}
