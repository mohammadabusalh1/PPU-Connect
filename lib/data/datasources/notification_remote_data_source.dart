import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';
import 'package:ppu_connect/data/models/app_notification_model.dart';

abstract interface class NotificationRemoteDataSource {
  Stream<List<AppNotificationModel>> watchNotifications(String userId);
  Future<void> createNotification(AppNotificationModel notification);
  Future<void> markAsRead(String notificationId);
  Future<void> markAllAsRead(String userId);
  Future<int> getUnreadCount(String userId);
}

@Injectable(as: NotificationRemoteDataSource)
class NotificationRemoteDataSourceImpl implements NotificationRemoteDataSource {
  const NotificationRemoteDataSourceImpl(this._firestore);

  final FirebaseFirestore _firestore;

  static const _inboxLimit = 50;
  static const _batchLimit = 500;

  CollectionReference<Map<String, dynamic>> get _col =>
      _firestore.collection('notifications');

  @override
  Future<void> createNotification(AppNotificationModel notification) async {
    final doc = _col.doc();
    final data = notification.toJson()..remove('id');
    await doc.set(data);
  }

  @override
  Stream<List<AppNotificationModel>> watchNotifications(String userId) => _col
      .where('userId', isEqualTo: userId)
      .orderBy('createdAt', descending: true)
      .limit(_inboxLimit)
      .snapshots()
      .map(
        (snapshot) => snapshot.docs
            .map(
              (doc) => AppNotificationModel.fromJson({
                'id': doc.id,
                ...doc.data(),
              }),
            )
            .toList(),
      );

  @override
  Future<void> markAsRead(String notificationId) async {
    if (notificationId.isEmpty) {
      throw Exception('Invalid notification id');
    }
    await _col.doc(notificationId).update({
      'isRead': true,
      'readAt': FieldValue.serverTimestamp(),
    });
  }

  @override
  Future<void> markAllAsRead(String userId) async {
    while (true) {
      final snap = await _col
          .where('userId', isEqualTo: userId)
          .where('isRead', isEqualTo: false)
          .limit(_batchLimit)
          .get();
      if (snap.docs.isEmpty) return;

      final batch = _firestore.batch();
      for (final doc in snap.docs) {
        batch.update(doc.reference, {
          'isRead': true,
          'readAt': FieldValue.serverTimestamp(),
        });
      }
      await batch.commit();

      if (snap.docs.length < _batchLimit) return;
    }
  }

  @override
  Future<int> getUnreadCount(String userId) async {
    final snap = await _col
        .where('userId', isEqualTo: userId)
        .where('isRead', isEqualTo: false)
        .count()
        .get();
    return snap.count ?? 0;
  }
}
