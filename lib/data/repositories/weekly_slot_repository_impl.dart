import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';
import 'package:ppu_connect/data/models/weekly_slot_model.dart';
import 'package:ppu_connect/domain/entities/weekly_slot.dart';
import 'package:ppu_connect/domain/repositories/weekly_slot_repository.dart';

@Injectable(as: WeeklySlotRepository)
class WeeklySlotRepositoryImpl implements WeeklySlotRepository {
  const WeeklySlotRepositoryImpl(this._firestore);
  final FirebaseFirestore _firestore;

  CollectionReference<Map<String, dynamic>> _slots(String tutorId) =>
      _firestore.collection('tutorProfiles').doc(tutorId).collection('slots');

  @override
  Future<List<WeeklySlot>> getSlotsForTutor(String tutorId) async {
    final snap = await _slots(tutorId).get();
    return snap.docs
        .map((d) => WeeklySlotModel.fromJson({'id': d.id, ...d.data()}).toEntity())
        .toList();
  }

  @override
  Future<void> saveSlots(String tutorId, List<WeeklySlot> slots) async {
    final col = _slots(tutorId);
    final batch = _firestore.batch();
    // Delete all existing then re-write
    final existing = await col.get();
    for (final doc in existing.docs) {
      batch.delete(doc.reference);
    }
    for (final slot in slots) {
      final ref = col.doc(slot.id.isEmpty ? null : slot.id);
      batch.set(ref, WeeklySlotModel.fromEntity(slot).toJson());
    }
    await batch.commit();
  }

  @override
  Stream<List<WeeklySlot>> watchSlots(String tutorId) =>
      _slots(tutorId).snapshots().map((s) => s.docs
          .map((d) => WeeklySlotModel.fromJson({'id': d.id, ...d.data()}).toEntity())
          .toList());
}
