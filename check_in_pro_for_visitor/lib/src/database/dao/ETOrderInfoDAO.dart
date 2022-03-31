import 'package:check_in_pro_for_visitor/src/database/entities/ETOrderInfoEntity.dart';
import 'package:check_in_pro_for_visitor/src/model/ETOrderInfo.dart';
import 'package:moor/moor.dart';

import '../Database.dart';
part 'ETOrderInfoDAO.g.dart';

@UseDao(tables: [ETOrderInfoEntity])
class ETOrderInfoDAO extends DatabaseAccessor<Database>
    with _$ETOrderInfoDAOMixin {
  Database db;
  ETOrderInfoDAO(this.db) : super(db);

  Future<void> insertAll(List<ETOrderInfo> eTOrderInfos) async {
    if (eTOrderInfos != null) {
      for (ETOrderInfo eTOrderInfo in eTOrderInfos) {
        await db.eTOrderDetailInfoDAO.insertAll(eTOrderInfo.orderDetails);
        await insertOne(eTOrderInfo);
      }
    }
  }

  Future<void> insertOne(ETOrderInfo eTOrderInfo) async {
    ETOrderInfoEntityCompanion companion = createCompanion(eTOrderInfo);
    into(eTOrderInfoEntity).insert(companion);
  }

  Future<List<ETOrderInfo>> getOrdersInfor(double eventId) async {
    final query = select(eTOrderInfoEntity)
      ..where((order) => order.eventId.equals(eventId));
    List<ETOrderInfo> list = await query.map((row) => ETOrderInfo.copyWithEntity(row)).get();
    if (query == null || list.isEmpty) {
      return null;
    }
    for (ETOrderInfo order in list) {
      order.orderDetails = await db.eTOrderDetailInfoDAO.getEventTicket(order.id);
    }
    return list;
  }

  ETOrderInfoEntityCompanion createCompanion(ETOrderInfo etOrderInfo) {
    final companion = ETOrderInfoEntityCompanion(
      id: Value(etOrderInfo.id),
      orderNo: Value(etOrderInfo.orderNo),
      guestId: Value(etOrderInfo.guestId),
      eventId: Value(etOrderInfo.eventId),
      paymentType: Value(etOrderInfo.paymentType),
      totalAmount: Value(etOrderInfo.totalAmount),
      status: Value(etOrderInfo.status),
      quantity: Value(etOrderInfo.quantity),
      guestName: Value(etOrderInfo.guestName),
      guestPhone: Value(etOrderInfo.guestPhone),
      guestEmail: Value(etOrderInfo.guestEmail),
    );
    return companion;
  }

  Future<void> deleteAll() async {
    delete(eTOrderInfoEntity).go();
  }
}
