import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ppu_connect/domain/entities/appointment_request.dart';
import 'package:ppu_connect/domain/entities/payment.dart';
import 'package:ppu_connect/domain/entities/tutor_profile.dart';
import 'package:ppu_connect/domain/enums/enums.dart';
import 'package:ppu_connect/domain/models/payment_method_input.dart';
import 'package:ppu_connect/domain/repositories/appointment_repository.dart';
import 'package:ppu_connect/domain/repositories/payment_repository.dart';
import 'package:ppu_connect/presentation/cubits/checkout/checkout_cubit.dart';

class _MockAppointmentRepository extends Mock implements AppointmentRepository {}

class _MockPaymentRepository extends Mock implements PaymentRepository {}

AppointmentRequest _draft() {
  final start = DateTime.utc(2030, 6, 1, 10);
  return AppointmentRequest(
    id: '',
    senderId: 'seeker1',
    senderName: 'Seeker',
    receiverId: 'tutor1',
    tutorId: 'tutor1',
    seekerId: 'seeker1',
    subject: 'Math',
    proposedStartAt: start,
    proposedEndAt: start.add(const Duration(hours: 1)),
    status: RequestStatus.pending,
    expiresAt: start.subtract(const Duration(hours: 1)),
    createdAt: start,
    updatedAt: start,
  );
}

TutorProfile _tutor() {
  final now = DateTime.utc(2030, 1, 1);
  return TutorProfile(
    userId: 'tutor1',
    subjects: const ['Math'],
    hourlyRate: 50,
    currency: 'ILS',
    averageRating: 5,
    totalReviews: 1,
    completedSessions: 1,
    isAcceptingRequests: true,
    weeklySlots: const [],
    createdAt: now,
    updatedAt: now,
  );
}

PaymentMethodInput _card() => const PaymentMethodInput(
      number: '4242424242424242',
      holderName: 'Test User',
      expiryMonth: 12,
      expiryYear: 2030,
      cvv: '123',
    );

Payment _payment() {
  final now = DateTime.utc(2030, 1, 1);
  return Payment(
    id: 'pay1',
    requestId: 'req1',
    tutorId: 'tutor1',
    seekerId: 'seeker1',
    amount: 50,
    currency: 'ILS',
    status: PaymentStatus.held,
    cardLast4: '4242',
    cardBrand: 'Visa',
    createdAt: now,
    updatedAt: now,
  );
}

void main() {
  late _MockAppointmentRepository appointments;
  late _MockPaymentRepository payments;

  setUpAll(() {
    registerFallbackValue(_draft());
  });

  setUp(() {
    appointments = _MockAppointmentRepository();
    payments = _MockPaymentRepository();
  });

  blocTest<CheckoutCubit, CheckoutState>(
    'emits success when request and payment succeed',
    build: () => CheckoutCubit(appointments, payments),
    act: (cubit) => cubit.pay(
      draft: _draft(),
      tutorProfile: _tutor(),
      card: _card(),
    ),
    setUp: () {
      when(() => appointments.sendRequest(any())).thenAnswer(
        (_) async => _draft().copyWith(id: 'req1'),
      );
      when(
        () => payments.createForRequest(
          requestId: any(named: 'requestId'),
          tutorId: any(named: 'tutorId'),
          seekerId: any(named: 'seekerId'),
          amount: any(named: 'amount'),
          currency: any(named: 'currency'),
          cardLast4: any(named: 'cardLast4'),
          cardBrand: any(named: 'cardBrand'),
        ),
      ).thenAnswer((_) async => _payment());
    },
    expect: () => [
      const CheckoutLoading(),
      isA<CheckoutSuccess>(),
    ],
  );

  blocTest<CheckoutCubit, CheckoutState>(
    'emits error when card fails validation',
    build: () => CheckoutCubit(appointments, payments),
    act: (cubit) => cubit.pay(
      draft: _draft(),
      tutorProfile: _tutor(),
      card: const PaymentMethodInput(
        number: '1234567890123',
        holderName: 'Test',
        expiryMonth: 12,
        expiryYear: 2030,
        cvv: '123',
      ),
    ),
    expect: () => [const CheckoutError('Invalid card number')],
    verify: (_) {
      verifyNever(() => appointments.sendRequest(any()));
    },
  );
}
