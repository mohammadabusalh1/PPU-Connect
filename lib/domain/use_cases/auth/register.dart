import 'package:injectable/injectable.dart';
import 'package:ppu_connect/domain/entities/user.dart';
import 'package:ppu_connect/domain/repositories/auth_repository.dart';

@injectable
class Register {
  const Register(this._repo);
  final AuthRepository _repo;

  Future<User> call({
    required String email,
    required String password,
    required String fullName,
  }) =>
      _repo.createUserWithEmailAndPassword(
        email: email,
        password: password,
        fullName: fullName,
      );
}
