import 'package:freezed_annotation/freezed_annotation.dart';

import '../../core/utils/firestore_converters.dart';
import '../../domain/entities/appointment.dart';
import '../../domain/enums/enums.dart';

part 'appointment_model.freezed.dart';
part 'appointment_model.g.dart';

@freezed
class AppointmentModel with _$AppointmentModel {
  const factory AppointmentModel({
    required String id,
    required String appointmentRequestId,
    required String tutorId,
    required String seekerId,
    required String subject,
    @TimestampConverter() required DateTime startAt,
    @TimestampConverter() required DateTime endAt,
    @AppointmentStatusConverter() required AppointmentStatus status,
    String? cancelledBy,
    @NullableTimestampConverter() DateTime? cancelledAt,
    String? cancellationReason,
    @TimestampConverter() required DateTime createdAt,
    @TimestampConverter() required DateTime updatedAt,
  }) = _AppointmentModel;

  factory AppointmentModel.fromJson(Map<String, dynamic> json) =>
      _$AppointmentModelFromJson(json);

  factory AppointmentModel.fromEntity(Appointment entity) => AppointmentModel(
        id: entity.id,
        appointmentRequestId: entity.appointmentRequestId,
        tutorId: entity.tutorId,
        seekerId: entity.seekerId,
        subject: entity.subject,
        startAt: entity.startAt,
        endAt: entity.endAt,
        status: entity.status,
        cancelledBy: entity.cancelledBy,
        cancelledAt: entity.cancelledAt,
        cancellationReason: entity.cancellationReason,
        createdAt: entity.createdAt,
        updatedAt: entity.updatedAt,
      );
}

extension AppointmentModelX on AppointmentModel {
  Appointment toEntity() => Appointment(
        id: id,
        appointmentRequestId: appointmentRequestId,
        tutorId: tutorId,
        seekerId: seekerId,
        subject: subject,
        startAt: startAt,
        endAt: endAt,
        status: status,
        cancelledBy: cancelledBy,
        cancelledAt: cancelledAt,
        cancellationReason: cancellationReason,
        createdAt: createdAt,
        updatedAt: updatedAt,
      );
}
