import 'package:check_in_pro_for_visitor/src/database/entities/ETOrderDetailInfoEntity.dart';
import 'package:check_in_pro_for_visitor/src/model/ETOrderDetailInfo.dart';
import 'package:moor/moor.dart';

import '../Database.dart';

part 'ETOrderDetailInfoDAO.g.dart';

@UseDao(tables: [ETOrderDetailInfoEntity])
class ETOrderDetailInfoDAO extends DatabaseAccessor<Database> with _$ETOrderDetailInfoDAOMixin {
  Database db;

  ETOrderDetailInfoDAO(this.db) : super(db);

  Future<void> insertAll(List<ETOrderDetailInfo> eTOrderInfo) async {
    await batch((batch) {
      batch.insertAll(
          eTOrderDetailInfoEntity,
          eTOrderInfo.map((row) {
            return createCompanion(row);
          }).toList());
    });
  }

  Future<List<ETOrderDetailInfo>> getEventTicket(double orderId) async {
    final query = select(eTOrderDetailInfoEntity)
      ..where((orderDetail) => orderDetail.orderId.equals(orderId));
    List<ETOrderDetailInfo> list = await query.map((row) => ETOrderDetailInfo.copyWithEntity(row)).get();
    if (query == null || list.isEmpty) {
      return null;
    }
    return list;
  }

  ETOrderDetailInfoEntityCompanion createCompanion(ETOrderDetailInfo etOrderInfo) {
    final companion = ETOrderDetailInfoEntityCompanion(
      id: Value(etOrderInfo.id),
      orderId: Value(etOrderInfo.orderId),
      ticketId: Value(etOrderInfo.ticketId),
      quantity: Value(etOrderInfo.quantity),
      amount: Value(etOrderInfo.amount),
      discountId: Value(etOrderInfo.discountId),
      inviteCode: Value(etOrderInfo.inviteCode),
      status: Value(etOrderInfo.status),
    );
    return companion;
  }

  Future<void> deleteAll() async {
    delete(eTOrderDetailInfoEntity).go();
  }
}
