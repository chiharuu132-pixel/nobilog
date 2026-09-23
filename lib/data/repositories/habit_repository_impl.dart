import 'package:drift/drift.dart';

import '../../domain/models/habit_with_creature.dart';
import '../../domain/repositories/habit_repository.dart';
import '../../domain/services/evolution_engine.dart';
import '../database/app_database.dart';

class HabitRepositoryImpl implements HabitRepository {
  final AppDatabase db;
  final EvolutionEngine evolutionEngine;

  HabitRepositoryImpl({
    required this.db,
    required this.evolutionEngine,
  });

  @override
  Future<List<HabitWithCreature>> findAllActive() async {
    final habits = await db.select(db.habits).get();
    final result = <HabitWithCreature>[];

    for (final habit in habits) {
      final creature = await (db.select(db.creatures)
            ..where((tbl) => tbl.id.equals(habit.creatureId)))
          .getSingle();

      // GrowthGrants から全累積ポイントを算出（正・負の合計）
      final grants = await (db.select(db.growthGrants)
            ..where((tbl) => tbl.habitId.equals(habit.id)))
          .get();

      final totalPoints = grants.fold<int>(0, (sum, g) => sum + g.amount);
      final stage = evolutionEngine.calculateStage(totalPoints);

      result.add(
        HabitWithCreature(
          habitId: habit.id,
          title: habit.title,
          creatureId: creature.id,
          species: creature.species,
          totalPoints: totalPoints,
          stage: stage,
        ),
      );
    }

    return result;
  }

  @override
  Future<void> createHabit({
    required String title,
    required String species,
  }) async {
    final habitId = DateTime.now().millisecondsSinceEpoch.toString();
    final creatureId = 'c_$habitId';
    final now = DateTime.now().toUtc();

    await db.transaction(() async {
      await db.into(db.creatures).insert(
            CreaturesCompanion.insert(
              id: creatureId,
              habitId: habitId,
              species: species,
              growthMode: 'normalDistribution',
              growthSeed: Uint8List.fromList([1, 2, 3, 4]),
              growthAlgorithmVersion: 1,
              nextGrantOrdinal: 1,
              createdAtUtc: now,
            ),
          );

      await db.into(db.habits).insert(
            HabitsCompanion.insert(
              id: habitId,
              title: title,
              startDay: now.toIso8601String().substring(0, 10),
              creatureId: creatureId,
              createdAtUtc: now,
            ),
          );
    });
  }

  @override
  Future<void> applyGrowth({
    required String habitId,
    required String day,
    required String state,
    required int deltaPoints,
  }) async {
    final now = DateTime.now().toUtc();
    final habit = await (db.select(db.habits)..where((tbl) => tbl.id.equals(habitId))).getSingle();

    await db.transaction(() async {
      // 日付記録の保存/更新
      await db.into(db.dayRecords).insertOnConflictUpdate(
            DayRecordsCompanion.insert(
              habitId: habitId,
              day: day,
              state: state,
              firstRecordedAtUtc: now,
              updatedAtUtc: now,
              recordedZoneId: 'Asia/Tokyo',
              recordedBoundaryHour: 4,
            ),
          );

      // GrowthGrantの登録（マイナス値もそのまま保存）
      await db.into(db.growthGrants).insert(
            GrowthGrantsCompanion.insert(
              id: '${habitId}_${day}_${now.millisecondsSinceEpoch}',
              habitId: habitId,
              creatureId: habit.creatureId,
              day: day,
              ordinal: now.millisecondsSinceEpoch,
              amount: deltaPoints,
              algorithmVersion: 1,
              issuedAtUtc: now,
            ),
          );
    });
  }
}