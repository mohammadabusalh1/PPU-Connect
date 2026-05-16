part of 'checkout_cubit.dart';

sealed class CheckoutState {
  const CheckoutState();
}

final class CheckoutIdle extends CheckoutState {
  const CheckoutIdle();
}

final class CheckoutLoading extends CheckoutState {
  const CheckoutLoading();
}

final class CheckoutSuccess extends CheckoutState {
  const CheckoutSuccess({required this.requestId, required this.paymentId});
  final String requestId;
  final String paymentId;
}

final class CheckoutError extends CheckoutState {
  const CheckoutError(this.message);
  final String message;
}
