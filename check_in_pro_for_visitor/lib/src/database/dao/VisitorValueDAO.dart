import 'dart:async';

import 'package:check_in_pro_for_visitor/src/database/entities/VisitorValueEntity.dart';
import 'package:check_in_pro_for_visitor/src/model/VisitorValue.dart';
import 'package:check_in_pro_for_visitor/src/utilities/Utilities.dart';
import 'package:moor/moor.dart';
import '../Database.dart';

part 'VisitorValueDAO.g.dart';

@UseDao(tables: [VisitorValueEntity])
class VisitorValueDAO extends DatabaseAccessor<Database> with _$VisitorValueDAOMixin {
  final Database db;

  VisitorValueDAO(this.db) : super(db);

  Future<VisitorValue> getDataBySettingKey(String settingKey) async {
    final query = select(visitorValueEntity)..where((tbl) => tbl.settingKey.equals(settingKey));

    final result = await query.map((row) {
      return VisitorValue(row.vi, row.en);
    }).get();
    return result.first;
  }

  Future<void> deleteAll() async {
    await delete(visitorValueEntity).go();
  }

  Future<int> insert(VisitorValue dataEntry, String settingKey) async {
    String userName;
    var userInfor = await Utilities().getUserInfor();
    if (userInfor != null) {
      userName = userInfor.userName;
    }
    final entityCompanion = VisitorValueEntityCompanion(
      settingKey: Value(settingKey),
      en: Value(dataEntry.en),
      vi: Value(dataEntry.vi),
      createdBy: Value(userName),
      createdDate: Value(DateTime.now().toUtc()),
      updatedBy: Value(userName),
      updatedDate: Value(DateTime.now().toUtc()),
    );

    return into(visitorValueEntity).insert(entityCompanion);
  }
}
