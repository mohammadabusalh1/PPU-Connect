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
        when(() => repo.watchIncomingRequests(any()))
            .thenAnswer((_) => Stream.error(Exception('stream-error')));
        return AppointmentRequestsCubit(repo);
      },
      act: (cubit) => cubit.watchIncoming('tutor1'),
      expect: () => [
        isA<AppointmentRequestsLoading>(),
        predicate<AppointmentRequestsError>((s) => s.message == 'stream-error'),
      ],
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
    test('returns ok:true on success', () async {
      when(() => repo.sendRequest(any())).thenAnswer((_) async => _fakeRequest());
      final cubit = AppointmentRequestsCubit(repo);

      final result = await cubit.sendRequest(_fakeRequest());

      expect(result.ok, isTrue);
      expect(cubit.state, isA<AppointmentRequestsInitial>());
      await cubit.close();
    });

    test('returns ok:false without polluting state', () async {
      when(() => repo.sendRequest(any()))
          .thenThrow(Exception('quota-exceeded'));
      final cubit = AppointmentRequestsCubit(repo);

      final result = await cubit.sendRequest(_fakeRequest());

      expect(result.ok, isFalse);
      expect(result.error, 'quota-exceeded');
      expect(cubit.state, isA<AppointmentRequestsInitial>());
      await cubit.close();
    });
  });

  group('AppointmentRequestsCubit.watchForDetail', () {
    test('watches incoming when user is tutor on request', () async {
      when(() => repo.getRequest('req1')).thenAnswer(
        (_) async => _fakeRequest(id: 'req1').copyWith(tutorId: 'tutor1'),
      );
      when(() => repo.watchIncomingRequests('tutor1'))
          .thenAnswer((_) => Stream.value([_fakeRequest(id: 'req1')]));
      final cubit = AppointmentRequestsCubit(repo);

      await cubit.watchForDetail(userId: 'tutor1', requestId: 'req1');
      await Future<void>.delayed(Duration.zero);

      expect(cubit.state, isA<AppointmentRequestsLoaded>());
      await cubit.close();
    });
  });
}
