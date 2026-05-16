import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ppu_connect/domain/entities/tutor_profile.dart';
import 'package:ppu_connect/domain/entities/user.dart';
import 'package:ppu_connect/domain/enums/enums.dart';
import 'package:ppu_connect/domain/repositories/tutor_profile_repository.dart';
import 'package:ppu_connect/domain/repositories/user_repository.dart';
import 'package:ppu_connect/presentation/cubits/profile/profile_cubit.dart';
import 'package:ppu_connect/presentation/pages/tutor/weekly_availability_page.dart';

class _MockUserRepo extends Mock implements UserRepository {}

class _MockTutorRepo extends Mock implements TutorProfileRepository {}

void main() {
  late _MockUserRepo userRepo;
  late _MockTutorRepo tutorRepo;

  final now = DateTime(2026, 1, 1);
  final user = User(
    id: 'u1',
    fullName: 'Tutor',
    email: 't@ppu.edu',
    major: 'CS',
    academicLevel: AcademicLevel.thirdYear,
    role: UserRole.tutor,
    isActive: true,
    reportCount: 0,
    createdAt: now,
    updatedAt: now,
  );
  final tutorProfile = TutorProfile(
    userId: 'u1',
    subjects: const ['Math'],
    hourlyRate: 50,
    currency: 'ILS',
    averageRating: 5,
    totalReviews: 1,
    completedSessions: 0,
    isAcceptingRequests: true,
    weeklySlots: const [],
    createdAt: now,
    updatedAt: now,
  );

  setUpAll(() {
    registerFallbackValue(tutorProfile);
  });

  setUp(() {
    userRepo = _MockUserRepo();
    tutorRepo = _MockTutorRepo();
  });

  testWidgets(
    'child route sees shell ProfileCubit, not the profile-route instance',
    (tester) async {
      final shellCubit = ProfileCubit(userRepo, tutorRepo);
      final profileRouteCubit = ProfileCubit(userRepo, tutorRepo);
      profileRouteCubit.emit(
        ProfileLoaded(user: user, tutorProfile: tutorProfile),
      );

      ProfileCubit? resolvedFromAvailabilityContext;
      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider.value(
            value: shellCubit,
            child: Builder(
              builder: (availabilityContext) {
                resolvedFromAvailabilityContext =
                    availabilityContext.read<ProfileCubit>();
                return const SizedBox.shrink();
              },
            ),
          ),
        ),
      );

      expect(resolvedFromAvailabilityContext, same(shellCubit));
      expect(shellCubit.state, isA<ProfileInitial>());
      expect(profileRouteCubit.state, isA<ProfileLoaded>());
    },
  );

  testWidgets('unloaded shell cubit: save does not persist', (tester) async {
    final shellCubit = ProfileCubit(userRepo, tutorRepo);
    when(() => tutorRepo.updateProfile(any())).thenAnswer((_) async {});

    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider.value(
          value: shellCubit,
          child: const WeeklyAvailabilityPage(),
        ),
      ),
    );
    await tester.pumpAndSettle();
    await tester.scrollUntilVisible(
      find.text('Save Availability'),
      500,
      scrollable: find.byType(Scrollable),
    );
    await tester.tap(find.text('Save Availability'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 100));

    verifyNever(() => tutorRepo.updateProfile(any()));
  });

  testWidgets('loaded shell cubit: save persists availability', (tester) async {
    final cubit = ProfileCubit(userRepo, tutorRepo);
    cubit.emit(ProfileLoaded(user: user, tutorProfile: tutorProfile));
    when(() => tutorRepo.updateProfile(any())).thenAnswer((_) async {});

    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider.value(
          value: cubit,
          child: const WeeklyAvailabilityPage(),
        ),
      ),
    );
    await tester.pumpAndSettle();
    await tester.scrollUntilVisible(
      find.text('Save Availability'),
      500,
      scrollable: find.byType(Scrollable),
    );
    await tester.tap(find.text('Save Availability'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 100));

    verify(() => tutorRepo.updateProfile(any())).called(1);
    expect(find.text('Availability saved'), findsOneWidget);
  });
}
