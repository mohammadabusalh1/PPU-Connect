import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:ppu_connect/domain/entities/payment.dart';
import 'package:ppu_connect/domain/enums/enums.dart';
import 'package:ppu_connect/domain/repositories/payment_repository.dart';

part 'payments_state.dart';

@injectable
class PaymentsCubit extends Cubit<PaymentsState> {
  PaymentsCubit(this._repo) : super(const PaymentsInitial());
  final PaymentRepository _repo;

  Future<void> load(String userId) async {
    emit(const PaymentsLoading());
    try {
      final list = await _repo.getPaymentsForUser(userId);
      if (isClosed) return;
      emit(PaymentsLoaded(payments: list));
    } catch (e) {
      if (isClosed) return;
      emit(PaymentsError(e.toString().replaceFirst('Exception: ', '')));
    }
  }

  Future<({bool ok, String? error})> requestRefund(
    String paymentId, {
    required String reason,
  }) async {
    try {
      await _repo.requestRefund(paymentId, reason: reason);
      if (state is PaymentsLoaded) {
        final updated = (state as PaymentsLoaded)
            .payments
            .map((p) => p.id == paymentId
                ? p.copyWith(
                    status: PaymentStatus.refunded,
                    refundReason: reason,
                    refundRequestedAt: DateTime.now(),
                  )
                : p)
            .toList();
        if (!isClosed) emit(PaymentsLoaded(payments: updated));
      }
      return (ok: true, error: null);
    } catch (e) {
      return (ok: false, error: e.toString().replaceFirst('Exception: ', ''));
    }
  }
}
