import 'package:injectable/injectable.dart';
import 'package:ppu_connect/domain/repositories/auth_repository.dart';

@injectable
class SendPasswordReset {
  const SendPasswordReset(this._repo);
  final AuthRepository _repo;

  Future<void> call(String email) => _repo.sendPasswordResetEmail(email);
}
