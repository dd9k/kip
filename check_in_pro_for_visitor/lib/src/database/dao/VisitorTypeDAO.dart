import 'dart:async';

import 'package:check_in_pro_for_visitor/src/constants/Constants.dart';
import 'package:check_in_pro_for_visitor/src/database/entities/VisitorTypeEntity.dart';
import 'package:check_in_pro_for_visitor/src/model/VisitorType.dart';
import 'package:check_in_pro_for_visitor/src/utilities/Utilities.dart';
import 'package:moor/moor.dart';
import '../Database.dart';

part 'VisitorTypeDAO.g.dart';

@UseDao(tables: [VisitorTypeEntity])
class VisitorTypeDAO extends DatabaseAccessor<Database> with _$VisitorTypeDAOMixin {
  final Database db;

  VisitorTypeDAO(this.db) : super(db);

  Future<List<VisitorType>> getAlls() async {
    final query = select(visitorTypeEntity);

    final result = await query.map((row) {
      // final visitorValue =
      //     await db.visitorValueDAO.getDataBySettingKey(row.settingKey);
      return VisitorType(row.settingKey, null, row.description, row.isTakePicture, row.isScanIdCard, row.isSurvey, row.isPrintCard,
          row.allowToDisplayContactPerson);
    }).get();
    for (var item in result) {
      final visitorValue = await db.visitorValueDAO.getDataBySettingKey(item.settingKey);
      item.settingValue = visitorValue;
    }
    return result;
  }

  Future<VisitorType> getVisitorTypeBySettingKey(String settingKey) async {
    if (settingKey == null || settingKey.isEmpty) {
      var type = TypeVisitor.VISITOR;
      var listType = await db.visitorTypeDAO.getAlls();
      if (listType != null && listType.isNotEmpty) {
        type = listType[0].settingKey;
      }
      settingKey = type;
    }
    final query = select(visitorTypeEntity)..where((tbl) => tbl.settingKey.equals(settingKey));
    final list = await query
        .map((row) => VisitorType(row.settingKey, null, row.description, row.isTakePicture, row.isScanIdCard, row.isSurvey,
            row.isPrintCard, row.allowToDisplayContactPerson))
        .get();
    if (list.isEmpty) {
      return null;
    }
    for (var item in list) {
      final visitorValue = await db.visitorValueDAO.getDataBySettingKey(item.settingKey);
      item.settingValue = visitorValue;
    }
    return list.first;
  }

  Future<void> deleteAll() async {
    await delete(visitorTypeEntity).go();
    await db.visitorValueDAO.deleteAll();
  }

  Future<int> insert(VisitorType dataEntry) async {
    String userName;
    var userInfor = await Utilities().getUserInfor();
    if (userInfor != null) {
      userName = userInfor.userName;
    }
    // Insert visitor value
    db.visitorValueDAO.insert(dataEntry.settingValue, dataEntry.settingKey);
    // Insert visitor type
    final entityCompanion = VisitorTypeEntityCompanion(
      settingKey: Value(dataEntry.settingKey),
      settingValue: Value(''),
      description: Value(dataEntry.description),
      isTakePicture: Value(dataEntry.isTakePicture),
      isScanIdCard: Value(dataEntry.isScanIdCard),
      isSurvey: Value(dataEntry.isSurvey),
      isPrintCard: Value(dataEntry.isPrintCard),
      allowToDisplayContactPerson: Value(dataEntry.allowToDisplayContactPerson),
      createdBy: Value(userName),
      createdDate: Value(DateTime.now().toUtc()),
      updatedBy: Value(userName),
      updatedDate: Value(DateTime.now().toUtc()),
    );

    return into(visitorTypeEntity).insert(entityCompanion);
  }
}
