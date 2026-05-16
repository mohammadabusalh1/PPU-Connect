import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ppu_connect/domain/repositories/auth_repository.dart';
import 'package:ppu_connect/domain/use_cases/auth/send_password_reset.dart';

class _MockAuthRepository extends Mock implements AuthRepository {}

void main() {
  late _MockAuthRepository repo;
  late SendPasswordReset sendPasswordReset;

  setUp(() {
    repo = _MockAuthRepository();
    sendPasswordReset = SendPasswordReset(repo);
  });

  test('delegates to repository with correct email', () async {
    when(() => repo.sendPasswordResetEmail(any())).thenAnswer((_) async {});

    await sendPasswordReset('user@ppu.edu.ps');

    verify(() => repo.sendPasswordResetEmail('user@ppu.edu.ps')).called(1);
  });

  test('propagates exception from repository', () async {
    when(
      () => repo.sendPasswordResetEmail(any()),
    ).thenThrow(Exception('user-not-found'));

    expect(
      () => sendPasswordReset('unknown@ppu.edu.ps'),
      throwsA(isA<Exception>()),
    );
  });
}
