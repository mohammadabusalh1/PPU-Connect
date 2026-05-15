import 'package:ppu_connect/domain/entities/review.dart';

abstract interface class ReviewRepository {
  Future<void> submitReview(Review review);
  Future<List<Review>> getReviewsForTutor(String tutorId, {int page = 0});
  Stream<List<Review>> watchReviewsForTutor(String tutorId);
}
