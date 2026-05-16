import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as fb;
import 'package:google_sign_in/google_sign_in.dart';
import 'package:injectable/injectable.dart';
import 'package:ppu_connect/core/utils/user_display_name.dart';
import 'package:ppu_connect/data/models/user_model.dart';
import 'package:ppu_connect/domain/enums/enums.dart';

abstract interface class AuthRemoteDataSource {
  Stream<UserModel?> watchAuthState();
  Future<UserModel> signInWithEmailAndPassword(String email, String password);
  Future<UserModel> createUserWithEmailAndPassword({
    required String email,
    required String password,
    required String fullName,
  });
  Future<UserModel> signInWithGoogle();
  Future<void> sendPasswordResetEmail(String email);
  Future<void> signOut();
  Future<UserModel?> getCurrentUser();
  Future<void> sendEmailVerification();
  Future<void> reloadUser();
}

@Injectable(as: AuthRemoteDataSource)
class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  const AuthRemoteDataSourceImpl(this._auth, this._firestore);

  final fb.FirebaseAuth _auth;
  final FirebaseFirestore _firestore;

  static const _usersCollection = 'users';

  @override
  Future<UserModel> signInWithGoogle() async {
    final googleUser = await GoogleSignIn().signIn();
    if (googleUser == null) throw Exception('Google sign-in was cancelled');

    final googleAuth = await googleUser.authentication;
    final credential = fb.GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    final cred = await _auth.signInWithCredential(credential);
    final fbUser = cred.user!;

    final doc = await _firestore.collection(_usersCollection).doc(fbUser.uid).get();
    if (doc.exists && doc.data() != null) {
      return UserModel.fromJson({'id': fbUser.uid, ...doc.data()!});
    }

    final now = DateTime.now();
    final email = fbUser.email ?? googleUser.email;
    final model = UserModel(
      id: fbUser.uid,
      fullName: resolveUserDisplayName(
        fullName: fbUser.displayName ?? googleUser.displayName ?? '',
        email: email,
      ),
      email: email,
      avatarUrl: fbUser.photoURL,
      major: '',
      academicLevel: AcademicLevel.firstYear,
      role: UserRole.seeker,
      isActive: true,
      reportCount: 0,
      createdAt: now,
      updatedAt: now,
    );
    await _firestore.collection(_usersCollection).doc(fbUser.uid).set(model.toJson());
    return model;
  }

  @override
  Stream<UserModel?> watchAuthState() {
    return _auth.authStateChanges().asyncMap((fbUser) async {
      if (fbUser == null) return null;
      final stored = await _loadUserDocument(fbUser.uid);
      if (stored != null) return stored;
      // Firestore write may still be in flight right after registration.
      return _userModelFromFirebaseUser(fbUser);
    });
  }

  @override
  Future<UserModel> signInWithEmailAndPassword(
    String email,
    String password,
  ) async {
    final cred = await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    return _fetchUserModel(cred.user!.uid);
  }

  @override
  Future<UserModel> createUserWithEmailAndPassword({
    required String email,
    required String password,
    required String fullName,
  }) async {
    final cred = await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    final fbUser = cred.user!;
    await fbUser.updateDisplayName(fullName);
    await fbUser.reload();

    final now = DateTime.now();
    final resolvedName = _auth.currentUser?.displayName?.trim();
    final model = UserModel(
      id: fbUser.uid,
      fullName: resolvedName != null && resolvedName.isNotEmpty
          ? resolvedName
          : fullName,
      email: email,
      major: '',
      academicLevel: AcademicLevel.firstYear,
      role: UserRole.seeker,
      isActive: true,
      reportCount: 0,
      createdAt: now,
      updatedAt: now,
    );

    await _firestore
        .collection(_usersCollection)
        .doc(fbUser.uid)
        .set(model.toJson());

    await fbUser.sendEmailVerification();
    return model;
  }

  @override
  Future<void> sendPasswordResetEmail(String email) =>
      _auth.sendPasswordResetEmail(email: email);

  @override
  Future<void> signOut() => _auth.signOut();

  @override
  Future<UserModel?> getCurrentUser() async {
    final fbUser = _auth.currentUser;
    if (fbUser == null) return null;
    return _fetchUserModel(fbUser.uid);
  }

  @override
  Future<void> sendEmailVerification() =>
      _auth.currentUser!.sendEmailVerification();

  @override
  Future<void> reloadUser() => _auth.currentUser!.reload();

  Future<UserModel> _fetchUserModel(String uid) async {
    final stored = await _loadUserDocument(uid);
    if (stored != null) return stored;
    throw Exception('User document not found for uid: $uid');
  }

  Future<UserModel?> _loadUserDocument(String uid) async {
    for (var attempt = 0; attempt < 5; attempt++) {
      final doc =
          await _firestore.collection(_usersCollection).doc(uid).get();
      if (doc.exists && doc.data() != null) {
        return UserModel.fromJson({'id': uid, ...doc.data()!});
      }
      if (attempt < 4) {
        await Future.delayed(Duration(milliseconds: 100 * (attempt + 1)));
      }
    }
    return null;
  }

  UserModel _userModelFromFirebaseUser(fb.User fbUser) {
    final now = DateTime.now();
    final email = fbUser.email ?? '';
    return UserModel(
      id: fbUser.uid,
      fullName: resolveUserDisplayName(
        fullName: fbUser.displayName ?? '',
        email: email,
      ),
      email: email,
      avatarUrl: fbUser.photoURL,
      major: '',
      academicLevel: AcademicLevel.firstYear,
      role: UserRole.seeker,
      isActive: true,
      reportCount: 0,
      createdAt: now,
      updatedAt: now,
    );
  }
}
