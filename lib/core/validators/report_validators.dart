abstract final class ReportReasonValidator {
  static const _validReasons = {
    'no_show',
    'inappropriate_behavior',
    'payment_dispute',
    'quality_issue',
    'other',
  };

  static String? required(String? v) {
    if (v == null || v.trim().isEmpty) return 'Reason is required';
    if (!_validReasons.contains(v)) return 'Select a valid reason';
    return null;
  }
}

abstract final class ReportDescriptionValidator {
  static String? required(String? v) {
    if (v == null || v.trim().isEmpty) return 'Description is required';
    if (v.trim().length < 20) return 'Provide at least 20 characters of detail';
    if (v.length > 2000) return 'Description must be 2,000 characters or fewer';
    return null;
  }
}
