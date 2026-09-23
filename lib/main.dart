import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app/providers.dart';
import 'domain/models/habit_with_creature.dart'; // ← 追加: HabitWithCreature型を使うために必要
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

  Future<void> _showAddHabitDialog(BuildContext context, WidgetRef ref) async {
    final controller = TextEditingController();
    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('新しい習慣を作成'),
          content: TextField(
            controller: controller,
            decoration: const InputDecoration(
              hintText: '例: 毎朝のランニング',
              helperText: '※最大3件まで登録可能',
            ),
            autofocus: true,
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('キャンセル'),
            ),
            FilledButton(
              onPressed: () async {
                final success = await ref
                    .read(habitListProvider.notifier)
                    .createHabit(controller.text);
                
                if (context.mounted) {
                  Navigator.of(context).pop();
                  if (!success) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('アクティブな習慣は最大3件までです。'),
                        backgroundColor: Colors.orange,
                      ),
                    );
                  }
                }
              },
              child: const Text('追加'),
            ),
          ],
        );
      },
    );
  } // ← 修正: _showAddHabitDialog の閉じカッコをここに配置

  Future<void> _showYesterdayRecordDialog(BuildContext context, WidgetRef ref, HabitWithCreature habit) async {
    await showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('昨日の記録'),
        content: const Text('昨日の達成状況を教えてください。'),
        actionsAlignment: MainAxisAlignment.spaceEvenly,
        actions: [
          ElevatedButton(
            onPressed: () {
              ref.read(habitListProvider.notifier).recordForDay(
                habitId: habit.habitId, targetState: 'standard', offsetDays: -1, currentPoints: habit.totalPoints);
              ref.invalidate(habitChartProvider(habit.habitId));
              Navigator.pop(ctx);
            },
            child: const Text('通常'),
          ),
          ElevatedButton(
            onPressed: () {
              ref.read(habitListProvider.notifier).recordForDay(
                habitId: habit.habitId, targetState: 'minimum', offsetDays: -1, currentPoints: habit.totalPoints);
              ref.invalidate(habitChartProvider(habit.habitId));
              Navigator.pop(ctx);
            },
            child: const Text('最低'),
          ),
          FilledButton.tonal(
            onPressed: () {
              ref.read(habitListProvider.notifier).recordForDay(
                habitId: habit.habitId, targetState: 'missed', offsetDays: -1, currentPoints: habit.totalPoints);
              ref.invalidate(habitChartProvider(habit.habitId));
              Navigator.pop(ctx);
            },
            style: FilledButton.styleFrom(backgroundColor: Colors.red.shade100),
            child: const Text('未達成', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
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
            return const Center(child: Text('右下のボタンから習慣を追加してください（最大3件）'));
          }
          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: habits.length,
            itemBuilder: (context, index) {
              final habit = habits[index];
              final isRecordedToday = habit.todayRecordState != null &&
                  habit.todayRecordState != 'cancelled';

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

                      if (habit.stage >= 3)
                        Container(
                          width: double.infinity,
                          margin: const EdgeInsets.only(bottom: 8),
                          child: FilledButton.icon(
                            onPressed: () async {
                              final confirm = await showDialog<bool>(
                                context: context,
                                builder: (ctx) => AlertDialog(
                                  title: const Text('習慣の卒業'),
                                  content: const Text('この習慣をアーカイブして、新しい習慣の枠を空けますか？\n（データは保存されます）'),
                                  actions: [
                                    TextButton(onPressed: () => Navigator.pop(ctx, false), child: const Text('キャンセル')),
                                    FilledButton(onPressed: () => Navigator.pop(ctx, true), child: const Text('卒業する')),
                                  ],
                                ),
                              );
                              if (confirm == true) {
                                ref.read(habitListProvider.notifier).archiveHabit(habit.habitId);
                              }
                            },
                            icon: const Icon(Icons.workspace_premium),
                            label: const Text('この習慣を卒業する（アーカイブ）'),
                            style: FilledButton.styleFrom(backgroundColor: Colors.amber.shade700),
                          ),
                        ),

                      // --- 昨日の記録（事後入力） ---
                      if (habit.yesterdayRecordState == null)
                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton.icon(
                            onPressed: () => _showYesterdayRecordDialog(context, ref, habit),
                            icon: const Icon(Icons.history, size: 16),
                            label: const Text('昨日の記録をつける', style: TextStyle(fontSize: 12)),
                          ),
                        ),

                      // --- 本日の記録制御 ---
                      if (isRecordedToday) ...[
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
                            style: TextStyle(
                              color: Colors.grey.shade700,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton.icon(
                            onPressed: () async {
                              await ref
                                  .read(habitListProvider.notifier)
                                  .clearTodayRecord(habit.habitId);
                              ref.invalidate(habitChartProvider(habit.habitId));
                            },
                            icon: const Icon(Icons.undo, size: 16),
                            label: const Text('本日の記録を取り消す'),
                          ),
                        ),
                      ] else ...[
                        Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: [
                            ElevatedButton(
                              onPressed: () async {
                                await ref
                                    .read(habitListProvider.notifier)
                                    .recordForDay(
                                      habitId: habit.habitId,
                                      targetState: 'standard',
                                      offsetDays: 0,
                                      currentPoints: habit.totalPoints,
                                    );
                                ref.invalidate(habitChartProvider(habit.habitId));
                              },
                              child: const Text('通常'),
                            ),
                            ElevatedButton(
                              onPressed: () async {
                                await ref
                                    .read(habitListProvider.notifier)
                                    .recordForDay(
                                      habitId: habit.habitId,
                                      targetState: 'minimum',
                                      offsetDays: 0,
                                      currentPoints: habit.totalPoints,
                                    );
                                ref.invalidate(habitChartProvider(habit.habitId));
                              },
                              child: const Text('最低'),
                            ),
                            OutlinedButton(
                              onPressed: () async {
                                await ref
                                    .read(habitListProvider.notifier)
                                    .recordForDay(
                                      habitId: habit.habitId,
                                      targetState: 'rest',
                                      offsetDays: 0,
                                      currentPoints: habit.totalPoints,
                                    );
                                ref.invalidate(habitChartProvider(habit.habitId));
                              },
                              child: const Text('休息'),
                            ),
                            FilledButton.tonal(
                              onPressed: () async {
                                await ref
                                    .read(habitListProvider.notifier)
                                    .recordForDay(
                                      habitId: habit.habitId,
                                      targetState: 'missed',
                                      offsetDays: 0,
                                      currentPoints: habit.totalPoints,
                                    );
                                ref.invalidate(habitChartProvider(habit.habitId));
                              },
                              style: FilledButton.styleFrom(
                                  backgroundColor: Colors.red.shade100),
                              child: const Text('未達成',
                                  style: TextStyle(color: Colors.red)),
                            ),
                          ],
                        ),
                      ],
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

        final maxY = math.max(30.0, maxVal * 1.2);

        return LineChart(
          LineChartData(
            minY: 0,
            maxY: maxY,
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