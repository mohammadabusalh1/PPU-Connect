import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:ppu_connect/domain/entities/payment.dart';
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
}
