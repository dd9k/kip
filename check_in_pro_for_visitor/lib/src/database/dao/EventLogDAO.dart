import 'package:check_in_pro_for_visitor/src/constants/Constants.dart';
import 'package:check_in_pro_for_visitor/src/database/Database.dart';
import 'package:check_in_pro_for_visitor/src/database/entities/EventLogEntity.dart';
import 'package:check_in_pro_for_visitor/src/model/EventLog.dart';
import 'package:moor/moor.dart';
import 'package:uuid/uuid.dart';

part 'EventLogDAO.g.dart';

@UseDao(tables: [EventLogEntity])
class EventLogDAO extends DatabaseAccessor<Database> with _$EventLogDAOMixin {
  Database db;

  EventLogDAO(db) : super(db);

  Future<void> insert(List<EventLog> eventLogs) async {
    await batch((batch) {
      batch.insertAll(
          eventLogEntity,
          eventLogs.map((row) {
            row.id = Uuid().v1();
            return createCompanion(row);
          }).toList());
    });
  }

  Future<String> insertNew(EventLog eventLogs) async {
    eventLogs.id = Uuid().v1();
    final entityCompanion = createCompanion(eventLogs);
    await into(eventLogEntity).insert(entityCompanion);
    return eventLogs.id;
  }

  Future<void> deleteAll() async {
    await delete(eventLogEntity).go();
  }

  Future<EventLog> validate(String inviteCode, String phoneNumber) async {
    String key = inviteCode?.toUpperCase() ?? phoneNumber ?? "";
    if (key.isEmpty) {
      EventLog eventLog = EventLog.init();
      eventLog.status = Constants.VALIDATE_WRONG;
      return eventLog;
    }
    final query = select(eventLogEntity)
      ..where((eventLog) => eventLog.inviteCode.equals(key) | eventLog.phoneNumber.equals(key));
    List<EventLog> list = await query.map((row) => EventLog.copyWithEntry(row)).get();
    if (query == null || list.isEmpty) {
      EventLog eventLog = EventLog.init();
      eventLog.status = Constants.VALIDATE_WRONG;
      return eventLog;
    }
    EventLog eventLog = list.first;
    if (eventLog.signIn == null) {
      eventLog.status = Constants.VALIDATE_IN;
    } else if (eventLog.signOut == null) {
      eventLog.status = Constants.VALIDATE_OUT;
    } else {
      eventLog.status = Constants.VALIDATE_ALREADY;
    }
    return eventLog;
  }

  Future<List<EventLog>> getFailLogs() async {
    final query = select(eventLogEntity)..where((eventLog) => eventLog.syncFail);
    List<EventLog> list = await query.map((row) => EventLog.copyWithEntry(row)).get();
    if (query == null || list == null || list.isEmpty) {
      return List();
    }
    return list;
  }

  Future<EventLog> getFirstLog() async {
    final query = select(eventLogEntity);
    List<EventLog> list = await query.map((row) => EventLog.copyWithEntry(row)).get();
    if (query == null || list == null || list.isEmpty) {
      return EventLog.init();
    }
    return list[0];
  }

  Future<List<EventLog>> getAllLogs() async {
    final query = select(eventLogEntity);
    List<EventLog> list = await query.map((row) => EventLog.copyWithEntry(row)).get();
    if (query == null || list == null || list.isEmpty) {
      return List();
    }
    return list;
  }

  void updateRow(EventLog eventLog) {
    EventLogEntityCompanion companion = createCompanion(eventLog);
    update(eventLogEntity)
      ..where((tbl) => tbl.id.equals(eventLog.id))
      ..write(companion);
  }

  EventLogEntityCompanion createCompanion(EventLog eventLog) {
    EventLogEntityCompanion companion = EventLogEntityCompanion(
        id: Value(eventLog.id),
        guestId: Value(eventLog.guestId),
        fullName: Value(eventLog.fullName),
        email: Value(eventLog.email),
        phoneNumber: Value(eventLog.phoneNumber),
        inviteCode: Value(eventLog.inviteCode),
        timeZone: Value(eventLog.timeZone),
        idCard: Value(eventLog.idCard),
        signInType: Value(Constants.TYPE_CHECK),
        signOutType: Value(Constants.TYPE_CHECK),
        imagePath: Value(eventLog.imagePath),
        imageIdPath: Value(eventLog.imageIdPath),
        eventId: Value(eventLog.eventId),
        signIn: Value(eventLog.signIn),
        signOut: Value(eventLog.signOut),
        feedback: Value(eventLog.feedback),
        rating: Value(eventLog.rating),
        branchId: Value(eventLog.branchId),
        status: Value(eventLog.status),
        visitorType: Value(eventLog.visitorType),
        syncFail: Value(eventLog.syncFail),
        faceCaptureFile: Value(eventLog.faceCaptureFile));
    return companion;
  }
}
