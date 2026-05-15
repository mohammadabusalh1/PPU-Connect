abstract final class PhoneValidator {
  static final _e164 = RegExp(r'^\+[1-9]\d{7,14}$');

  static String? e164(String? v) {
    if (v == null || v.trim().isEmpty) return null;
    if (!_e164.hasMatch(v.trim())) {
      return 'Enter a valid phone number (e.g. +970591234567)';
    }
    return null;
  }
}

abstract final class BioValidator {
  static String? length(String? v) {
    if (v == null || v.isEmpty) return null;
    if (v.length > 500) return 'Bio must be 500 characters or fewer';
    return null;
  }
}

abstract final class HourlyRateValidator {
  static String? range(double? v) {
    if (v == null) return 'Hourly rate is required';
    if (v < 0.0) return 'Rate cannot be negative';
    if (v > 10000.0) return 'Rate must be 10,000 or less';
    return null;
  }
}

abstract final class SubjectsValidator {
  static String? minOne(List<String> v) {
    if (v.isEmpty || v.every((s) => s.trim().isEmpty)) {
      return 'Add at least one subject';
    }
    return null;
  }
}
