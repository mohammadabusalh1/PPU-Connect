import 'package:injectable/injectable.dart';
import 'package:ppu_connect/data/datasources/user_remote_data_source.dart';
import 'package:ppu_connect/data/models/user_model.dart';
import 'package:ppu_connect/domain/entities/user.dart';
import 'package:ppu_connect/domain/repositories/user_repository.dart';

@Injectable(as: UserRepository)
class UserRepositoryImpl implements UserRepository {
  const UserRepositoryImpl(this._ds);
  final UserRemoteDataSource _ds;

  @override
  Future<User?> getUserById(String uid) async {
    final m = await _ds.getUserById(uid);
    return m?.toEntity();
  }

  @override
  Future<void> updateUser(User user) =>
      _ds.updateUser(UserModel.fromEntity(user));

  @override
  Stream<User?> watchUser(String uid) =>
      _ds.watchUser(uid).map((m) => m?.toEntity());
}
