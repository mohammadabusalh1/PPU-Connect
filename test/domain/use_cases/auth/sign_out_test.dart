import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ppu_connect/domain/repositories/auth_repository.dart';
import 'package:ppu_connect/domain/use_cases/auth/sign_out.dart';

class _MockAuthRepository extends Mock implements AuthRepository {}

void main() {
  late _MockAuthRepository repo;
  late SignOut signOut;

  setUp(() {
    repo = _MockAuthRepository();
    signOut = SignOut(repo);
  });

  test('delegates to repository signOut', () async {
    when(() => repo.signOut()).thenAnswer((_) async {});

    await signOut();

    verify(() => repo.signOut()).called(1);
  });

  test('propagates exception from repository', () async {
    when(() => repo.signOut()).thenThrow(Exception('network-error'));

    expect(() => signOut(), throwsA(isA<Exception>()));
  });
}
