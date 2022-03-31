import 'package:check_in_pro_for_visitor/src/database/entities/EventTicketEntity.dart';
import 'package:check_in_pro_for_visitor/src/model/EventTicket.dart';
import 'package:moor/moor.dart';

import '../Database.dart';
part 'EventTicketDAO.g.dart';

@UseDao(tables: [EventTicketEntity])
class EventTicketDAO extends DatabaseAccessor<Database>
    with _$EventTicketDAOMixin {
  Database db;
  EventTicketDAO(this.db) : super(db);

  Future<void> insert(EventTicket eventTicket) async {
    EventTicketEntityCompanion companion = createCompanion(eventTicket);

    into(eventTicketEntity).insert(companion);
  }

  Future<void> insertAll(List<EventTicket> eventTickets) async {
    if (eventTickets?.isNotEmpty == true) {
      await batch((batch) {
        batch.insertAll(
            eventTicketEntity,
            eventTickets.map((row) {
              return createCompanion(row);
            }).toList());
      });
    }
  }

  Future<EventTicket> getEventTicket() async {
    final query = select(eventTicketEntity);
    List<EventTicket> list = await query.map((row) => EventTicket.copyWithEntity(row)).get();
    if (query == null || list.isEmpty) {
      return null;
    }
    return list.first;
  }

  Future<EventTicket> getEventTicketById(double id) async {
    final query = select(eventTicketEntity)..where((tbl) => tbl.id.equals(id));
    List<EventTicket> list = await query.map((row) => EventTicket.copyWithEntity(row)).get();
    if (query == null || list.isEmpty) {
      return null;
    }
    return list.first;
  }

  EventTicketEntityCompanion createCompanion(EventTicket eventTicket) {
    final companion = EventTicketEntityCompanion(
      id: Value(eventTicket.id),
        eventName: Value(eventTicket.eventName),
      siteName: Value(eventTicket.siteName),
      siteAddress: Value(eventTicket.siteAddress),
      eventType: Value(eventTicket.eventType),
      startDate: eventTicket.startDate == null
          ? Value.absent()
          : Value(DateTime.tryParse(eventTicket.startDate)),
      endDate: eventTicket.endDate == null
          ? Value.absent()
          : Value(DateTime.tryParse(eventTicket.endDate)),
      description: Value(eventTicket.description),
      coverPathFile: Value(eventTicket.coverPathFile),
      coverRepoId: Value(eventTicket.coverRepoId),
      contactPhone: Value(eventTicket.contactPhone),
      contactEmail: Value(eventTicket.contactEmail),
      organizersName: Value(eventTicket.organizersName),
      organizersInfo: Value(eventTicket.organizersInfo),
      reminderDays: Value(eventTicket.reminderDays),
      branchId: Value(eventTicket.branchId),
      companyId: Value(eventTicket.companyId),
      startedState: Value(eventTicket.startedState),
      orderedState: Value(eventTicket.orderedState),
    );
    return companion;
  }

  Future<void> deleteAll() async {
    delete(eventTicketEntity).go();
  }
}
