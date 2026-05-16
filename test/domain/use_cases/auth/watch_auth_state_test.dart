import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ppu_connect/domain/entities/user.dart';
import 'package:ppu_connect/domain/enums/enums.dart';
import 'package:ppu_connect/domain/repositories/auth_repository.dart';
import 'package:ppu_connect/domain/use_cases/auth/watch_auth_state.dart';

class _MockAuthRepository extends Mock implements AuthRepository {}

User _fakeUser() {
  final now = DateTime(2024);
  return User(
    id: 'u4',
    fullName: 'Lina',
    email: 'lina@student.ppu.edu.ps',
    major: 'Math',
    academicLevel: AcademicLevel.firstYear,
    role: UserRole.seeker,
    isActive: true,
    reportCount: 0,
    createdAt: now,
    updatedAt: now,
  );
}

void main() {
  late _MockAuthRepository repo;
  late WatchAuthState watchAuthState;

  setUp(() {
    repo = _MockAuthRepository();
    watchAuthState = WatchAuthState(repo);
  });

  test('emits user when signed in', () async {
    final user = _fakeUser();
    when(() => repo.watchAuthState()).thenAnswer((_) => Stream.value(user));

    expect(watchAuthState(), emits(user));
  });

  test('emits null when signed out', () {
    when(() => repo.watchAuthState())
        .thenAnswer((_) => Stream.value(null));

    expect(watchAuthState(), emits(null));
  });

  test('emits sequence of auth state changes', () {
    final user = _fakeUser();
    when(() => repo.watchAuthState())
        .thenAnswer((_) => Stream.fromIterable([null, user, null]));

    expect(watchAuthState(), emitsInOrder([null, user, null]));
  });

  test('delegates to repository', () {
    when(() => repo.watchAuthState()).thenAnswer((_) => const Stream.empty());

    watchAuthState();

    verify(() => repo.watchAuthState()).called(1);
  });
}
