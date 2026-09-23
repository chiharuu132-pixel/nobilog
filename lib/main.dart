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

  // --- 新規作成ダイアログ ---
  Future<void> _showAddHabitDialog(BuildContext context, WidgetRef ref) async {
    final controller = TextEditingController();
    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('新しい習慣を作成'),
          content: TextField(
            controller: controller,
            decoration: const InputDecoration(hintText: '例: 毎朝のランニング'),
            autofocus: true,
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('キャンセル'),
            ),
            FilledButton(
              onPressed: () {
                ref.read(habitListProvider.notifier).createHabit(controller.text);
                Navigator.of(context).pop();
              },
              child: const Text('追加'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final habitsAsync = ref.watch(habitListProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('のびログ')),
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
              final isRecordedToday = habit.todayRecordState != null;

              return Card(
                margin: const EdgeInsets.only(bottom: 16),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              habit.title,
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                          ),
                          // --- キャラクター表示（ダミー）にスケールを適用 ---
                          Transform.scale(
                            scale: habit.visualScale,
                            child: CircleAvatar(
                              backgroundColor: Colors.green.shade200,
                              child: Text('St.${habit.stage}'),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        '累積ポイント: ${habit.totalPoints} pt',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 16),
                      SizedBox(
                        height: 100,
                        child: HabitChartWidget(habitId: habit.habitId),
                      ),
                      const SizedBox(height: 16),
                      
                      // --- 記録制御 ---
                      if (isRecordedToday)
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.grey.shade200,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            '本日の記録: ${habit.todayRecordState}',
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.grey.shade700, fontWeight: FontWeight.bold),
                          ),
                        )
                      else
                        Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: [
                            ElevatedButton(
                              onPressed: () async {
                                await ref.read(habitListProvider.notifier).recordStandard(habit.habitId);
                                ref.invalidate(habitChartProvider(habit.habitId));
                              },
                              child: const Text('通常'),
                            ),
                            ElevatedButton(
                              onPressed: () async {
                                await ref.read(habitListProvider.notifier).recordMinimum(habit.habitId);
                                ref.invalidate(habitChartProvider(habit.habitId));
                              },
                              child: const Text('最低'),
                            ),
                            OutlinedButton(
                              onPressed: () async {
                                await ref.read(habitListProvider.notifier).recordRest(habit.habitId);
                                ref.invalidate(habitChartProvider(habit.habitId));
                              },
                              child: const Text('休息'),
                            ),
                            FilledButton.tonal(
                              onPressed: () async {
                                await ref.read(habitListProvider.notifier).recordMissed(habit.habitId, habit.totalPoints);
                                ref.invalidate(habitChartProvider(habit.habitId));
                              },
                              style: FilledButton.styleFrom(backgroundColor: Colors.red.shade100),
                              child: const Text('未達成', style: TextStyle(color: Colors.red)),
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
        onPressed: () => _showAddHabitDialog(context, ref),
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