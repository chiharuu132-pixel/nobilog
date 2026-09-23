import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app/providers.dart';
import 'dart:math' as math;

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const ProviderScope(child: NobilogApp()));
}

class NobilogApp extends StatelessWidget {
  const NobilogApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'のびログ',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.green,
          brightness: Brightness.light,
        ),
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.green,
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final habitsAsync = ref.watch(habitListProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('のびログ (チャート表示)'),
      ),
      body: habitsAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('エラーが発生しました: $error')),
        data: (habits) {
          if (habits.isEmpty) {
            return const Center(child: Text('右下のボタンから習慣を追加してください'));
          }
          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: habits.length,
            itemBuilder: (context, index) {
              final habit = habits[index];
              return Card(
                margin: const EdgeInsets.only(bottom: 16),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        habit.title,
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Text('進化段階: ${habit.stage}'),
                          const SizedBox(width: 16),
                          Text(
                            '累積ポイント: ${habit.totalPoints} pt',
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),

                      // --- 折れ線チャート表示部 ---
                      SizedBox(
                        height: 120,
                        child: HabitChartWidget(habitId: habit.habitId),
                      ),
                      const SizedBox(height: 16),

                      // --- ボタン操作群 ---
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: [
                          ElevatedButton(
                            onPressed: () async {
                              await ref.read(habitListProvider.notifier).recordStandard(habit.habitId);
                              ref.invalidate(habitChartProvider(habit.habitId));
                            },
                            child: const Text('通常達成', textAlign: TextAlign.center),
                          ),
                          ElevatedButton(
                            onPressed: () async {
                              await ref.read(habitListProvider.notifier).recordMinimum(habit.habitId);
                              ref.invalidate(habitChartProvider(habit.habitId));
                            },
                            child: const Text('最低達成', textAlign: TextAlign.center),
                          ),
                          OutlinedButton(
                            onPressed: () async {
                              await ref.read(habitListProvider.notifier).recordRest(habit.habitId);
                              ref.invalidate(habitChartProvider(habit.habitId));
                            },
                            child: const Text('休息', textAlign: TextAlign.center),
                          ),
                          FilledButton.tonal(
                            onPressed: () async {
                              await ref.read(habitListProvider.notifier).recordMissed(habit.habitId, habit.totalPoints);
                              ref.invalidate(habitChartProvider(habit.habitId));
                            },
                            style: FilledButton.styleFrom(backgroundColor: Colors.red.shade100),
                            child: const Text('未達成', textAlign: TextAlign.center, style: TextStyle(color: Colors.red)),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ref.read(habitListProvider.notifier).addDummyHabit('テスト習慣 ${DateTime.now().second}');
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class HabitChartWidget extends ConsumerWidget {
  final String habitId;

  const HabitChartWidget({super.key, required this.habitId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final chartAsync = ref.watch(habitChartProvider(habitId));

    return chartAsync.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, s) => const Center(child: Text('チャート読み込み失敗')),
      data: (points) {
        if (points.isEmpty) return const SizedBox.shrink();

        final spots = <FlSpot>[];
        double maxVal = 0;
        for (int i = 0; i < points.length; i++) {
          final val = points[i].totalPoints.toDouble();
          spots.add(FlSpot(i.toDouble(), val));
          if (val > maxVal) maxVal = val;
        }

        // Y軸の下限を0に固定し、上限は最低30pt（または最大値の1.2倍）に設定
        final maxY = math.max(30.0, maxVal * 1.2);

        return LineChart(
          LineChartData(
            minY: 0,     // ← 追加: 下限を0に固定
            maxY: maxY,  // ← 追加: 成長に合わせて上限を動的に設定
            gridData: const FlGridData(show: false),
            titlesData: const FlTitlesData(show: false),
            borderData: FlBorderData(show: false),
            lineBarsData: [
              LineChartBarData(
                spots: spots,
                isCurved: true,
                color: Theme.of(context).colorScheme.primary,
                barWidth: 3,
                isStrokeCapRound: true,
                dotData: const FlDotData(show: false),
                belowBarData: BarAreaData(
                  show: true,
                  color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.15),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}