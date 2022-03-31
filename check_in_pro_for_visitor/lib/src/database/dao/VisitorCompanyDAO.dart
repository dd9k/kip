import 'package:check_in_pro_for_visitor/src/database/entities/VisitorCompanyEntity.dart';
import 'package:check_in_pro_for_visitor/src/utilities/Utilities.dart';
import 'package:moor/moor.dart';
import 'package:check_in_pro_for_visitor/src/database/Database.dart';
import 'package:tiengviet/tiengviet.dart';

part 'VisitorCompanyDAO.g.dart';

@UseDao(tables: [VisitorCompanyEntity])
class VisitorCompanyDAO extends DatabaseAccessor<Database> with _$VisitorCompanyDAOMixin {
  final Database db;

  VisitorCompanyDAO(this.db) : super(db);

  Future<List<String>> searchCompanyNameForVisitor(String keySearch) {
    if (keySearch == null || keySearch.isEmpty) {
      return null;
    }
    final companyNameUnsigned = tiengviet(keySearch);
    final query = select(visitorCompanyEntity)
      ..where((tbl) => tbl.fromCompanyUnsigned.lower().contains(companyNameUnsigned.toLowerCase()))
      ..limit(5, offset: 0);
    if (query == null) {
      return null;
    }
    final result = query.map((row) {
      return row.fromCompany;
    });
    return result.get();
  }

  Future<bool> _isExistCompanyName(String companyName) async {
    if (companyName == null || companyName.isEmpty) {
      return false;
    }
    final companyNameUnsigned = tiengviet(companyName);
    final query = select(visitorCompanyEntity)
      ..where((tbl) => tbl.fromCompanyUnsigned.lower().equals(companyNameUnsigned.toLowerCase()));
    final result = await query.get();
    if (result.isEmpty) {
      return false;
    }
    return true;
  }

  Future<void> insertCompanyName(String companyName) async {
    if (await _isExistCompanyName(companyName)) {
      return;
    }
    String userName;
    var userInfor = await Utilities().getUserInfor();
    if (userInfor != null) {
      userName = userInfor.userName;
    }
    final entity = VisitorCompanyEntityCompanion(
      fromCompany: Value(companyName),
      fromCompanyUnsigned: Value(tiengviet(companyName)),
      createdBy: Value(userName),
      createdDate: Value(DateTime.now().toUtc()),
      updatedBy: Value(userName),
      updatedDate: Value(DateTime.now().toUtc()),
    );

    await into(visitorCompanyEntity).insert(entity);
  }

  Future<void> deleteAlls() async {
    await delete(visitorCompanyEntity).go();
  }
}
