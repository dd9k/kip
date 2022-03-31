import 'package:moor/moor.dart';

@DataClassName("ETOderDetailInfoEntry")
class ETOrderDetailInfoEntity extends Table {
  String get tableName => 'cip_et_order_detail';

  RealColumn get id => real().nullable()();
  RealColumn get orderId => real().nullable()();
  RealColumn get eventId => real().nullable()();
  RealColumn get ticketId => real().nullable()();
  RealColumn get quantity => real().nullable()();
  RealColumn get amount => real().nullable()();
  RealColumn get discountId => real().nullable()();
  TextColumn get inviteCode => text().nullable()();
  TextColumn get status => text().nullable()();
}
