import 'package:check_in_pro_for_visitor/src/database/Database.dart';
import 'package:check_in_pro_for_visitor/src/database/entities/ContactPersonEntity.dart';
import 'package:check_in_pro_for_visitor/src/model/ContactPerson.dart';
import 'package:check_in_pro_for_visitor/src/utilities/Utilities.dart';
import 'package:moor/moor.dart';
import 'package:tiengviet/tiengviet.dart';

part 'ContactPersonDAO.g.dart';

@UseDao(tables: [ContactPersonEntity])
class ContactPersonDAO extends DatabaseAccessor<Database> with _$ContactPersonDAOMixin {
  Database db;

  ContactPersonDAO(this.db) : super(db);

  Future<List<ContactPerson>> searchByFullName(String fullName) async {
    if (fullName == null || fullName.isEmpty) {
      return List();
    }
    String fullNameUnsigned = tiengviet(fullName);
    List<String> listString = fullName.split("");
    String firstLetter = "";
    listString.forEach((element) {
      firstLetter = firstLetter + "$element% ";
    });
    firstLetter = firstLetter.substring(0, firstLetter.lastIndexOf(" "));
    firstLetter = "%" + firstLetter;
    final query = select(contactPersonEntity)
      ..where((tbl) =>
          tbl.fullNameUnsigned.lower().contains(fullNameUnsigned.toLowerCase()) |
          tbl.fullNameUnsigned.lower().like(firstLetter.toLowerCase()))
      ..limit(10, offset: 0);

    if (query == null) {
      return List();
    }
    final result = await query.map((row) {
      return ContactPerson.init(
          row.idContactPerson,
          row.userName,
          row.email,
          row.phone,
          row.description,
          row.fullName,
          row.firstName,
          row.lastName,
          row.companyName,
          row.avatarFileName,
          row.gender,
          row.workPhoneExt,
          row.workPhoneNumber,
          row.jobTitle,
          row.logoPathLocal,
          row.index,
          row.department);
    }).get();
    return result;
  }

  Future<void> insertAlls(List<ContactPerson> lstContactPerson) async {
    String userName;
    var userInfor = await Utilities().getUserInfor();
    if (userInfor != null) {
      userName = userInfor.userName;
    }
    // Insert models
    await batch((batch) {
      batch.insertAll(
          contactPersonEntity,
          lstContactPerson.map((row) {
            return ContactPersonEntityCompanion.insert(
                idContactPerson: row.id,
                userName: Value(row.userName),
                email: Value(row.email),
                phone: Value(row.phone),
                description: Value(row.description),
                fullName: Value(row.fullName),
                fullNameUnsigned: Value(tiengviet(row.fullName)),
                firstName: Value(row.firstName),
                lastName: Value(row.lastName),
                companyName: Value(row.companyName),
                avatarFileName: Value(row.avatarFileName),
                gender: Value(row.gender),
                workPhoneExt: Value(row.workPhoneExt),
                workPhoneNumber: Value(row.workPhoneNumber),
                jobTitle: Value(row.jobTitle),
                createdBy: Value(userName),
                createdDate: Value(DateTime.now().toUtc()),
                updatedBy: Value(userName),
                updatedDate: Value(DateTime.now().toUtc()),
                logoPathLocal: Value(row.logoPathLocal),
                index: Value(row.index),
                department: Value(row.department));
          }).toList());
    });
  }

  Future<void> deleteAlls() async {
    delete(contactPersonEntity).go();
  }

  Future<List<ContactPerson>> getAlls() {
    final query = select(contactPersonEntity);
    return query.map((row) {
      return ContactPerson.init(
          row.idContactPerson,
          row.userName,
          row.email,
          row.phone,
          row.description,
          row.fullName,
          row.firstName,
          row.lastName,
          row.companyName,
          row.avatarFileName,
          row.gender,
          row.workPhoneExt,
          row.workPhoneNumber,
          row.jobTitle,
          row.logoPathLocal,
          row.index,
          row.department);
    }).get();
  }
}
