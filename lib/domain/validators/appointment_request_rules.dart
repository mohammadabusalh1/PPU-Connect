import 'package:ppu_connect/domain/entities/appointment_request.dart';
import 'package:ppu_connect/domain/enums/enums.dart';

/// Domain rules for [AppointmentRequest] lifecycle (see MODELS.md).
abstract final class AppointmentRequestRules {
  static const minDuration = Duration(minutes: 30);
  static const maxNoteLength = 500;
  static const maxSubjectLength = 100;

  /// Returns an error message when the request cannot be sent, or `null` if valid.
  static String? validateForSend(AppointmentRequest request, DateTime now) {
    if (request.tutorId.isEmpty) {
      return 'Tutor is required';
    }
    if (request.seekerId.isEmpty) {
      return 'You must be signed in to send a request';
    }
    if (request.seekerId == request.tutorId) {
      return 'You cannot request a session with yourself';
    }
    if (request.subject.trim().isEmpty) {
      return 'Subject is required';
    }
    if (request.subject.trim().length > maxSubjectLength) {
      return 'Subject must be $maxSubjectLength characters or fewer';
    }
    final note = request.note;
    if (note != null && note.length > maxNoteLength) {
      return 'Note must be $maxNoteLength characters or fewer';
    }

    final start = request.proposedStartAt.toUtc();
    final end = request.proposedEndAt.toUtc();
    if (!end.isAfter(start)) {
      return 'End time must be after start time';
    }
    if (end.difference(start) < minDuration) {
      return 'Session must be at least 30 minutes';
    }
    if (!start.isAfter(now.toUtc())) {
      return 'Session must be scheduled in the future';
    }
    if (!request.expiresAt.toUtc().isBefore(start)) {
      return 'Invalid request expiry';
    }
    return null;
  }

  /// Pending requests past [expiresAt] are treated as expired in the UI and on accept.
  static AppointmentRequest withEffectiveStatus(
    AppointmentRequest request,
    DateTime now,
  ) {
    if (request.status != RequestStatus.pending) return request;
    if (!now.toUtc().isBefore(request.expiresAt.toUtc())) {
      return request.copyWith(status: RequestStatus.expired);
    }
    return request;
  }

  static bool isActionableByTutor(AppointmentRequest request, DateTime now) {
    final effective = withEffectiveStatus(request, now);
    return effective.status == RequestStatus.pending;
  }

  static bool isCancellableBySeeker(AppointmentRequest request, DateTime now) {
    final effective = withEffectiveStatus(request, now);
    return effective.status == RequestStatus.pending;
  }
}
