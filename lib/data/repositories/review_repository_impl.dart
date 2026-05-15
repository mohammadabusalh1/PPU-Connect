import 'package:injectable/injectable.dart';
import 'package:ppu_connect/data/datasources/review_remote_data_source.dart';
import 'package:ppu_connect/data/models/review_model.dart';
import 'package:ppu_connect/domain/entities/review.dart';
import 'package:ppu_connect/domain/repositories/review_repository.dart';

@Injectable(as: ReviewRepository)
class ReviewRepositoryImpl implements ReviewRepository {
  const ReviewRepositoryImpl(this._ds);
  final ReviewRemoteDataSource _ds;

  @override
  Future<void> submitReview(Review review) =>
      _ds.submitReview(ReviewModel.fromEntity(review));

  @override
  Future<List<Review>> getReviewsForTutor(String tutorId, {int page = 0}) async {
    final models = await _ds.getReviewsForTutor(tutorId, page: page);
    return models.map((m) => m.toEntity()).toList();
  }

  @override
  Stream<List<Review>> watchReviewsForTutor(String tutorId) =>
      _ds.watchReviewsForTutor(tutorId).map((list) => list.map((m) => m.toEntity()).toList());
}
