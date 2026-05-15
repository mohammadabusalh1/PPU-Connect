part of 'payments_cubit.dart';

sealed class PaymentsState {
  const PaymentsState();
}

final class PaymentsInitial extends PaymentsState {
  const PaymentsInitial();
}

final class PaymentsLoading extends PaymentsState {
  const PaymentsLoading();
}

final class PaymentsLoaded extends PaymentsState {
  const PaymentsLoaded({required this.payments});
  final List<Payment> payments;
}

final class PaymentsError extends PaymentsState {
  const PaymentsError(this.message);
  final String message;
}
