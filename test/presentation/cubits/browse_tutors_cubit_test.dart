import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ppu_connect/domain/entities/tutor_profile.dart';
import 'package:ppu_connect/domain/entities/user.dart';
import 'package:ppu_connect/domain/enums/enums.dart';
import 'package:ppu_connect/domain/repositories/tutor_profile_repository.dart';
import 'package:ppu_connect/domain/repositories/user_repository.dart';
import 'package:ppu_connect/presentation/cubits/browse_tutors/browse_tutors_cubit.dart';

class _MockTutorProfileRepository extends Mock
    implements TutorProfileRepository {}

class _MockUserRepository extends Mock implements UserRepository {}

User _makeUser({
  required String id,
  required String fullName,
  String role = 'tutor',
}) {
  final now = DateTime(2024);
  return User(
    id: id,
    fullName: fullName,
    email: '$id@ppu.edu.ps',
    major: 'CS',
    academicLevel: AcademicLevel.thirdYear,
    role: UserRole.tutor,
    isActive: true,
    reportCount: 0,
    createdAt: now,
    updatedAt: now,
  );
}

TutorProfile _makeProfile({
  required String userId,
  required List<String> subjects,
  double hourlyRate = 50.0,
}) {
  final now = DateTime(2024);
  return TutorProfile(
    userId: userId,
    subjects: subjects,
    hourlyRate: hourlyRate,
    currency: 'ILS',
    averageRating: 4.5,
    totalReviews: 10,
    completedSessions: 5,
    isAcceptingRequests: true,
    weeklySlots: const [],
    createdAt: now,
    updatedAt: now,
  );
}

void main() {
  late _MockTutorProfileRepository tutorRepo;
  late _MockUserRepository userRepo;

  setUp(() {
    tutorRepo = _MockTutorProfileRepository();
    userRepo = _MockUserRepository();
  });

  group('BrowseTutorsCubit - initial state', () {
    test('initial state is BrowseTutorsInitial', () {
      final cubit = BrowseTutorsCubit(tutorRepo, userRepo);
      expect(cubit.state, isA<BrowseTutorsInitial>());
      cubit.close();
    });
  });

  group('BrowseTutorsCubit.load', () {
    blocTest<BrowseTutorsCubit, BrowseTutorsState>(
      'emits loading then loaded with tutors',
      build: () {
        final profile = _makeProfile(userId: 't1', subjects: ['Math']);
        final user = _makeUser(id: 't1', fullName: 'Tutor One');
        when(() => tutorRepo.searchTutors(maxRate: any(named: 'maxRate')))
            .thenAnswer((_) async => [profile]);
        when(() => userRepo.getUserById('t1')).thenAnswer((_) async => user);
        return BrowseTutorsCubit(tutorRepo, userRepo);
      },
      act: (cubit) => cubit.load(),
      expect: () => [
        isA<BrowseTutorsLoading>(),
        isA<BrowseTutorsLoaded>(),
      ],
    );

    blocTest<BrowseTutorsCubit, BrowseTutorsState>(
      'loaded state contains correct number of tutors',
      build: () {
        final profiles = [
          _makeProfile(userId: 't1', subjects: ['Math']),
          _makeProfile(userId: 't2', subjects: ['Physics']),
        ];
        when(() => tutorRepo.searchTutors(maxRate: any(named: 'maxRate')))
            .thenAnswer((_) async => profiles);
        when(() => userRepo.getUserById('t1'))
            .thenAnswer((_) async => _makeUser(id: 't1', fullName: 'Tutor A'));
        when(() => userRepo.getUserById('t2'))
            .thenAnswer((_) async => _makeUser(id: 't2', fullName: 'Tutor B'));
        return BrowseTutorsCubit(tutorRepo, userRepo);
      },
      act: (cubit) => cubit.load(),
      expect: () => [
        isA<BrowseTutorsLoading>(),
        predicate<BrowseTutorsLoaded>((s) => s.tutors.length == 2),
      ],
    );

    blocTest<BrowseTutorsCubit, BrowseTutorsState>(
      'excludes current user from results',
      build: () {
        final profile = _makeProfile(userId: 'currentUser', subjects: ['CS']);
        when(() => tutorRepo.searchTutors(maxRate: any(named: 'maxRate')))
            .thenAnswer((_) async => [profile]);
        when(() => userRepo.getUserById('currentUser'))
            .thenAnswer((_) async => _makeUser(id: 'currentUser', fullName: 'Me'));
        return BrowseTutorsCubit(tutorRepo, userRepo);
      },
      act: (cubit) => cubit.load(currentUserId: 'currentUser'),
      expect: () => [
        isA<BrowseTutorsLoading>(),
        predicate<BrowseTutorsLoaded>((s) => s.tutors.isEmpty),
      ],
    );

    blocTest<BrowseTutorsCubit, BrowseTutorsState>(
      'filters by query matching name',
      build: () {
        final profiles = [
          _makeProfile(userId: 't1', subjects: ['Math']),
          _makeProfile(userId: 't2', subjects: ['Physics']),
        ];
        when(() => tutorRepo.searchTutors(maxRate: any(named: 'maxRate')))
            .thenAnswer((_) async => profiles);
        when(() => userRepo.getUserById('t1'))
            .thenAnswer((_) async => _makeUser(id: 't1', fullName: 'Ahmad Hassan'));
        when(() => userRepo.getUserById('t2'))
            .thenAnswer((_) async => _makeUser(id: 't2', fullName: 'Sara Nasser'));
        return BrowseTutorsCubit(tutorRepo, userRepo);
      },
      act: (cubit) => cubit.load(query: 'ahmad'),
      expect: () => [
        isA<BrowseTutorsLoading>(),
        predicate<BrowseTutorsLoaded>((s) =>
            s.tutors.length == 1 && s.tutors.first.user.fullName == 'Ahmad Hassan'),
      ],
    );

    blocTest<BrowseTutorsCubit, BrowseTutorsState>(
      'filters by query matching subject',
      build: () {
        final profiles = [
          _makeProfile(userId: 't1', subjects: ['Mathematics']),
          _makeProfile(userId: 't2', subjects: ['Chemistry']),
        ];
        when(() => tutorRepo.searchTutors(maxRate: any(named: 'maxRate')))
            .thenAnswer((_) async => profiles);
        when(() => userRepo.getUserById('t1'))
            .thenAnswer((_) async => _makeUser(id: 't1', fullName: 'Tutor A'));
        when(() => userRepo.getUserById('t2'))
            .thenAnswer((_) async => _makeUser(id: 't2', fullName: 'Tutor B'));
        return BrowseTutorsCubit(tutorRepo, userRepo);
      },
      act: (cubit) => cubit.load(query: 'chemistry'),
      expect: () => [
        isA<BrowseTutorsLoading>(),
        predicate<BrowseTutorsLoaded>((s) =>
            s.tutors.length == 1 &&
            s.tutors.first.profile.subjects.contains('Chemistry')),
      ],
    );

    blocTest<BrowseTutorsCubit, BrowseTutorsState>(
      'emits error when repository throws',
      build: () {
        when(() => tutorRepo.searchTutors(maxRate: any(named: 'maxRate')))
            .thenThrow(Exception('network-error'));
        return BrowseTutorsCubit(tutorRepo, userRepo);
      },
      act: (cubit) => cubit.load(),
      expect: () => [
        isA<BrowseTutorsLoading>(),
        isA<BrowseTutorsError>(),
      ],
    );

    blocTest<BrowseTutorsCubit, BrowseTutorsState>(
      'error message strips Exception prefix',
      build: () {
        when(() => tutorRepo.searchTutors(maxRate: any(named: 'maxRate')))
            .thenThrow(Exception('network-error'));
        return BrowseTutorsCubit(tutorRepo, userRepo);
      },
      act: (cubit) => cubit.load(),
      expect: () => [
        isA<BrowseTutorsLoading>(),
        predicate<BrowseTutorsError>((s) => s.message == 'network-error'),
      ],
    );

    blocTest<BrowseTutorsCubit, BrowseTutorsState>(
      'loaded state carries query string',
      build: () {
        when(() => tutorRepo.searchTutors(maxRate: any(named: 'maxRate')))
            .thenAnswer((_) async => []);
        return BrowseTutorsCubit(tutorRepo, userRepo);
      },
      act: (cubit) => cubit.load(query: 'math'),
      expect: () => [
        isA<BrowseTutorsLoading>(),
        predicate<BrowseTutorsLoaded>((s) => s.query == 'math'),
      ],
    );

    blocTest<BrowseTutorsCubit, BrowseTutorsState>(
      'skips users returned as null from user repository',
      build: () {
        final profile = _makeProfile(userId: 'ghost', subjects: ['CS']);
        when(() => tutorRepo.searchTutors(maxRate: any(named: 'maxRate')))
            .thenAnswer((_) async => [profile]);
        when(() => userRepo.getUserById('ghost')).thenAnswer((_) async => null);
        return BrowseTutorsCubit(tutorRepo, userRepo);
      },
      act: (cubit) => cubit.load(),
      expect: () => [
        isA<BrowseTutorsLoading>(),
        predicate<BrowseTutorsLoaded>((s) => s.tutors.isEmpty),
      ],
    );
  });
}
