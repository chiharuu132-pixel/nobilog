import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/database/app_database.dart';
import '../data/repositories/habit_repository_impl.dart';
import '../domain/repositories/habit_repository.dart';
import '../domain/services/evolution_engine.dart';
import '../domain/services/growth_engine.dart';
import '../domain/models/habit_with_creature.dart';

// --- インフラ層のProvider ---
final databaseProvider = Provider<AppDatabase>((ref) {
  final db = AppDatabase();
  ref.onDispose(db.close);
  return db;
});

final growthEngineProvider = Provider<GrowthEngine>((ref) => const GrowthEngineImpl());
final evolutionEngineProvider = Provider<EvolutionEngine>((ref) => const EvolutionEngineImpl());

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
    // DBから最新の習慣と累積ポイントを読み込む
    return ref.watch(habitRepositoryProvider).findAllActive();
  }

  /// テスト用の習慣追加メソッド
  Future<void> addDummyHabit(String title) async {
    await ref.read(habitRepositoryProvider).createHabit(
      title: title,
      species: 'speciesA',
    );
    // 状態を破棄してbuild()を再実行し、UIを更新
    ref.invalidateSelf();
  }

  /// 通常ライン達成
  Future<void> recordStandard(String habitId) async {
    final engine = ref.read(growthEngineProvider);
    final decision = engine.decideStandard();
    final today = DateTime.now().toIso8601String().substring(0, 10);

    await ref.read(habitRepositoryProvider).applyGrowth(
      habitId: habitId,
      day: today,
      state: 'standard',
      deltaPoints: decision.amount,
    );
    ref.invalidateSelf();
  }

  /// 最低ライン達成
  Future<void> recordMinimum(String habitId) async {
    final engine = ref.read(growthEngineProvider);
    final decision = engine.decideMinimum();
    final today = DateTime.now().toIso8601String().substring(0, 10);

    await ref.read(habitRepositoryProvider).applyGrowth(
      habitId: habitId,
      day: today,
      state: 'minimum',
      deltaPoints: decision.amount,
    );
    ref.invalidateSelf();
  }

  /// 未達成 (ペナルティ)
  Future<void> recordMissed(String habitId, int currentPoints) async {
    final engine = ref.read(growthEngineProvider);
    final decision = engine.decidePenalty(currentPoints: currentPoints);
    final today = DateTime.now().toIso8601String().substring(0, 10);

    await ref.read(habitRepositoryProvider).applyGrowth(
      habitId: habitId,
      day: today,
      state: 'missed', 
      deltaPoints: decision.amount, // この値はマイナスになる
    );
    ref.invalidateSelf();
  }
}

final habitListProvider = AsyncNotifierProvider<HabitListNotifier, List<HabitWithCreature>>(() {
  return HabitListNotifier();
});