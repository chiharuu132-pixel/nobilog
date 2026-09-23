import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/database/app_database.dart';
import '../data/repositories/habit_repository_impl.dart';
import '../domain/repositories/habit_repository.dart';
import '../domain/services/evolution_engine.dart';
import '../domain/services/growth_engine.dart';
import '../domain/services/day_resolver.dart';
import '../domain/models/habit_with_creature.dart';
import '../domain/services/chart_builder.dart';

// --- インフラ層のProvider ---
final databaseProvider = Provider<AppDatabase>((ref) {
  final db = AppDatabase();
  ref.onDispose(db.close);
  return db;
});

final growthEngineProvider = Provider<GrowthEngine>((ref) => const GrowthEngineImpl());
final evolutionEngineProvider = Provider<EvolutionEngine>((ref) => const EvolutionEngineImpl());
final dayResolverProvider = Provider<DayResolver>((ref) => const DayResolverImpl());

final habitChartProvider = FutureProvider.family<List<ChartPoint>, String>((ref, habitId) async {
  final repo = ref.watch(habitRepositoryProvider);
  final dayResolver = ref.watch(dayResolverProvider);
  
  final today = dayResolver.resolveOperationalDay(DateTime.now());
  final startDay = today.addDays(-13); // 直近14日間

  return repo.getChartSeries(
    habitId: habitId,
    startDay: startDay,
    endDay: today,
  );
});

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
    final today = _getOperationalDay();
    return ref.watch(habitRepositoryProvider).findAllActive(today);
  }

  String _getOperationalDay({int offsetDays = 0}) {
    final resolver = ref.read(dayResolverProvider);
    final dt = DateTime.now().add(Duration(days: offsetDays));
    return resolver.resolveOperationalDay(dt).toIso8601Date();
  }

  /// 習慣の作成（最大3件制限付き）
  Future<bool> createHabit(String title) async {
    if (title.trim().isEmpty) return false;

    final repo = ref.read(habitRepositoryProvider);
    final count = await repo.countActive();

    // 仕様書: 同時利用できるアクティブ習慣は最大3件
    if (count >= 3) {
      return false; // 上限エラー
    }

    await repo.createHabit(
      title: title.trim(),
      species: 'normal_species',
    );
    ref.invalidateSelf();
    return true;
  }

  /// 任意の日付（今日 or 昨日）へ記録
  Future<void> recordForDay({
    required String habitId,
    required String targetState, // 'standard' | 'minimum' | 'rest' | 'missed'
    required int offsetDays,     // 0: 今日, -1: 昨日
    required int currentPoints,
  }) async {
    final day = _getOperationalDay(offsetDays: offsetDays);
    final engine = ref.read(growthEngineProvider);

    int deltaPoints = 0;
    if (targetState == 'standard') {
      deltaPoints = engine.decideStandard().amount;
    } else if (targetState == 'minimum') {
      deltaPoints = engine.decideMinimum().amount;
    } else if (targetState == 'missed') {
      deltaPoints = engine.decidePenalty(currentPoints: currentPoints).amount;
    } else if (targetState == 'rest') {
      deltaPoints = 0;
    }

    await ref.read(habitRepositoryProvider).applyGrowth(
      habitId: habitId,
      day: day,
      state: targetState,
      deltaPoints: deltaPoints,
    );
    ref.invalidateSelf();
  }

  /// 当日の記録取り消し
  Future<void> clearTodayRecord(String habitId) async {
    final today = _getOperationalDay();
    await ref.read(habitRepositoryProvider).clearRecord(
      habitId: habitId,
      day: today,
    );
    ref.invalidateSelf();
  }
}

final habitListProvider = AsyncNotifierProvider<HabitListNotifier, List<HabitWithCreature>>(() {
  return HabitListNotifier();
});