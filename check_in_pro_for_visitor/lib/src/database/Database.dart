import 'package:check_in_pro_for_visitor/src/database/dao/CompanyBuildingDAO.dart';
import 'package:check_in_pro_for_visitor/src/database/dao/ConfigurationDAO.dart';
import 'package:check_in_pro_for_visitor/src/database/dao/ContactPersonDAO.dart';
import 'package:check_in_pro_for_visitor/src/database/dao/ETOrderDetailInfoDAO.dart';
import 'package:check_in_pro_for_visitor/src/database/dao/ETOrderInfoDAO.dart';
import 'package:check_in_pro_for_visitor/src/database/dao/EventDetailDAO.dart';
import 'package:check_in_pro_for_visitor/src/database/dao/EventTicketDAO.dart';
import 'package:check_in_pro_for_visitor/src/database/dao/ImageDownloadedDAO.dart';
import 'package:check_in_pro_for_visitor/src/database/dao/VisitorCheckInDAO.dart';
import 'package:check_in_pro_for_visitor/src/database/dao/VisitorCompanyDAO.dart';
import 'package:check_in_pro_for_visitor/src/database/dao/VisitorLogDAO.dart';
import 'package:check_in_pro_for_visitor/src/database/dao/VisitorTypeDAO.dart';
import 'package:check_in_pro_for_visitor/src/database/dao/EventLogDAO.dart';
import 'package:check_in_pro_for_visitor/src/database/entities/CheckInFlowEntity.dart';
import 'package:check_in_pro_for_visitor/src/database/entities/CompanyBuildingEntity.dart';
import 'package:check_in_pro_for_visitor/src/database/entities/ConfigurationEntity.dart';
import 'package:check_in_pro_for_visitor/src/database/entities/ContactPersonEntity.dart';
import 'package:check_in_pro_for_visitor/src/database/entities/ETOrderDetailInfoEntity.dart';
import 'package:check_in_pro_for_visitor/src/database/entities/ETOrderInfoEntity.dart';
import 'package:check_in_pro_for_visitor/src/database/entities/EventDetailEntity.dart';
import 'package:check_in_pro_for_visitor/src/database/entities/EventTicketEntity.dart';
import 'package:check_in_pro_for_visitor/src/database/entities/ImageDownloadedEntity.dart';
import 'package:check_in_pro_for_visitor/src/database/entities/VisitorCheckInEntity.dart';
import 'package:check_in_pro_for_visitor/src/database/entities/VisitorCompanyEntity.dart';
import 'package:check_in_pro_for_visitor/src/database/entities/VisitorLogEntity.dart';
import 'package:check_in_pro_for_visitor/src/database/entities/VisitorTypeEntity.dart';
import 'package:check_in_pro_for_visitor/src/database/entities/EventLogEntity.dart';
import 'package:moor/moor.dart';
import 'dao/CheckInFlowDAO.dart';
import 'dao/VisitorValueDAO.dart';
import 'entities/VisitorValueEntity.dart';

part 'Database.g.dart';

@UseMoor(tables: [
  ConfigurationEntity,
  VisitorCheckInEntity,
  VisitorTypeEntity,
  CheckInFlowEntity,
  VisitorLogEntity,
  CompanyBuildingEntity,
  VisitorCompanyEntity,
  ContactPersonEntity,
  VisitorValueEntity,
  EventLogEntity,
  EventDetailEntity,
  ImageDownloadedEntity,
  ETOrderDetailInfoEntity,
  ETOrderInfoEntity,
  EventTicketEntity
], daos: [
  ConfigurationDAO,
  VisitorCheckInDAO,
  VisitorTypeDAO,
  CheckInFlowDAO,
  VisitorLogDAO,
  CompanyBuildingDAO,
  VisitorCompanyDAO,
  ContactPersonDAO,
  VisitorValueDAO,
  EventLogDAO,
  EventDetailDAO,
  ImageDownloadedDAO,
  ETOrderDetailInfoDAO,
  ETOrderInfoDAO,
  EventTicketDAO
])
class Database extends _$Database {
  Database(QueryExecutor e) : super(e);

  @override
  int get schemaVersion => 11;

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(onCreate: (Migrator m) {
      return m.createAll();
    }, onUpgrade: (Migrator m, int from, int to) async {
      if (from < 2) {
        m.addColumn(visitorCheckInEntity, visitorCheckInEntity.cardNo);
        m.addColumn(visitorCheckInEntity, visitorCheckInEntity.goods);
        m.addColumn(visitorCheckInEntity, visitorCheckInEntity.receiver);
        m.addColumn(visitorCheckInEntity, visitorCheckInEntity.visitorPosition);

        m.addColumn(visitorTypeEntity, visitorTypeEntity.isTakePicture);
        m.addColumn(visitorTypeEntity, visitorTypeEntity.isScanIdCard);
        m.addColumn(visitorTypeEntity, visitorTypeEntity.isPrintCard);

        m.createTable(visitorValueEntity);

        m.addColumn(companyBuildingEntity, companyBuildingEntity.shortNameUnsigned);

        // Change column type isRequired
        m.deleteTable('cip_check_in_flow');
        m.createTable(checkInFlowEntity);
      }
      if (from < 3) {
        // Add column 20200928
        m.addColumn(visitorLogEntity, visitorLogEntity.cardNo);
        m.addColumn(visitorLogEntity, visitorLogEntity.receiver);
        m.addColumn(visitorLogEntity, visitorLogEntity.goods);
        m.addColumn(visitorLogEntity, visitorLogEntity.visitorPosition);

        // Add column 20201001
        m.addColumn(visitorCheckInEntity, visitorCheckInEntity.idCardRepoId);
        m.addColumn(visitorCheckInEntity, visitorCheckInEntity.idCardFile);
        m.addColumn(visitorCheckInEntity, visitorCheckInEntity.faceCaptureFile);

        m.addColumn(visitorLogEntity, visitorLogEntity.imageIdPath);
        m.addColumn(visitorLogEntity, visitorLogEntity.idCardRepoId);
        m.addColumn(visitorLogEntity, visitorLogEntity.idCardFile);
      }

      if (from < 4) {
        // Add column 20201026
        m.addColumn(visitorLogEntity, visitorLogEntity.survey);
        m.addColumn(visitorCheckInEntity, visitorLogEntity.survey);
      }
      if (from < 5) {
        // Add column 20201112
        m.addColumn(contactPersonEntity, contactPersonEntity.logoPathLocal);
        m.addColumn(contactPersonEntity, contactPersonEntity.index);
        m.addColumn(contactPersonEntity, contactPersonEntity.department);
        m.addColumn(visitorTypeEntity, visitorTypeEntity.allowToDisplayContactPerson);
      }
      if (from < 6) {
        // Add column 20201224
        m.addColumn(visitorTypeEntity, visitorTypeEntity.isSurvey);
        m.addColumn(visitorCheckInEntity, visitorCheckInEntity.surveyId);
        m.addColumn(visitorCheckInEntity, visitorCheckInEntity.survey);
        m.addColumn(visitorLogEntity, visitorLogEntity.surveyId);
        m.addColumn(visitorLogEntity, visitorLogEntity.survey);
      }
      if (from < 7) {
        // Add column 20210203
        m.createTable(eventLogEntity);
        m.createTable(eventDetailEntity);
      }
      if (from < 8) {
        // Add column 20210408
        m.addColumn(companyBuildingEntity, companyBuildingEntity.representativeId);
      }
      if (from < 9) {
        // Add column 20210507
        m.addColumn(visitorCheckInEntity, visitorCheckInEntity.checkOutTimeExpected);
        m.addColumn(visitorLogEntity, visitorLogEntity.checkOutTimeExpected);
      }
      if (from < 10) {
        // Add column 20210515
        m.createTable(imageDownloadedEntity);
        m.addColumn(visitorCheckInEntity, visitorCheckInEntity.customStep);
        m.addColumn(visitorLogEntity, visitorLogEntity.customStep);
      }
      if (from < 11) {
        m.createTable(eTOrderDetailInfoEntity);
        m.createTable(eTOrderInfoEntity);
        m.createTable(eventTicketEntity);
      }
    });
  }

  Future<void> deleteAllDataInDB() async {
    await delete(configurationEntity).go();
    await delete(checkInFlowEntity).go();
    await delete(visitorCheckInEntity).go();
    await delete(visitorLogEntity).go();
    await delete(visitorTypeEntity).go();
    await delete(companyBuildingEntity).go();
    await delete(visitorCompanyEntity).go();
    await delete(visitorValueEntity).go();
    await delete(eventLogEntity).go();
    await delete(eventDetailEntity).go();
    await delete(imageDownloadedEntity).go();
  }
}
