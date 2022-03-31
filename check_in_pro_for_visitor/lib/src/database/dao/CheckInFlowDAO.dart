import 'package:check_in_pro_for_visitor/src/constants/Constants.dart';
import 'package:check_in_pro_for_visitor/src/database/Database.dart';
import 'package:check_in_pro_for_visitor/src/database/entities/CheckInFlowEntity.dart';
import 'package:check_in_pro_for_visitor/src/model/CheckInFlow.dart';
import 'package:check_in_pro_for_visitor/src/utilities/Utilities.dart';
import 'package:moor/moor.dart';

part 'CheckInFlowDAO.g.dart';

@UseDao(tables: [CheckInFlowEntity])
class CheckInFlowDAO extends DatabaseAccessor<Database> with _$CheckInFlowDAOMixin {
  Database db;

  CheckInFlowDAO(this.db) : super(db);

  Future<List<CheckInFlow>> getAlls() {
    final query = select(checkInFlowEntity);

    return query
        .map((row) => CheckInFlow(0, row.templateCode, row.templateName, row.stepName, row.stepCode, row.stepType,
            row.visitorType, row.isRequired, row.sort))
        .get();
  }

  Future<List<CheckInFlow>> getbyTemplateCode(String templateCode) {
    final query = select(checkInFlowEntity)..where((tbl) => tbl.templateCode.equals(templateCode));

    return query
        .map((row) => CheckInFlow(0, row.templateCode, row.templateName, row.stepName, row.stepCode, row.stepType,
            row.visitorType, row.isRequired, row.sort))
        .get();
  }

  Future<List<CheckInFlow>> getDeliveryFlow() {
    final query = select(checkInFlowEntity)..where((tbl) => tbl.stepCode.isIn(Constants.DELIVERY_STEP));

    return query
        .map((row) => CheckInFlow(0, row.templateCode, row.templateName, row.stepName, row.stepCode, row.stepType,
            row.visitorType, row.isRequired, row.sort))
        .get();
  }

  Future<void> deleteAlls() async {
    delete(checkInFlowEntity).go();
  }

  Future<int> insert(CheckInFlow model) async {
    String userName;
    var userInfor = await Utilities().getUserInfor();
    if (userInfor != null) {
      userName = userInfor.userName;
    }
    final companion = CheckInFlowEntityCompanion(
      templateCode: Value(model.templateCode),
      templateName: Value(model.templateName),
      stepCode: Value(model.stepCode),
      stepName: Value(model.stepName),
      stepType: Value(model.stepType),
      visitorType: Value(model.visitorType),
      isRequired: Value(model.isRequired),
      sort: Value(model.sort),
      createdBy: Value(userName),
      createdDate: Value(DateTime.now().toUtc()),
      updatedBy: Value(userName),
      updatedDate: Value(DateTime.now().toUtc()),
    );
    final affectRows = into(checkInFlowEntity).insert(companion);

    return affectRows;
  }

  Future<void> insertAlls(List<CheckInFlow> lstCheckInFlow) async {
    String userName;
    var userInfor = await Utilities().getUserInfor();
    if (userInfor != null) {
      userName = userInfor.userName;
    }
    // Insert models
    await batch((batch) {
      batch.insertAll(
          checkInFlowEntity,
          lstCheckInFlow.map((row) {
            return CheckInFlowEntityCompanion.insert(
              templateCode: Value(row.templateCode),
              templateName: Value(row.templateName),
              stepCode: Value(row.stepCode),
              stepName: Value(row.stepName),
              stepType: Value(row.stepType),
              visitorType: Value(row.visitorType),
              isRequired: Value(row.isRequired),
              sort: Value(row.sort),
              createdBy: Value(userName),
              createdDate: Value(DateTime.now().toUtc()),
              updatedBy: Value(userName),
              updatedDate: Value(DateTime.now().toUtc()),
            );
          }).toList());
    });
  }
}
