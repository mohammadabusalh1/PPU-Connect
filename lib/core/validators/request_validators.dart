abstract final class RequestMessageValidator {
  static String? required(String? v) {
    if (v == null || v.trim().isEmpty) return 'Message is required';
    if (v.trim().length < 10) return 'Message must be at least 10 characters';
    if (v.length > 500) return 'Message must be 500 characters or fewer';
    return null;
  }
}

abstract final class RequestSubjectValidator {
  static String? required(String? v) {
    if (v == null || v.trim().isEmpty) return 'Subject is required';
    if (v.trim().length > 100) return 'Subject must be 100 characters or fewer';
    return null;
  }
}

abstract final class RequestNotesValidator {
  static String? optional(String? v) {
    if (v == null || v.isEmpty) return null;
    if (v.length > 1000) return 'Notes must be 1,000 characters or fewer';
    return null;
  }

  /// Appointment request notes (MODELS.md: max 500 chars).
  static String? optionalForAppointment(String? v) {
    if (v == null || v.isEmpty) return null;
    if (v.length > 500) return 'Note must be 500 characters or fewer';
    return null;
  }
}
