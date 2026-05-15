import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:ppu_connect/domain/entities/review.dart';
import 'package:ppu_connect/domain/repositories/review_repository.dart';

part 'reviews_state.dart';

@injectable
class ReviewsCubit extends Cubit<ReviewsState> {
  ReviewsCubit(this._repo) : super(const ReviewsInitial());
  final ReviewRepository _repo;

  Future<void> loadForTutor(String tutorId) async {
    emit(const ReviewsLoading());
    try {
      final list = await _repo.getReviewsForTutor(tutorId);
      if (isClosed) return;
      emit(ReviewsLoaded(reviews: list));
    } catch (e) {
      if (isClosed) return;
      emit(ReviewsError(e.toString().replaceFirst('Exception: ', '')));
    }
  }

  Future<void> submit(Review review) async {
    try {
      await _repo.submitReview(review);
      if (isClosed) return;
      emit(const ReviewSubmitSuccess());
    } catch (e) {
      if (isClosed) return;
      emit(ReviewsError(e.toString().replaceFirst('Exception: ', '')));
    }
  }
}
