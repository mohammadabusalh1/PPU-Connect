import 'package:injectable/injectable.dart';
import 'package:ppu_connect/domain/entities/user.dart';
import 'package:ppu_connect/domain/repositories/auth_repository.dart';

@injectable
class WatchAuthState {
  const WatchAuthState(this._repo);
  final AuthRepository _repo;

  Stream<User?> call() => _repo.watchAuthState();
}
