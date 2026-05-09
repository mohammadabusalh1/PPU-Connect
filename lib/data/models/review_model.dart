import 'package:freezed_annotation/freezed_annotation.dart';

import '../../core/utils/firestore_converters.dart';
import '../../domain/entities/review.dart';

part 'review_model.freezed.dart';
part 'review_model.g.dart';

@freezed
class ReviewModel with _$ReviewModel {
  const factory ReviewModel({
    required String id,
    required String appointmentId,
    required String authorId,
    required String tutorId,
    required int rating,
    String? comment,
    required bool isVisible,
    @TimestampConverter() required DateTime createdAt,
  }) = _ReviewModel;

  factory ReviewModel.fromJson(Map<String, dynamic> json) =>
      _$ReviewModelFromJson(json);

  factory ReviewModel.fromEntity(Review entity) => ReviewModel(
        id: entity.id,
        appointmentId: entity.appointmentId,
        authorId: entity.authorId,
        tutorId: entity.tutorId,
        rating: entity.rating,
        comment: entity.comment,
        isVisible: entity.isVisible,
        createdAt: entity.createdAt,
      );
}

extension ReviewModelX on ReviewModel {
  Review toEntity() => Review(
        id: id,
        appointmentId: appointmentId,
        authorId: authorId,
        tutorId: tutorId,
        rating: rating,
        comment: comment,
        isVisible: isVisible,
        createdAt: createdAt,
      );
}
