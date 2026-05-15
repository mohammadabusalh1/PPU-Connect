import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';
import 'package:ppu_connect/data/models/user_model.dart';

abstract interface class UserRemoteDataSource {
  Future<UserModel?> getUserById(String uid);
  Future<void> updateUser(UserModel user);
  Stream<UserModel?> watchUser(String uid);
}

@Injectable(as: UserRemoteDataSource)
class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  const UserRemoteDataSourceImpl(this._firestore);
  final FirebaseFirestore _firestore;

  CollectionReference<Map<String, dynamic>> get _col =>
      _firestore.collection('users');

  @override
  Future<UserModel?> getUserById(String uid) async {
    final doc = await _col.doc(uid).get();
    if (!doc.exists || doc.data() == null) return null;
    return UserModel.fromJson({'id': uid, ...doc.data()!});
  }

  @override
  Future<void> updateUser(UserModel user) =>
      _col.doc(user.id).set(user.toJson(), SetOptions(merge: true));

  @override
  Stream<UserModel?> watchUser(String uid) => _col.doc(uid).snapshots().map(
        (doc) => doc.exists && doc.data() != null
            ? UserModel.fromJson({'id': uid, ...doc.data()!})
            : null,
      );
}
