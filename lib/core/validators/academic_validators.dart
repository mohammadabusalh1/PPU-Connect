abstract final class GpaValidator {
  static String? range(double? v) {
    if (v == null) return null;
    if (v < 0.0 || v > 4.0) return 'GPA must be between 0.0 and 4.0';
    return null;
  }
}

abstract final class MajorValidator {
  static String? required(String? v) {
    if (v == null || v.trim().isEmpty) return 'Major is required';
    if (v.trim().length > 100) return 'Major must be 100 characters or fewer';
    return null;
  }
}
