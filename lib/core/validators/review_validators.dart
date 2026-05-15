abstract final class RatingValidator {
  static String? required(double? v) {
    if (v == null) return 'Rating is required';
    if (v < 1.0 || v > 5.0) return 'Rating must be between 1 and 5';
    return null;
  }
}

abstract final class ReviewCommentValidator {
  static String? optional(String? v) {
    if (v == null || v.isEmpty) return null;
    if (v.trim().length < 10) return 'Comment must be at least 10 characters';
    if (v.length > 1000) return 'Comment must be 1,000 characters or fewer';
    return null;
  }

  static String? required(String? v) {
    if (v == null || v.trim().isEmpty) return 'Comment is required';
    if (v.trim().length < 10) return 'Comment must be at least 10 characters';
    if (v.length > 1000) return 'Comment must be 1,000 characters or fewer';
    return null;
  }
}
