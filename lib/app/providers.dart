import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/database/app_database.dart';
import '../data/repositories/habit_repository_impl.dart';
import '../domain/repositories/habit_repository.dart';
import '../domain/services/evolution_engine.dart';
import '../domain/services/growth_engine.dart';
import '../domain/services/day_resolver.dart';
import '../domain/models/habit_with_creature.dart';

// --- インフラ層のProvider ---
final databaseProvider = Provider<AppDatabase>((ref) {
  final db = AppDatabase();
  ref.onDispose(db.close);
  return db;
});

final growthEngineProvider = Provider<GrowthEngine>((ref) => const GrowthEngineImpl());
final evolutionEngineProvider = Provider<EvolutionEngine>((ref) => const EvolutionEngineImpl());
final dayResolverProvider = Provider<DayResolver>((ref) => const DayResolverImpl());

// --- RepositoryのProvider ---
final habitRepositoryProvider = Provider<HabitRepository>((ref) {
  final db = ref.watch(databaseProvider);
  final evolutionEngine = ref.watch(evolutionEngineProvider);
  return HabitRepositoryImpl(db: db, evolutionEngine: evolutionEngine);
});

// --- UI状態管理 (AsyncNotifier) ---
class HabitListNotifier extends AsyncNotifier<List<HabitWithCreature>> {
  @override
  Future<List<HabitWithCreature>> build() async {
    return ref.watch(habitRepositoryProvider).findAllActive();
  }

  Future<void> addDummyHabit(String title) async {
    await ref.read(habitRepositoryProvider).createHabit(
      title: title,
      species: 'speciesA',
    );
    ref.invalidateSelf();
  }

  /// 現在時刻から運用日文字列を取得
  String _getOperationalDay() {
    final resolver = ref.read(dayResolverProvider);
    return resolver.resolveOperationalDay(DateTime.now()).toIso8601Date();
  }

  /// 通常ライン達成
  Future<void> recordStandard(String habitId) async {
    final engine = ref.read(growthEngineProvider);
    final decision = engine.decideStandard();
    final day = _getOperationalDay();

    await ref.read(habitRepositoryProvider).applyGrowth(
      habitId: habitId,
      day: day,
      state: 'standard',
      deltaPoints: decision.amount,
    );
    ref.invalidateSelf();
  }

  /// 最低ライン達成
  Future<void> recordMinimum(String habitId) async {
    final engine = ref.read(growthEngineProvider);
    final decision = engine.decideMinimum();
    final day = _getOperationalDay();

    await ref.read(habitRepositoryProvider).applyGrowth(
      habitId: habitId,
      day: day,
      state: 'minimum',
      deltaPoints: decision.amount,
    );
    ref.invalidateSelf();
  }

  /// 未達成 (ペナルティ)
  Future<void> recordMissed(String habitId, int currentPoints) async {
    final engine = ref.read(growthEngineProvider);
    final decision = engine.decidePenalty(currentPoints: currentPoints);
    final day = _getOperationalDay();

    await ref.read(habitRepositoryProvider).applyGrowth(
      habitId: habitId,
      day: day,
      state: 'missed',
      deltaPoints: decision.amount,
    );
    ref.invalidateSelf();
  }

  /// 休息日（ポイント増減なし）
  Future<void> recordRest(String habitId) async {
    final day = _getOperationalDay();

    await ref.read(habitRepositoryProvider).applyGrowth(
      habitId: habitId,
      day: day,
      state: 'rest',
      deltaPoints: 0, // ポイント増減なし
    );
    ref.invalidateSelf();
  }
}

final habitListProvider = AsyncNotifierProvider<HabitListNotifier, List<HabitWithCreature>>(() {
  return HabitListNotifier();
});