import 'package:freezed_annotation/freezed_annotation.dart';

import '../enums/enums.dart';

part 'session_confirmation.freezed.dart';

@freezed
class SessionConfirmation with _$SessionConfirmation {
  const factory SessionConfirmation({
    required String id,
    required String appointmentId,
    required bool tutorConfirmed,
    required bool seekerConfirmed,
    DateTime? tutorConfirmedAt,
    DateTime? seekerConfirmedAt,
    SessionOutcome? outcome,
    DateTime? resolvedAt,
  }) = _SessionConfirmation;
}
