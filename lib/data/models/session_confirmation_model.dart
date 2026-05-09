import 'package:freezed_annotation/freezed_annotation.dart';

import '../../core/utils/firestore_converters.dart';
import '../../domain/entities/session_confirmation.dart';
import '../../domain/enums/enums.dart';

part 'session_confirmation_model.freezed.dart';
part 'session_confirmation_model.g.dart';

@freezed
class SessionConfirmationModel with _$SessionConfirmationModel {
  const factory SessionConfirmationModel({
    required String id,
    required String appointmentId,
    required bool tutorConfirmed,
    required bool seekerConfirmed,
    @NullableTimestampConverter() DateTime? tutorConfirmedAt,
    @NullableTimestampConverter() DateTime? seekerConfirmedAt,
    @NullableSessionOutcomeConverter() SessionOutcome? outcome,
    @NullableTimestampConverter() DateTime? resolvedAt,
  }) = _SessionConfirmationModel;

  factory SessionConfirmationModel.fromJson(Map<String, dynamic> json) =>
      _$SessionConfirmationModelFromJson(json);

  factory SessionConfirmationModel.fromEntity(SessionConfirmation entity) =>
      SessionConfirmationModel(
        id: entity.id,
        appointmentId: entity.appointmentId,
        tutorConfirmed: entity.tutorConfirmed,
        seekerConfirmed: entity.seekerConfirmed,
        tutorConfirmedAt: entity.tutorConfirmedAt,
        seekerConfirmedAt: entity.seekerConfirmedAt,
        outcome: entity.outcome,
        resolvedAt: entity.resolvedAt,
      );
}

extension SessionConfirmationModelX on SessionConfirmationModel {
  SessionConfirmation toEntity() => SessionConfirmation(
        id: id,
        appointmentId: appointmentId,
        tutorConfirmed: tutorConfirmed,
        seekerConfirmed: seekerConfirmed,
        tutorConfirmedAt: tutorConfirmedAt,
        seekerConfirmedAt: seekerConfirmedAt,
        outcome: outcome,
        resolvedAt: resolvedAt,
      );
}
