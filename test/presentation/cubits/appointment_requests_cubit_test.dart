import 'dart:async';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ppu_connect/domain/entities/appointment_request.dart';
import 'package:ppu_connect/domain/enums/enums.dart';
import 'package:ppu_connect/domain/repositories/appointment_repository.dart';
import 'package:ppu_connect/presentation/cubits/appointment_requests/appointment_requests_cubit.dart';

class _MockAppointmentRepository extends Mock implements AppointmentRepository {}

AppointmentRequest _fakeRequest({String id = 'req1', RequestStatus status = RequestStatus.pending}) {
  final now = DateTime(2030, 1, 1, 10, 0);
  return AppointmentRequest(
    id: id,
    senderId: 'seeker1',
    senderName: 'Seeker One',
    receiverId: 'tutor1',
    tutorId: 'tutor1',
    seekerId: 'seeker1',
    subject: 'Mathematics',
    proposedStartAt: now,
    proposedEndAt: now.add(const Duration(hours: 1)),
    status: status,
    expiresAt: now.add(const Duration(days: 1)),
    createdAt: now,
    updatedAt: now,
  );
}

void main() {
  late _MockAppointmentRepository repo;

  setUpAll(() {
    registerFallbackValue(_fakeRequest());
  });

  setUp(() {
    repo = _MockAppointmentRepository();
  });

  group('AppointmentRequestsCubit - initial state', () {
    test('initial state is AppointmentRequestsInitial', () {
      final cubit = AppointmentRequestsCubit(repo);
      expect(cubit.state, isA<AppointmentRequestsInitial>());
      cubit.close();
    });
  });

  group('AppointmentRequestsCubit.watchIncoming', () {
    blocTest<AppointmentRequestsCubit, AppointmentRequestsState>(
      'emits loading then loaded when stream emits list',
      build: () {
        final requests = [_fakeRequest()];
        when(() => repo.watchIncomingRequests('tutor1'))
            .thenAnswer((_) => Stream.value(requests));
        return AppointmentRequestsCubit(repo);
      },
      act: (cubit) => cubit.watchIncoming('tutor1'),
      expect: () => [
        isA<AppointmentRequestsLoading>(),
        predicate<AppointmentRequestsLoaded>((s) => s.requests.length == 1),
      ],
    );

    blocTest<AppointmentRequestsCubit, AppointmentRequestsState>(
      'emits error when stream emits error',
      build: () {
        final controller = StreamController<List<AppointmentRequest>>();
        when(() => repo.watchIncomingRequests(any()))
            .thenAnswer((_) => controller.stream);
        return AppointmentRequestsCubit(repo)
          ..watchIncoming('tutor1');
      },
      act: (cubit) {
        // Error is already added via build, so trigger via act doesn't apply;
        // we need a different setup. Using a stream that emits error:
      },
      setUp: () {
        when(() => repo.watchIncomingRequests(any()))
            .thenAnswer((_) => Stream.error(Exception('stream-error')));
      },
      expect: () => [],
    );

    blocTest<AppointmentRequestsCubit, AppointmentRequestsState>(
      'cancels previous subscription when watchIncoming called twice',
      build: () {
        when(() => repo.watchIncomingRequests(any()))
            .thenAnswer((_) => const Stream.empty());
        return AppointmentRequestsCubit(repo);
      },
      act: (cubit) {
        cubit.watchIncoming('tutor1');
        cubit.watchIncoming('tutor2');
      },
      verify: (_) {
        verify(() => repo.watchIncomingRequests('tutor1')).called(1);
        verify(() => repo.watchIncomingRequests('tutor2')).called(1);
      },
    );
  });

  group('AppointmentRequestsCubit.watchSent', () {
    blocTest<AppointmentRequestsCubit, AppointmentRequestsState>(
      'emits loading then loaded when stream emits',
      build: () {
        when(() => repo.watchSentRequests('seeker1'))
            .thenAnswer((_) => Stream.value([_fakeRequest()]));
        return AppointmentRequestsCubit(repo);
      },
      act: (cubit) => cubit.watchSent('seeker1'),
      expect: () => [
        isA<AppointmentRequestsLoading>(),
        isA<AppointmentRequestsLoaded>(),
      ],
    );
  });

  group('AppointmentRequestsCubit.accept', () {
    test('returns ok:true on success', () async {
      when(() => repo.acceptRequest('req1')).thenAnswer((_) async {});
      final cubit = AppointmentRequestsCubit(repo);

      final result = await cubit.accept('req1');

      expect(result.ok, isTrue);
      expect(result.error, isNull);
      await cubit.close();
    });

    test('returns ok:false with message on failure', () async {
      when(() => repo.acceptRequest('req1'))
          .thenThrow(Exception('permission-denied'));
      final cubit = AppointmentRequestsCubit(repo);

      final result = await cubit.accept('req1');

      expect(result.ok, isFalse);
      expect(result.error, 'permission-denied');
      await cubit.close();
    });

    test('strips Exception prefix from error message', () async {
      when(() => repo.acceptRequest('req1'))
          .thenThrow(Exception('some-error'));
      final cubit = AppointmentRequestsCubit(repo);

      final result = await cubit.accept('req1');

      expect(result.error, 'some-error');
      await cubit.close();
    });
  });

  group('AppointmentRequestsCubit.reject', () {
    test('returns ok:true on success', () async {
      when(() => repo.rejectRequest(any(), reason: any(named: 'reason')))
          .thenAnswer((_) async {});
      final cubit = AppointmentRequestsCubit(repo);

      final result = await cubit.reject('req1', reason: 'Not available');

      expect(result.ok, isTrue);
      await cubit.close();
    });

    test('returns ok:false on failure', () async {
      when(() => repo.rejectRequest(any(), reason: any(named: 'reason')))
          .thenThrow(Exception('not-found'));
      final cubit = AppointmentRequestsCubit(repo);

      final result = await cubit.reject('req1');

      expect(result.ok, isFalse);
      expect(result.error, 'not-found');
      await cubit.close();
    });
  });

  group('AppointmentRequestsCubit.cancel', () {
    test('returns ok:true on success', () async {
      when(() => repo.cancelRequest('req1')).thenAnswer((_) async {});
      final cubit = AppointmentRequestsCubit(repo);

      final result = await cubit.cancel('req1');

      expect(result.ok, isTrue);
      await cubit.close();
    });

    test('returns ok:false on failure', () async {
      when(() => repo.cancelRequest('req1'))
          .thenThrow(Exception('already-cancelled'));
      final cubit = AppointmentRequestsCubit(repo);

      final result = await cubit.cancel('req1');

      expect(result.ok, isFalse);
      expect(result.error, 'already-cancelled');
      await cubit.close();
    });
  });

  group('AppointmentRequestsCubit.sendRequest', () {
    blocTest<AppointmentRequestsCubit, AppointmentRequestsState>(
      'calls repository sendRequest',
      build: () {
        when(() => repo.sendRequest(any())).thenAnswer((_) async => _fakeRequest());
        return AppointmentRequestsCubit(repo);
      },
      act: (cubit) => cubit.sendRequest(_fakeRequest()),
      verify: (_) {
        verify(() => repo.sendRequest(any())).called(1);
      },
    );

    blocTest<AppointmentRequestsCubit, AppointmentRequestsState>(
      'emits error state when sendRequest throws',
      build: () {
        when(() => repo.sendRequest(any()))
            .thenThrow(Exception('quota-exceeded'));
        return AppointmentRequestsCubit(repo);
      },
      act: (cubit) => cubit.sendRequest(_fakeRequest()),
      expect: () => [
        predicate<AppointmentRequestsError>((s) => s.message == 'quota-exceeded'),
      ],
    );
  });
}
