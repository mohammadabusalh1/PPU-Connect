import 'package:injectable/injectable.dart';
import 'package:ppu_connect/domain/entities/user.dart';
import 'package:ppu_connect/domain/repositories/auth_repository.dart';

@injectable
class SignIn {
  const SignIn(this._repo);
  final AuthRepository _repo;

  Future<User> call(String email, String password) =>
      _repo.signInWithEmailAndPassword(email, password);
}
