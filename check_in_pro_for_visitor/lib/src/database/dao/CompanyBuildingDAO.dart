import 'package:check_in_pro_for_visitor/src/database/Database.dart';
import 'package:check_in_pro_for_visitor/src/database/entities/CompanyBuildingEntity.dart';
import 'package:check_in_pro_for_visitor/src/model/CompanyBuilding.dart';
import 'package:check_in_pro_for_visitor/src/utilities/Utilities.dart';
import 'package:moor/moor.dart';
import 'package:tiengviet/tiengviet.dart';

part 'CompanyBuildingDAO.g.dart';

@UseDao(tables: [CompanyBuildingEntity])
class CompanyBuildingDAO extends DatabaseAccessor<Database> with _$CompanyBuildingDAOMixin {
  Database db;

  CompanyBuildingDAO(this.db) : super(db);

  Future<List<CompanyBuilding>> getDataByCompanyName(String companyName) {
    SimpleSelectStatement<$CompanyBuildingEntityTable, CompanyBuildingEntry> query;
    if (companyName == null || companyName.isEmpty) {
      query = select(companyBuildingEntity)..limit(0);
    } else {
      final companyNameUnsigned = tiengviet(companyName);
      query = select(companyBuildingEntity)
        ..where((tbl) =>
            tbl.companyNameUnsigned.lower().contains(companyNameUnsigned.toLowerCase()) |
            tbl.shortNameUnsigned.lower().contains(companyNameUnsigned.toLowerCase()))
        ..orderBy([
          (t) => OrderingTerm(expression: t.floor.cast<int>(), mode: OrderingMode.asc),
        ]);
    }
    return query.map((row) {
      final model = CompanyBuilding.init(
          row.id,
          row.companyName,
          row.shortName,
          row.representativeName,
          row.representativeEmail,
          row.representativeId,
          row.floor,
          row.note,
          row.isActive,
          row.companyId,
          row.logoPath,
          row.logoPathLocal,
          row.logoRepoId,
          row.indexSort);
      return model;
    }).get();
  }

  Future<List<CompanyBuilding>> getAlls() {
    final query = select(companyBuildingEntity)..orderBy([
      (t) => OrderingTerm(expression: t.floor.cast<int>(), mode: OrderingMode.asc)]);
    return query.map((row) {
      final model = CompanyBuilding.init(
          row.id,
          row.companyName,
          row.shortName,
          row.representativeName,
          row.representativeEmail,
          row.representativeId,
          row.floor,
          row.note,
          row.isActive,
          row.companyId,
          row.logoPath,
          row.logoPathLocal,
          row.logoRepoId,
          row.indexSort);
      return model;
    }).get();
  }

  Future<List<CompanyBuilding>> isExistData() async {
    final query = select(companyBuildingEntity);
    List<CompanyBuilding> lstData = await (query.map((row) {
      final model = CompanyBuilding.init(
          row.id,
          row.companyName,
          row.shortName,
          row.representativeName,
          row.representativeEmail,
          row.representativeId,
          row.floor,
          row.note,
          row.isActive,
          row.companyId,
          row.logoPath,
          row.logoPathLocal,
          row.logoRepoId,
          row.indexSort);
      return model;
    }).get());
    if (lstData.length > 0) {
      return lstData;
    }
    return null;
  }

  Future<void> deleteAlls() async {
    delete(companyBuildingEntity).go();
  }

  Future<void> insertAlls(List<CompanyBuilding> lstCompanyBuildings) async {
    String userName;
    var userInfor = await Utilities().getUserInfor();
    if (userInfor != null) {
      userName = userInfor.userName;
    }
    // Insert models
    await batch((batch) {
      batch.insertAll(
          companyBuildingEntity,
          lstCompanyBuildings.map((row) {
            return CompanyBuildingEntityCompanion.insert(
              id: row.id,
              companyName: row.companyName,
              companyNameUnsigned: Value(tiengviet(row.companyName)),
              shortName: Value(row.shortName),
              shortNameUnsigned: Value(tiengviet(row.shortName)),
              representativeName: Value(row.representativeName),
              representativeEmail: Value(row.representativeEmail),
              representativeId: Value(row.representativeId),
              floor: Value(row.floor),
              note: Value(row.note),
              isActive: Value(row.isActive),
              companyId: Value(row.companyId),
              logoPath: Value(row.logoPath),
              logoRepoId: Value(row.logoRepoId),
              logoPathLocal: Value(row.logoPathLocal),
              indexSort: Value(row.index),
              createdBy: Value(userName),
              createdDate: Value(DateTime.now().toUtc()),
              updatedBy: Value(userName),
              updatedDate: Value(DateTime.now().toUtc()),
            );
          }).toList());
    });
  }
}
