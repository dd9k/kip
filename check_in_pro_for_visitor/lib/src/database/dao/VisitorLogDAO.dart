import 'package:check_in_pro_for_visitor/src/constants/Constants.dart';
import 'package:check_in_pro_for_visitor/src/database/Database.dart';
import 'package:check_in_pro_for_visitor/src/database/entities/VisitorLogEntity.dart';
import 'package:check_in_pro_for_visitor/src/model/VisitorLog.dart';
import 'package:check_in_pro_for_visitor/src/utilities/Utilities.dart';
import 'package:moor/moor.dart';

part 'VisitorLogDAO.g.dart';

@UseDao(tables: [VisitorLogEntity])
class VisitorLogDAO extends DatabaseAccessor<Database> with _$VisitorLogDAOMixin {
  final Database db;

  VisitorLogDAO(this.db) : super(db);

  Future<List<VisitorLog>> getAlls() {
    final query = select(visitorLogEntity).join(
        [innerJoin(db.visitorCheckInEntity, db.visitorCheckInEntity.visitorId.equalsExp(visitorLogEntity.visitorId))]);
    final result = query.map((row) {
      final visitorCheckInData = row.readTable(db.visitorCheckInEntity);
      final visitorCheckInLogData = row.readTable(visitorLogEntity);
      return VisitorLog.init(
          visitorCheckInLogData.id,
          0,
          visitorCheckInData.fullName,
          visitorCheckInData.email,
          visitorCheckInData.phoneNumber,
          visitorCheckInData.idCard,
          visitorCheckInData.purpose,
          0,
          visitorCheckInData.visitorType,
          visitorCheckInData.fromCompany,
          visitorCheckInData.toCompany,
          visitorCheckInData.contactPersonId,
          visitorCheckInData.faceCaptureRepoId,
          visitorCheckInData.faceCaptureFile,
          visitorCheckInData.signInBy,
          visitorCheckInData.signInType,
          visitorCheckInLogData.signOutBy,
          visitorCheckInLogData.signOutType,
          visitorCheckInData.imagePath,
          visitorCheckInLogData.imageIdPath,
          visitorCheckInLogData.logId,
          visitorCheckInLogData.signIn.millisecondsSinceEpoch ~/ 1000,
          visitorCheckInLogData.signOut == null
              ? visitorCheckInLogData.signOut
              : visitorCheckInLogData.signOut.millisecondsSinceEpoch ~/ 1000,
          visitorCheckInLogData.branchId,
          visitorCheckInData.createdBy,
          visitorCheckInLogData.feedBack,
          visitorCheckInLogData.rating,
          visitorCheckInLogData.cardNo,
          visitorCheckInLogData.goods,
          visitorCheckInLogData.receiver,
          visitorCheckInLogData.visitorPosition,
          visitorCheckInLogData.idCardRepoId,
          visitorCheckInLogData.idCardFile,
          visitorCheckInLogData.survey,
          visitorCheckInLogData.gender,
          visitorCheckInLogData.passportNo,
          visitorCheckInLogData.nationality,
          visitorCheckInLogData.birthDay,
          visitorCheckInLogData.permanentAddress,
          visitorCheckInLogData.departmentRoomNo,
          visitorCheckInLogData.surveyId,
          visitorCheckInLogData.checkOutTimeExpected,
          visitorCheckInLogData.customStep);
    });
    return result.get();
  }

  Future<VisitorLog> getById(String primaryKey) {
    final query = select(visitorLogEntity).join(
        [innerJoin(db.visitorCheckInEntity, db.visitorCheckInEntity.visitorId.equalsExp(visitorLogEntity.visitorId))])
      ..where(visitorLogEntity.id.equals(primaryKey));

    final result = query.map((row) {
      final visitorCheckInData = row.readTable(db.visitorCheckInEntity);
      final visitorCheckInLogData = row.readTable(visitorLogEntity);
      return VisitorLog.init(
          visitorCheckInLogData.id,
          0,
          visitorCheckInData.fullName,
          visitorCheckInData.email,
          visitorCheckInData.phoneNumber,
          visitorCheckInData.idCard,
          visitorCheckInData.purpose,
          0,
          visitorCheckInData.visitorType,
          visitorCheckInData.fromCompany,
          visitorCheckInData.toCompany,
          visitorCheckInData.contactPersonId,
          visitorCheckInData.faceCaptureRepoId,
          visitorCheckInData.faceCaptureFile,
          visitorCheckInData.signInBy,
          visitorCheckInData.signInType,
          visitorCheckInLogData.signOutBy,
          visitorCheckInLogData.signOutType,
          visitorCheckInData.imagePath,
          visitorCheckInLogData.imageIdPath,
          visitorCheckInLogData.logId,
          visitorCheckInLogData.signIn.millisecondsSinceEpoch ~/ 1000,
          visitorCheckInLogData.signOut == null
              ? visitorCheckInLogData.signOut
              : visitorCheckInLogData.signOut.millisecondsSinceEpoch ~/ 1000,
          visitorCheckInLogData.branchId,
          visitorCheckInData.createdBy,
          visitorCheckInLogData.feedBack,
          visitorCheckInLogData.rating,
          visitorCheckInLogData.cardNo,
          visitorCheckInLogData.goods,
          visitorCheckInLogData.receiver,
          visitorCheckInLogData.visitorPosition,
          visitorCheckInLogData.idCardRepoId,
          visitorCheckInLogData.idCardFile,
          visitorCheckInLogData.survey,
          visitorCheckInLogData.gender,
          visitorCheckInLogData.passportNo,
          visitorCheckInLogData.nationality,
          visitorCheckInLogData.birthDay,
          visitorCheckInLogData.permanentAddress,
          visitorCheckInLogData.departmentRoomNo,
          visitorCheckInLogData.surveyId,
          visitorCheckInLogData.checkOutTimeExpected,
          visitorCheckInLogData.customStep);
    });
    return result.getSingle();
  }

  Future<List<VisitorLog>> getAllSignOut() {
    final query = select(visitorLogEntity).join(
        [innerJoin(db.visitorCheckInEntity, db.visitorCheckInEntity.visitorId.equalsExp(visitorLogEntity.visitorId))])
      ..where(isNotNull(visitorLogEntity.signOut));

    final result = query.map((row) {
      final visitorCheckInData = row.readTable(db.visitorCheckInEntity);
      final visitorCheckInLogData = row.readTable(visitorLogEntity);
      return VisitorLog.init(
          visitorCheckInLogData.id,
          0,
          visitorCheckInData.fullName,
          visitorCheckInData.email,
          visitorCheckInData.phoneNumber,
          visitorCheckInData.idCard,
          visitorCheckInData.purpose,
          0,
          visitorCheckInData.visitorType,
          visitorCheckInData.fromCompany,
          visitorCheckInData.toCompany,
          visitorCheckInData.contactPersonId,
          visitorCheckInData.faceCaptureRepoId,
          visitorCheckInData.faceCaptureFile,
          visitorCheckInData.signInBy,
          visitorCheckInData.signInType,
          visitorCheckInLogData.signOutBy,
          visitorCheckInLogData.signOutType,
          visitorCheckInData.imagePath,
          visitorCheckInLogData.imageIdPath,
          visitorCheckInLogData.logId,
          visitorCheckInLogData.signIn.millisecondsSinceEpoch ~/ 1000,
          visitorCheckInLogData.signOut == null
              ? visitorCheckInLogData.signOut
              : visitorCheckInLogData.signOut.millisecondsSinceEpoch ~/ 1000,
          visitorCheckInLogData.branchId,
          visitorCheckInData.createdBy,
          visitorCheckInLogData.feedBack,
          visitorCheckInLogData.rating,
          visitorCheckInLogData.cardNo,
          visitorCheckInLogData.goods,
          visitorCheckInLogData.receiver,
          visitorCheckInLogData.visitorPosition,
          visitorCheckInLogData.idCardRepoId,
          visitorCheckInLogData.idCardFile,
          visitorCheckInLogData.survey,
          visitorCheckInLogData.gender,
          visitorCheckInLogData.passportNo,
          visitorCheckInLogData.nationality,
          visitorCheckInLogData.birthDay,
          visitorCheckInLogData.permanentAddress,
          visitorCheckInLogData.departmentRoomNo,
          visitorCheckInLogData.surveyId,
          visitorCheckInLogData.checkOutTimeExpected,
          visitorCheckInLogData.customStep);
    });
    return result.get();
  }

  Future<dynamic> checkExistCheckOut(String phoneNumber, int signIn) async {
    double companyId;
    double branchId;
    var userInfor = await Utilities().getUserInfor();
    if (userInfor != null) {
      companyId = userInfor.companyInfo.id;
      branchId = userInfor.deviceInfo.branchId;
    }

    final query_1 = await (select(visitorLogEntity).join([
      innerJoin(db.visitorCheckInEntity, db.visitorCheckInEntity.visitorId.equalsExp(visitorLogEntity.visitorId))
    ])
          ..where(db.visitorCheckInEntity.phoneNumber.equals(phoneNumber) &
              db.visitorCheckInEntity.companyId.equals(companyId)))
        .get();
    if (query_1 == null) {
      return "VIS_NoVisitorInformation";
    }
    if (query_1.length <= 0) {
      return "VIS_NoVisitorInformation";
    }
    final DateTime singInDateTime = DateTime.fromMillisecondsSinceEpoch(signIn);
    final query_2 = await (select(visitorLogEntity).join([
      innerJoin(db.visitorCheckInEntity, db.visitorCheckInEntity.visitorId.equalsExp(visitorLogEntity.visitorId))
    ])
          ..where(db.visitorCheckInEntity.phoneNumber.equals(phoneNumber) &
              visitorLogEntity.companyId.equals(companyId) &
              visitorLogEntity.branchId.equals(branchId) &
              isNull(visitorLogEntity.signOut) &
              visitorLogEntity.signIn.day.equals(singInDateTime.day) &
              visitorLogEntity.signIn.month.equals(singInDateTime.month) &
              visitorLogEntity.signIn.year.equals(singInDateTime.year)))
        .get();
    if (query_2 == null || query_2.isEmpty) {
      return "GEN_DataNotFound";
    }
    final visitorCheckInData = query_2.last.readTable(db.visitorCheckInEntity);
    final visitorCheckInLogData = query_2.last.readTable(visitorLogEntity);
    return VisitorLog.init(
        visitorCheckInLogData.id,
        0,
        visitorCheckInData.fullName,
        visitorCheckInData.email,
        visitorCheckInData.phoneNumber,
        visitorCheckInData.idCard,
        visitorCheckInData.purpose,
        0,
        visitorCheckInData.visitorType,
        visitorCheckInData.fromCompany,
        visitorCheckInData.toCompany,
        visitorCheckInData.contactPersonId,
        visitorCheckInData.faceCaptureRepoId,
        visitorCheckInData.faceCaptureFile,
        visitorCheckInData.signInBy,
        visitorCheckInData.signInType,
        visitorCheckInLogData.signOutBy,
        visitorCheckInLogData.signOutType,
        visitorCheckInData.imagePath,
        visitorCheckInLogData.imageIdPath,
        visitorCheckInLogData.logId,
        visitorCheckInLogData.signIn.millisecondsSinceEpoch ~/ 1000,
        visitorCheckInLogData.signOut == null
            ? visitorCheckInLogData.signOut
            : visitorCheckInLogData.signOut.millisecondsSinceEpoch ~/ 1000,
        visitorCheckInLogData.branchId,
        visitorCheckInData.createdBy,
        visitorCheckInLogData.feedBack,
        visitorCheckInLogData.rating,
        visitorCheckInLogData.cardNo,
        visitorCheckInLogData.goods,
        visitorCheckInLogData.receiver,
        visitorCheckInLogData.visitorPosition,
        visitorCheckInLogData.idCardRepoId,
        visitorCheckInLogData.idCardFile,
        visitorCheckInLogData.survey,
        visitorCheckInLogData.gender,
        visitorCheckInLogData.passportNo,
        visitorCheckInLogData.nationality,
        visitorCheckInLogData.birthDay,
        visitorCheckInLogData.permanentAddress,
        visitorCheckInLogData.departmentRoomNo,
        visitorCheckInLogData.surveyId,
        visitorCheckInLogData.checkOutTimeExpected,
        visitorCheckInLogData.customStep);
  }

  Future<dynamic> checkExistCheckOutByIdCard(String idCard, int signIn) async {
    double companyId;
    double branchId;
    var userInfor = await Utilities().getUserInfor();
    if (userInfor != null) {
      companyId = userInfor.companyInfo.id;
      branchId = userInfor.deviceInfo.branchId;
    }

    final query_1 = await (select(visitorLogEntity).join([
      innerJoin(db.visitorCheckInEntity, db.visitorCheckInEntity.visitorId.equalsExp(visitorLogEntity.visitorId))
    ])
          ..where(db.visitorCheckInEntity.idCard.equals(idCard) & db.visitorCheckInEntity.companyId.equals(companyId)))
        .get();
    if (query_1 == null) {
      return "VIS_NoVisitorInformation";
    }
    if (query_1.length <= 0) {
      return "VIS_NoVisitorInformation";
    }
    final DateTime singInDateTime = DateTime.fromMillisecondsSinceEpoch(signIn);
    final query_2 = await (select(visitorLogEntity).join([
      innerJoin(db.visitorCheckInEntity, db.visitorCheckInEntity.visitorId.equalsExp(visitorLogEntity.visitorId))
    ])
          ..where(db.visitorCheckInEntity.idCard.equals(idCard) &
              visitorLogEntity.companyId.equals(companyId) &
              visitorLogEntity.branchId.equals(branchId) &
              isNull(visitorLogEntity.signOut) &
              visitorLogEntity.signIn.day.equals(singInDateTime.day) &
              visitorLogEntity.signIn.month.equals(singInDateTime.month) &
              visitorLogEntity.signIn.year.equals(singInDateTime.year)))
        .get();
    if (query_2 == null || query_2.isEmpty) {
      return "GEN_DataNotFound";
    }
    final visitorCheckInData = query_2.last.readTable(db.visitorCheckInEntity);
    final visitorCheckInLogData = query_2.last.readTable(visitorLogEntity);
    return VisitorLog.init(
        visitorCheckInLogData.id,
        0,
        visitorCheckInData.fullName,
        visitorCheckInData.email,
        visitorCheckInData.phoneNumber,
        visitorCheckInData.idCard,
        visitorCheckInData.purpose,
        0,
        visitorCheckInData.visitorType,
        visitorCheckInData.fromCompany,
        visitorCheckInData.toCompany,
        visitorCheckInData.contactPersonId,
        visitorCheckInData.faceCaptureRepoId,
        visitorCheckInData.faceCaptureFile,
        visitorCheckInData.signInBy,
        visitorCheckInData.signInType,
        visitorCheckInLogData.signOutBy,
        visitorCheckInLogData.signOutType,
        visitorCheckInData.imagePath,
        visitorCheckInLogData.imageIdPath,
        visitorCheckInLogData.logId,
        visitorCheckInLogData.signIn.millisecondsSinceEpoch ~/ 1000,
        visitorCheckInLogData.signOut == null
            ? visitorCheckInLogData.signOut
            : visitorCheckInLogData.signOut.millisecondsSinceEpoch ~/ 1000,
        visitorCheckInLogData.branchId,
        visitorCheckInData.createdBy,
        visitorCheckInLogData.feedBack,
        visitorCheckInLogData.rating,
        visitorCheckInLogData.cardNo,
        visitorCheckInLogData.goods,
        visitorCheckInLogData.receiver,
        visitorCheckInLogData.visitorPosition,
        visitorCheckInLogData.idCardRepoId,
        visitorCheckInLogData.idCardFile,
        visitorCheckInLogData.survey,
        visitorCheckInLogData.gender,
        visitorCheckInLogData.passportNo,
        visitorCheckInLogData.nationality,
        visitorCheckInLogData.birthDay,
        visitorCheckInLogData.permanentAddress,
        visitorCheckInLogData.departmentRoomNo,
        visitorCheckInLogData.surveyId,
        visitorCheckInLogData.checkOutTimeExpected,
        visitorCheckInLogData.customStep);
  }

  Future<void> deleteAlls() async {
    await delete(visitorLogEntity).go();
  }

  Future<void> deleteById(String id) async {
    final query = delete(visitorLogEntity)..where((tbl) => tbl.id.equals(id));
    await query.go();
  }

  Future<int> insertVistorLogSignIn(
      String visitorId,
      int signIn,
      String userName,
      double companyId,
      double branchId,
      int signOutBy,
      String cardNo,
      String goods,
      String receiver,
      String visitorPosition,
      String imageIdPath,
      double idCardRepoId,
      String idCardFile,
      String survey,
      double surveyId,
      String checkOutTimeExpected,
      String customStep) async {
    final visitorLogCompanion = VisitorLogEntityCompanion(
        visitorId: Value(visitorId),
        companyId: Value(companyId),
        branchId: Value(branchId),
        signIn: Value(DateTime.fromMillisecondsSinceEpoch(signIn)),
        signOutBy: Value(signOutBy),
        signOutType: Value(Constants.TYPE_CHECK),
        feedBack: Value.absent(),
        rating: Value.absent(),
        cardNo: Value(cardNo),
        goods: Value(goods),
        receiver: Value(receiver),
        visitorPosition: Value(visitorPosition),
        imageIdPath: Value(imageIdPath),
        idCardRepoId: Value(idCardRepoId),
        idCardFile: Value(idCardFile),
        createdBy: Value(userName),
        createdDate: Value(DateTime.now().toUtc()),
        updatedBy: Value(userName),
        updatedDate: Value(DateTime.now().toUtc()),
        survey: Value(survey),
        surveyId: Value(surveyId),
        checkOutTimeExpected: Value(checkOutTimeExpected),
        customStep: Value(customStep)
        );
    final affectRow = into(db.visitorLogEntity).insert(visitorLogCompanion);

    return affectRow;
  }

  Future<VisitorLog> getSingleByRowId(int rowId) async {
    final vistorLog = await (select(visitorLogEntity)..limit(1, offset: rowId - 1)).getSingle();
    final query = select(visitorLogEntity).join(
        [innerJoin(db.visitorCheckInEntity, db.visitorCheckInEntity.visitorId.equalsExp(visitorLogEntity.visitorId))])
      ..where(visitorLogEntity.id.equals(vistorLog.id));

    final result = query.map((row) {
      final visitorCheckInData = row.readTable(db.visitorCheckInEntity);
      final visitorCheckInLogData = row.readTable(visitorLogEntity);
      return VisitorLog.init(
          visitorCheckInLogData.id,
          0,
          visitorCheckInData.fullName,
          visitorCheckInData.email,
          visitorCheckInData.phoneNumber,
          visitorCheckInData.idCard,
          visitorCheckInData.purpose,
          0,
          visitorCheckInData.visitorType,
          visitorCheckInData.fromCompany,
          visitorCheckInData.toCompany,
          visitorCheckInData.contactPersonId,
          visitorCheckInData.faceCaptureRepoId,
          visitorCheckInData.faceCaptureFile,
          visitorCheckInData.signInBy,
          visitorCheckInData.signInType,
          visitorCheckInLogData.signOutBy,
          visitorCheckInLogData.signOutType,
          visitorCheckInData.imagePath,
          visitorCheckInLogData.imageIdPath,
          visitorCheckInLogData.logId,
          visitorCheckInLogData.signIn.millisecondsSinceEpoch ~/ 1000,
          visitorCheckInLogData.signOut == null
              ? visitorCheckInLogData.signOut
              : visitorCheckInLogData.signOut.millisecondsSinceEpoch ~/ 1000,
          visitorCheckInLogData.branchId,
          visitorCheckInData.createdBy,
          visitorCheckInLogData.feedBack,
          visitorCheckInLogData.rating,
          visitorCheckInLogData.cardNo,
          visitorCheckInLogData.goods,
          visitorCheckInLogData.receiver,
          visitorCheckInLogData.visitorPosition,
          visitorCheckInLogData.idCardRepoId,
          visitorCheckInLogData.idCardFile,
          visitorCheckInLogData.survey,
          visitorCheckInLogData.gender,
          visitorCheckInLogData.passportNo,
          visitorCheckInLogData.nationality,
          visitorCheckInLogData.birthDay,
          visitorCheckInLogData.permanentAddress,
          visitorCheckInLogData.departmentRoomNo,
          visitorCheckInLogData.surveyId,
          visitorCheckInLogData.checkOutTimeExpected,
          visitorCheckInLogData.customStep);
    });
    return result.getSingle();
  }

  Future<VisitorLogEntry> _getSingleByIdEntry(String id) {
    final query = select(visitorLogEntity)..where((tbl) => tbl.id.equals(id));

    return query.getSingle();
  }

  Future<bool> insertVistorLogSignOut(VisitorLog visitorLog, int signOut) async {
    if (signOut == null || visitorLog == null) {
      return false;
    }
    String userName;
    var userInfor = await Utilities().getUserInfor();
    if (userInfor != null) {
      userName = userInfor.userName;
    }
    final entry = await _getSingleByIdEntry(visitorLog.privateKey);
    // Create companion object
    VisitorLogEntityCompanion visitorLogCompanion = VisitorLogEntityCompanion(
      signOut: Value(DateTime.fromMillisecondsSinceEpoch(signOut)),
      signOutBy: Value(entry.signOutBy),
      signOutType: Value(Constants.TYPE_CHECK),
      feedBack: Value(visitorLog.feedback),
      rating: Value(visitorLog.rating),
      cardNo: Value(visitorLog.cardNo),
      goods: Value(visitorLog.goods),
      receiver: Value(visitorLog.receiver),
      visitorPosition: Value(visitorLog.visitorPosition),
      imageIdPath: Value(visitorLog.imageIdPath),
      idCardRepoId: Value(visitorLog.idCardRepoId),
      idCardFile: Value(visitorLog.idCardFile),
      updatedBy: Value(userName),
      updatedDate: Value(DateTime.now().toUtc()),
      survey: Value(visitorLog.survey),
      surveyId: Value(visitorLog.surveyId),
      checkOutTimeExpected: Value(visitorLog.checkOutTimeExpected),
      customStep: Value(visitorLog.customStep)
    );
    // Update data
    update(visitorLogEntity)
      ..where((tbl) => tbl.id.equals(visitorLog.privateKey))
      ..write(visitorLogCompanion);

    return true;
  }
}
