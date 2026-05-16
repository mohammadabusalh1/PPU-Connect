import 'package:firebase_auth/firebase_auth.dart' as fb;
import 'package:injectable/injectable.dart';
import 'package:ppu_connect/data/datasources/auth_remote_data_source.dart';
import 'package:ppu_connect/data/models/user_model.dart';
import 'package:ppu_connect/domain/entities/user.dart';
import 'package:ppu_connect/domain/repositories/auth_repository.dart';

@Injectable(as: AuthRepository)
class AuthRepositoryImpl implements AuthRepository {
  const AuthRepositoryImpl(this._dataSource);
  final AuthRemoteDataSource _dataSource;

  @override
  Stream<User?> watchAuthState() =>
      _dataSource.watchAuthState().map((m) => m?.toEntity());

  @override
  Future<User> signInWithEmailAndPassword(
    String email,
    String password,
  ) async {
    try {
      final model =
          await _dataSource.signInWithEmailAndPassword(email, password);
      return model.toEntity();
    } on fb.FirebaseAuthException catch (e) {
      throw _mapFirebaseError(e);
    }
  }

  @override
  Future<User> createUserWithEmailAndPassword({
    required String email,
    required String password,
    required String fullName,
  }) async {
    try {
      final model = await _dataSource.createUserWithEmailAndPassword(
        email: email,
        password: password,
        fullName: fullName,
      );
      return model.toEntity();
    } on fb.FirebaseAuthException catch (e) {
      throw _mapFirebaseError(e);
    } catch (e) {
      throw Exception(
        e.toString().replaceFirst('Exception: ', ''),
      );
    }
  }

  @override
  Future<User> signInWithGoogle() async {
    try {
      final model = await _dataSource.signInWithGoogle();
      return model.toEntity();
    } on fb.FirebaseAuthException catch (e) {
      throw _mapFirebaseError(e);
    }
  }

  @override
  Future<void> sendPasswordResetEmail(String email) async {
    try {
      await _dataSource.sendPasswordResetEmail(email);
    } on fb.FirebaseAuthException catch (e) {
      throw _mapFirebaseError(e);
    }
  }

  @override
  Future<void> signOut() => _dataSource.signOut();

  @override
  Future<User?> getCurrentUser() async {
    final model = await _dataSource.getCurrentUser();
    return model?.toEntity();
  }

  @override
  Future<void> sendEmailVerification() =>
      _dataSource.sendEmailVerification();

  @override
  Future<void> reloadUser() => _dataSource.reloadUser();

  Exception _mapFirebaseError(fb.FirebaseAuthException e) {
    return switch (e.code) {
      'user-not-found' || 'wrong-password' || 'invalid-credential' =>
        Exception('Invalid email or password'),
      'email-already-in-use' => Exception('An account with this email already exists'),
      'weak-password' => Exception('Password is too weak'),
      'user-disabled' => Exception('This account has been disabled'),
      'too-many-requests' => Exception('Too many attempts. Try again later'),
      'network-request-failed' => Exception('No internet connection'),
      _ => Exception(e.message ?? 'Authentication error'),
    };
  }
}
