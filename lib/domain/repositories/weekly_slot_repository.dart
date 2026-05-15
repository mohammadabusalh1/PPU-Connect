import 'package:ppu_connect/domain/entities/weekly_slot.dart';

abstract interface class WeeklySlotRepository {
  Future<List<WeeklySlot>> getSlotsForTutor(String tutorId);
  Future<void> saveSlots(String tutorId, List<WeeklySlot> slots);
  Stream<List<WeeklySlot>> watchSlots(String tutorId);
}
