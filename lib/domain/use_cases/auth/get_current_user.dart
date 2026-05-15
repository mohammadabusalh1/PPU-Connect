import 'package:injectable/injectable.dart';
import 'package:ppu_connect/domain/entities/user.dart';
import 'package:ppu_connect/domain/repositories/auth_repository.dart';

@injectable
class GetCurrentUser {
  const GetCurrentUser(this._repo);
  final AuthRepository _repo;

  Future<User?> call() => _repo.getCurrentUser();
}
