import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:ppu_connect/domain/entities/appointment_request.dart';
import 'package:ppu_connect/domain/entities/tutor_profile.dart';
import 'package:ppu_connect/domain/models/payment_method_input.dart';
import 'package:ppu_connect/domain/repositories/appointment_repository.dart';
import 'package:ppu_connect/domain/repositories/payment_repository.dart';

part 'checkout_state.dart';

@injectable
class CheckoutCubit extends Cubit<CheckoutState> {
  CheckoutCubit(this._appointmentRepo, this._paymentRepo)
      : super(const CheckoutIdle());

  final AppointmentRepository _appointmentRepo;
  final PaymentRepository _paymentRepo;

  void reset() => emit(const CheckoutIdle());

  Future<void> pay({
    required AppointmentRequest draft,
    required TutorProfile tutorProfile,
    required PaymentMethodInput card,
  }) async {
    if (!card.isValid) {
      emit(const CheckoutError('Invalid card number'));
      return;
    }

    emit(const CheckoutLoading());
    try {
      final saved = await _appointmentRepo.sendRequest(draft);
      if (isClosed) return;

      final durationHours =
          draft.proposedEndAt.difference(draft.proposedStartAt).inMinutes /
              60.0;
      final amount =
          (tutorProfile.hourlyRate * durationHours).clamp(0.0, double.infinity);

      try {
        final payment = await _paymentRepo.createForRequest(
          requestId: saved.id,
          tutorId: tutorProfile.userId,
          seekerId: draft.seekerId,
          amount: amount,
          currency: tutorProfile.currency,
          cardLast4: card.last4,
          cardBrand: card.brand,
        );
        if (isClosed) return;
        emit(CheckoutSuccess(requestId: saved.id, paymentId: payment.id));
      } catch (e) {
        // Payment creation failed — cancel the dangling request to avoid a stuck state.
        try {
          await _appointmentRepo.cancelRequest(saved.id);
        } catch (_) {}
        if (isClosed) return;
        emit(CheckoutError(e.toString().replaceFirst('Exception: ', '')));
      }
    } catch (e) {
      if (isClosed) return;
      emit(CheckoutError(e.toString().replaceFirst('Exception: ', '')));
    }
  }
}
