import '../models/habit_with_creature.dart';
import '../../core/local_date.dart';
import '../../domain/services/chart_builder.dart';

abstract interface class HabitRepository {
  Future<List<HabitWithCreature>> findAllActive(String today);
  Future<int> countActive();
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
  Future<void> clearRecord({
    required String habitId,
    required String day,
  }); //
  /// チャート描画用の履歴系列を取得する
  Future<List<ChartPoint>> getChartSeries({
    required String habitId,
    required LocalDate startDay,
    required LocalDate endDay,
  });
}