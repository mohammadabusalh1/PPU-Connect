import 'package:injectable/injectable.dart';
import 'package:ppu_connect/domain/repositories/auth_repository.dart';

@injectable
class SignOut {
  const SignOut(this._repo);
  final AuthRepository _repo;

  Future<void> call() => _repo.signOut();
}
