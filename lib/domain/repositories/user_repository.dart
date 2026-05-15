import 'package:ppu_connect/domain/entities/user.dart';

abstract interface class UserRepository {
  Future<User?> getUserById(String uid);
  Future<void> updateUser(User user);
  Stream<User?> watchUser(String uid);
}
