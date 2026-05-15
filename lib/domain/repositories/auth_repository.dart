import 'package:ppu_connect/domain/entities/user.dart';

abstract interface class AuthRepository {
  Stream<User?> watchAuthState();
  Future<User> signInWithEmailAndPassword(String email, String password);
  Future<User> createUserWithEmailAndPassword({
    required String email,
    required String password,
    required String fullName,
  });
  Future<User> signInWithGoogle();
  Future<void> sendPasswordResetEmail(String email);
  Future<void> signOut();
  Future<User?> getCurrentUser();
  Future<void> sendEmailVerification();
  Future<void> reloadUser();
}
