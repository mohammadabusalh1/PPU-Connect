import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ppu_connect/domain/entities/user.dart';
import 'package:ppu_connect/domain/enums/enums.dart';
import 'package:ppu_connect/domain/repositories/auth_repository.dart';
import 'package:ppu_connect/domain/use_cases/auth/register.dart';

class _MockAuthRepository extends Mock implements AuthRepository {}

User _fakeUser() {
  final now = DateTime(2024);
  return User(
    id: 'u2',
    fullName: 'Sara',
    email: 'sara@student.ppu.edu.ps',
    major: 'IT',
    academicLevel: AcademicLevel.secondYear,
    role: UserRole.seeker,
    isActive: true,
    reportCount: 0,
    createdAt: now,
    updatedAt: now,
  );
}

void main() {
  late _MockAuthRepository repo;
  late Register register;

  setUp(() {
    repo = _MockAuthRepository();
    register = Register(repo);
  });

  test('delegates to repository with correct parameters and returns user', () async {
    final user = _fakeUser();
    when(
      () => repo.createUserWithEmailAndPassword(
        email: any(named: 'email'),
        password: any(named: 'password'),
        fullName: any(named: 'fullName'),
      ),
    ).thenAnswer((_) async => user);

    final result = await register(
      email: 'sara@student.ppu.edu.ps',
      password: 'Password1!',
      fullName: 'Sara',
    );

    expect(result, user);
    verify(
      () => repo.createUserWithEmailAndPassword(
        email: 'sara@student.ppu.edu.ps',
        password: 'Password1!',
        fullName: 'Sara',
      ),
    ).called(1);
  });

  test('propagates exception from repository', () async {
    when(
      () => repo.createUserWithEmailAndPassword(
        email: any(named: 'email'),
        password: any(named: 'password'),
        fullName: any(named: 'fullName'),
      ),
    ).thenThrow(Exception('email-already-in-use'));

    expect(
      () => register(
        email: 'sara@student.ppu.edu.ps',
        password: 'Password1!',
        fullName: 'Sara',
      ),
      throwsA(isA<Exception>()),
    );
  });
}
