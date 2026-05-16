import 'package:intl/intl.dart';
import 'package:ppu_connect/domain/entities/appointment.dart';
import 'package:ppu_connect/domain/enums/enums.dart';

/// Appointments store [DateTime] values in UTC; UI uses local time.
DateTime appointmentLocal(DateTime utc) => utc.toLocal();

/// Start of the calendar day in local time.
DateTime localDay(DateTime dt) {
  final local = appointmentLocal(dt);
  return DateTime(local.year, local.month, local.day);
}

/// Terminal statuses always belong in history / past lists.
bool _isTerminalStatus(AppointmentStatus status) =>
    status == AppointmentStatus.cancelled ||
    status == AppointmentStatus.completed ||
    status == AppointmentStatus.expired;

/// Upcoming schedule tab: active sessions that have not ended yet.
bool isUpcomingAppointment(Appointment a, [DateTime? now]) {
  final nowLocal = now ?? DateTime.now();
  if (_isTerminalStatus(a.status)) return false;
  return appointmentLocal(a.endAt).isAfter(nowLocal);
}

/// Past schedule tab and history appointments list.
bool isPastAppointment(Appointment a, [DateTime? now]) {
  final nowLocal = now ?? DateTime.now();
  if (_isTerminalStatus(a.status)) return true;
  return !appointmentLocal(a.endAt).isAfter(nowLocal);
}

/// History → Sessions tab: ended or resolved sessions (not future cancellations).
bool isSessionHistory(Appointment a, [DateTime? now]) {
  if (a.status == AppointmentStatus.completed) return true;
  if (a.status == AppointmentStatus.expired) return true;
  final nowLocal = now ?? DateTime.now();
  return a.status == AppointmentStatus.confirmed &&
      !appointmentLocal(a.endAt).isAfter(nowLocal);
}

/// Section label for past/history lists. Uses [sortInstant] (usually [startAt]).
String pastSectionHeader(DateTime sortInstantUtc, [DateTime? now]) {
  final nowLocal = now ?? DateTime.now();
  final dt = appointmentLocal(sortInstantUtc);
  final today = localDay(nowLocal);
  final day = localDay(dt);
  final diff = today.difference(day).inDays;

  if (diff < 0) return 'Upcoming';
  if (diff == 0) return 'Today';
  if (diff == 1) return 'Yesterday';
  if (diff < 7) return 'This Week';
  return DateFormat('MMMM yyyy').format(dt);
}

/// Instant used for grouping/sorting (cancelledAt when future-cancelled).
DateTime historySortInstant(Appointment a) {
  if (a.status == AppointmentStatus.cancelled && a.cancelledAt != null) {
    return a.cancelledAt!;
  }
  return a.startAt;
}

/// Builds alternating section headers and appointments for a list view.
List<Object> groupAppointmentsByPastHeader(
  List<Appointment> appointments, [
  DateTime? now,
]) {
  final items = <Object>[];
  String? lastHeader;
  for (final appt in appointments) {
    final header = pastSectionHeader(historySortInstant(appt), now);
    if (header != lastHeader) {
      items.add(header);
      lastHeader = header;
    }
    items.add(appt);
  }
  return items;
}

String upcomingSectionHeader(DateTime sortInstantUtc, [DateTime? now]) {
  final nowLocal = now ?? DateTime.now();
  final dt = appointmentLocal(sortInstantUtc);
  final today = localDay(nowLocal);
  final day = localDay(dt);
  final diff = day.difference(today).inDays;

  if (diff == 0) return 'Today';
  if (diff == 1) return 'Tomorrow';
  if (diff < 7) return DateFormat('EEEE').format(dt);
  if (diff < 30) return 'Later this month';
  return DateFormat('MMMM yyyy').format(dt);
}

List<Object> groupAppointmentsByUpcomingHeader(
  List<Appointment> appointments, [
  DateTime? now,
]) {
  final items = <Object>[];
  String? lastHeader;
  for (final appt in appointments) {
    final header = upcomingSectionHeader(appt.startAt, now);
    if (header != lastHeader) {
      items.add(header);
      lastHeader = header;
    }
    items.add(appt);
  }
  return items;
}
