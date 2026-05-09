import 'package:freezed_annotation/freezed_annotation.dart';

part 'review.freezed.dart';

@freezed
class Review with _$Review {
  const factory Review({
    required String id,
    required String appointmentId,
    required String authorId,
    required String tutorId,
    required int rating,
    String? comment,
    required bool isVisible,
    required DateTime createdAt,
  }) = _Review;
}
