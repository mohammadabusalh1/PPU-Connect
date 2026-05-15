part of 'reviews_cubit.dart';

sealed class ReviewsState {
  const ReviewsState();
}

final class ReviewsInitial extends ReviewsState {
  const ReviewsInitial();
}

final class ReviewsLoading extends ReviewsState {
  const ReviewsLoading();
}

final class ReviewsLoaded extends ReviewsState {
  const ReviewsLoaded({required this.reviews});
  final List<Review> reviews;
}

final class ReviewSubmitSuccess extends ReviewsState {
  const ReviewSubmitSuccess();
}

final class ReviewsError extends ReviewsState {
  const ReviewsError(this.message);
  final String message;
}
