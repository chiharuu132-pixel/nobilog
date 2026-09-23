import '../models/habit_with_creature.dart';

abstract interface class HabitRepository {
  Future<List<HabitWithCreature>> findAllActive();
  Future<void> createHabit({
    required String title,
    required String species,
  });
  Future<void> applyGrowth({
    required String habitId,
    required String day,
    required String state,
    required int deltaPoints,
  });
}