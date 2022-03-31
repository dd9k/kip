import 'package:check_in_pro_for_visitor/src/database/dao/VisitorLogDAO.dart';
import 'package:check_in_pro_for_visitor/src/database/entities/VisitorCheckInEntity.dart';
import 'package:check_in_pro_for_visitor/src/model/VisitorCheckIn.dart';
import 'package:check_in_pro_for_visitor/src/model/VisitorLog.dart';
import 'package:check_in_pro_for_visitor/src/utilities/Utilities.dart';
import 'package:moor/moor.dart';
import 'package:check_in_pro_for_visitor/src/database/Database.dart';

part 'VisitorCheckInDAO.g.dart';

@UseDao(tables: [VisitorCheckInEntity])
class VisitorCheckInDAO extends DatabaseAccessor<Database> with _$VisitorCheckInDAOMixin {
  final Database db;
  VisitorLogDAO _visitorLogDAO;

  VisitorCheckInDAO(this.db) : super(db) {
    _visitorLogDAO = VisitorLogDAO(db);
  }

  Future<List<VisitorCheckIn>> getAlls() {
    final query = select(visitorCheckInEntity);

    return query.map((row) {
      return VisitorCheckIn(
          null,
          row.fullName,
          row.email,
          row.phoneNumber,
          row.idCard,
          row.purpose,
          null,
          row.visitorType,
          row.fromCompany,
          row.toCompany,
          null,
          null,
          row.faceCaptureFile,
          row.signInBy,
          row.signInType,
          0,
          row.cardNo,
          row.goods,
          row.receiver,
          row.visitorPosition,
          row.idCardRepoId,
          row.idCardFile,
          row.survey,
          row.gender,
          row.passportNo,
          row.nationality,
          row.birthDay,
          row.permanentAddress,
          row.departmentRoomNo,
          row.surveyId,
          "",
          row.checkOutTimeExpected,
          row.customStep);
    }).get();
  }

  Future<VisitorCheckIn> getByPhoneNumber(String phoneNumber, double companyId) async {
    final query = select(visitorCheckInEntity)
      ..where((tbl) => tbl.phoneNumber.equals(phoneNumber) & tbl.companyId.equals(companyId));

    List<VisitorCheckIn> list = await query
        .map((row) => VisitorCheckIn(
            null,
            row.fullName,
            row.email,
            row.phoneNumber,
            row.idCard,
            row.purpose,
            null,
            row.visitorType,
            row.fromCompany,
            row.toCompany,
            null,
            null,
            row.faceCaptureFile,
            row.signInBy,
            row.signInType,
            0,
            row.cardNo,
            row.goods,
            row.receiver,
            row.visitorPosition,
            row.idCardRepoId,
            row.idCardFile,
            row.survey,
            row.gender,
            row.passportNo,
            row.nationality,
            row.birthDay,
            row.permanentAddress,
            row.departmentRoomNo,
            row.surveyId,
            "",
            row.checkOutTimeExpected,
            row.customStep))
        .get();
    if (list.isEmpty) {
      return null;
    }
    return list.first;
  }

  Future<VisitorCheckIn> getByIdCard(String idCard, double companyId) async {
    final query = select(visitorCheckInEntity)
      ..where((tbl) => tbl.idCard.equals(idCard) & tbl.companyId.equals(companyId));

    List<VisitorCheckIn> list = await query
        .map((row) => VisitorCheckIn(
            null,
            row.fullName,
            row.email,
            row.phoneNumber,
            row.idCard,
            row.purpose,
            null,
            row.visitorType,
            row.fromCompany,
            row.toCompany,
            null,
            null,
            row.faceCaptureFile,
            row.signInBy,
            row.signInType,
            0,
            row.cardNo,
            row.goods,
            row.receiver,
            row.visitorPosition,
            row.idCardRepoId,
            row.idCardFile,
            row.survey,
            row.gender,
            row.passportNo,
            row.nationality,
            row.birthDay,
            row.permanentAddress,
            row.departmentRoomNo,
            row.surveyId,
            "",
            row.checkOutTimeExpected,
            row.customStep))
        .get();
    if (list.isEmpty) {
      return null;
    }
    return list.first;
  }

  Future<VisitorLog> insertNewOrUpdateOld(VisitorCheckIn vistor, int signIn, {bool isAddVisitorLog = true}) async {
    String userName;
    double companyId;
    double branchId;
    int signOutBy;
    var userInfor = await Utilities().getUserInfor();
    if (userInfor != null) {
      userName = userInfor.userName;
      companyId = userInfor.companyInfo.id;
      branchId = userInfor.deviceInfo.branchId;
      signOutBy = userInfor?.deviceInfo?.id ?? 0;
    }
    // Check visitor exist by phone number
    final visitorCheckIn = await this._getByPhoneNumberEntry(vistor.phoneNumber, companyId);
    if (visitorCheckIn != null) {
      this._updateData(vistor.phoneNumber, companyId, vistor);
      // Insert data into vistorlog
      if (isAddVisitorLog) {
        final rowId = _visitorLogDAO.insertVistorLogSignIn(
            visitorCheckIn.visitorId,
            signIn,
            userName,
            companyId,
            branchId,
            signOutBy,
            vistor.cardNo,
            vistor.goods,
            vistor.receiver,
            vistor.visitorPosition,
            vistor.imageIdPath,
            vistor.idCardRepoId,
            vistor.idCardFile,
            vistor.survey,
            vistor.surveyId,
            vistor.checkOutTimeExpected,
            vistor.customStep);
        return _visitorLogDAO.getSingleByRowId(await rowId);
      }
      return null;
    }
    VisitorCheckInEntityCompanion vistorCompanion = VisitorCheckInEntityCompanion(
        fullName: Value(vistor.fullName),
        email: Value(vistor.email),
        phoneNumber: Value(vistor.phoneNumber),
        idCard: Value(vistor.idCard),
        purpose: Value(vistor.purpose),
        visitorType: Value(vistor.visitorType),
        fromCompany: Value(vistor.fromCompany),
        toCompany: Value(vistor.toCompany),
        contactPersonId: Value(vistor.contactPersonId),
        faceCaptureRepoId: Value(vistor.faceCaptureRepoId),
        signInBy: Value(vistor.signInBy),
        signInType: Value(vistor.signInType),
        imagePath: Value(vistor.imagePath),
        companyId: Value(companyId),
        cardNo: Value(vistor.cardNo),
        goods: Value(vistor.goods),
        receiver: Value(vistor.receiver),
        visitorPosition: Value(vistor.visitorPosition),
        idCardRepoId: Value(vistor.idCardRepoId),
        idCardFile: Value(vistor.idCardFile),
        createdBy: Value(userName),
        createdDate: Value(DateTime.now().toUtc()),
        updatedBy: Value(userName),
        updatedDate: Value(DateTime.now().toUtc()),
        survey: Value(vistor.survey),
        surveyId: Value(vistor.surveyId),
        checkOutTimeExpected: Value(vistor.checkOutTimeExpected),
        customStep: Value(vistor.customStep));
    final affectRow = into(visitorCheckInEntity).insert(vistorCompanion);
    // Get vistor checkin
    var vistorCheckInEntity = await _getVistorCheckIn(await affectRow);
    if (vistorCheckInEntity != null) {
      // Insert data into vistorlog
      if (isAddVisitorLog) {
        final rowId = _visitorLogDAO.insertVistorLogSignIn(
            vistorCheckInEntity.visitorId,
            signIn,
            userName,
            companyId,
            branchId,
            signOutBy,
            vistor.cardNo,
            vistor.goods,
            vistor.receiver,
            vistor.visitorPosition,
            vistor.imageIdPath,
            vistor.idCardRepoId,
            vistor.idCardFile,
            vistor.survey,
            vistor.surveyId,
            vistor.checkOutTimeExpected,
            vistor.customStep);
        return _visitorLogDAO.getSingleByRowId(await rowId);
      }
      return null;
    }
    return null;
  }

  Future<VisitorCheckInEntry> _getByPhoneNumberEntry(String phoneNumber, double companyId) async {
    final query = select(visitorCheckInEntity)
      ..where((tbl) => tbl.phoneNumber.equals(phoneNumber) & tbl.companyId.equals(companyId));
    List<VisitorCheckInEntry> list = await query.get();
    if (list.isEmpty) {
      return null;
    }
    return list.first;
  }

  Future<VisitorCheckInEntry> _getVistorCheckIn(int rowId) {
    final query = select(db.visitorCheckInEntity)..limit(1, offset: rowId - 1);

    return query.getSingle();
  }

  Future<void> _updateData(String searchPhoneNumber, double companyId, VisitorCheckIn vistor) async {
    String userName;
    var userInfor = await Utilities().getUserInfor();
    if (userInfor != null) {
      userName = userInfor.userName;
    }
    VisitorCheckInEntityCompanion vistorCompanion = VisitorCheckInEntityCompanion(
        fullName: Value(vistor.fullName),
        email: Value(vistor.email),
        phoneNumber: Value(vistor.phoneNumber),
        idCard: Value(vistor.idCard),
        purpose: Value(vistor.purpose),
        visitorType: Value(vistor.visitorType),
        fromCompany: Value(vistor.fromCompany),
        toCompany: Value(vistor.toCompany),
        contactPersonId: Value(vistor.contactPersonId),
        faceCaptureRepoId: Value(vistor.faceCaptureRepoId),
        signInBy: Value(vistor.signInBy),
        signInType: Value(vistor.signInType),
        imagePath: Value(vistor.imagePath),
        companyId: Value(companyId),
        cardNo: Value(vistor.cardNo),
        goods: Value(vistor.goods),
        receiver: Value(vistor.receiver),
        visitorPosition: Value(vistor.visitorPosition),
        idCardRepoId: Value(vistor.idCardRepoId),
        idCardFile: Value(vistor.idCardFile),
        updatedBy: Value(userName),
        updatedDate: Value(DateTime.now().toUtc()),
        survey: Value(vistor.survey),
        surveyId: Value(vistor.surveyId),
        checkOutTimeExpected: Value(vistor.checkOutTimeExpected),
        customStep: Value(vistor.customStep));
    update(visitorCheckInEntity)
      ..where((tbl) => tbl.phoneNumber.equals(searchPhoneNumber))
      ..write(vistorCompanion);
  }

  Future<void> deleteAlls() async {
    delete(visitorCheckInEntity).go();
  }
}
