import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ppu_connect/domain/entities/user.dart';
import 'package:ppu_connect/domain/enums/enums.dart';
import 'package:ppu_connect/domain/repositories/auth_repository.dart';
import 'package:ppu_connect/domain/use_cases/auth/get_current_user.dart';

class _MockAuthRepository extends Mock implements AuthRepository {}

User _fakeUser() {
  final now = DateTime(2024);
  return User(
    id: 'u3',
    fullName: 'Khalid',
    email: 'khalid@ppu.edu.ps',
    major: 'Engineering',
    academicLevel: AcademicLevel.fourthYear,
    role: UserRole.tutor,
    isActive: true,
    reportCount: 0,
    createdAt: now,
    updatedAt: now,
  );
}

void main() {
  late _MockAuthRepository repo;
  late GetCurrentUser getCurrentUser;

  setUp(() {
    repo = _MockAuthRepository();
    getCurrentUser = GetCurrentUser(repo);
  });

  test('returns user when signed in', () async {
    final user = _fakeUser();
    when(() => repo.getCurrentUser()).thenAnswer((_) async => user);

    final result = await getCurrentUser();

    expect(result, user);
    verify(() => repo.getCurrentUser()).called(1);
  });

  test('returns null when not signed in', () async {
    when(() => repo.getCurrentUser()).thenAnswer((_) async => null);

    final result = await getCurrentUser();

    expect(result, isNull);
  });

  test('propagates exception from repository', () async {
    when(() => repo.getCurrentUser()).thenThrow(Exception('network-error'));

    expect(() => getCurrentUser(), throwsA(isA<Exception>()));
  });
}
