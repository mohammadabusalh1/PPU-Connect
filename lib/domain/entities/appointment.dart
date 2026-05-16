import 'package:freezed_annotation/freezed_annotation.dart';

import '../enums/enums.dart';

part 'appointment.freezed.dart';

@freezed
class Appointment with _$Appointment {
  const factory Appointment({
    required String id,
    required String appointmentRequestId,
    required String tutorId,
    required String seekerId,
    String? tutorName,
    String? seekerName,
    required String subject,
    required DateTime startAt,
    required DateTime endAt,
    required AppointmentStatus status,
    String? cancelledBy,
    DateTime? cancelledAt,
    String? cancellationReason,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _Appointment;
}
