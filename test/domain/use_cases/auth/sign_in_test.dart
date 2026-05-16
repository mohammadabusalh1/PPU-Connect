import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ppu_connect/domain/entities/user.dart';
import 'package:ppu_connect/domain/enums/enums.dart';
import 'package:ppu_connect/domain/repositories/auth_repository.dart';
import 'package:ppu_connect/domain/use_cases/auth/sign_in.dart';

class _MockAuthRepository extends Mock implements AuthRepository {}

User _fakeUser() {
  final now = DateTime(2024);
  return User(
    id: 'u1',
    fullName: 'Ahmad',
    email: 'ahmad@student.ppu.edu.ps',
    major: 'CS',
    academicLevel: AcademicLevel.thirdYear,
    role: UserRole.seeker,
    isActive: true,
    reportCount: 0,
    createdAt: now,
    updatedAt: now,
  );
}

void main() {
  late _MockAuthRepository repo;
  late SignIn signIn;

  setUp(() {
    repo = _MockAuthRepository();
    signIn = SignIn(repo);
  });

  test('delegates to repository and returns user on success', () async {
    final user = _fakeUser();
    when(
      () => repo.signInWithEmailAndPassword(any(), any()),
    ).thenAnswer((_) async => user);

    final result = await signIn('ahmad@student.ppu.edu.ps', 'Password1!');

    expect(result, user);
    verify(() => repo.signInWithEmailAndPassword(
          'ahmad@student.ppu.edu.ps',
          'Password1!',
        )).called(1);
  });

  test('propagates exception from repository', () async {
    when(
      () => repo.signInWithEmailAndPassword(any(), any()),
    ).thenThrow(Exception('wrong-password'));

    expect(
      () => signIn('ahmad@student.ppu.edu.ps', 'wrong'),
      throwsA(isA<Exception>()),
    );
  });
}
