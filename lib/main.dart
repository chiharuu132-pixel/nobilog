import 'dart:io';
import 'package:file_selector/file_selector.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
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

  void _showBackupDialog(BuildContext context, String title, String initialText, {required bool isExport, required WidgetRef ref}) {
    final controller = TextEditingController(text: initialText);
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(title),
        content: TextField(
          controller: controller,
          maxLines: 8,
          readOnly: isExport,
          decoration: InputDecoration(
            border: const OutlineInputBorder(),
            hintText: isExport ? '' : 'ここにJSONを貼り付けてください',
          ),
          style: const TextStyle(fontSize: 11, fontFamily: 'monospace'),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('閉じる')),
          if (!isExport)
            FilledButton(
              onPressed: () async {
                try {
                  await ref.read(backupServiceProvider).importFromJson(controller.text);
                  ref.read(habitListProvider.notifier).ref.invalidateSelf();
                  if (ctx.mounted) {
                    Navigator.pop(ctx);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('データを正常に復元しました。')),
                    );
                  }
                } catch (e) {
                  if (ctx.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('復元に失敗しました: $e'), backgroundColor: Colors.red),
                    );
                  }
                }
              },
              child: const Text('復元実行'),
            ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final habitsAsync = ref.watch(habitListProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('のびログ'),
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) async {
              if (value == 'export') {
                // 1. JSON文字列を生成
                final jsonStr = await ref.read(backupServiceProvider).exportToJson();
                
                // 2. 一時フォルダにファイルとして書き出し
                final tempDir = await getTemporaryDirectory();
                final file = File('${tempDir.path}/nobilog_backup.json');
                await file.writeAsString(jsonStr);

                // 3. OSの共有機能でファイルを保存・送信
                if (context.mounted) {
                  // RenderBox から表示位置・サイズを取得
                  final box = context.findRenderObject() as RenderBox?;
                  
                  await Share.shareXFiles(
                    [XFile(file.path)],
                    text: 'のびログ バックアップデータ',
                    // iPad向けの表示位置を指定（nullチェック付き）
                    sharePositionOrigin: box != null
                        ? box.localToGlobal(Offset.zero) & box.size
                        : null,
                  );
                }
              } else if (value == 'import') {
                // 1. ファイルピッカーでJSONファイルを選択
                const typeGroup = XTypeGroup(
                  label: 'JSONs',
                  extensions: ['json'],
                  // iOS / macOS 向けに UTI を追加
                  uniformTypeIdentifiers: ['public.json'],
                );
                final XFile? file = await openFile(acceptedTypeGroups: [typeGroup]);
                
                if (file != null) {
                  try {
                    // 2. ファイル内容を読み込んで復元
                    final jsonStr = await file.readAsString();
                    await ref.read(backupServiceProvider).importFromJson(jsonStr);
                    
                    // 3. 状態とグラフのキャッシュを完全にクリア（再描画）
                    ref.invalidate(habitListProvider);
                    ref.invalidate(habitChartProvider); // グラフのキャッシュも全破棄

                    if (context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('ファイルからデータを正常に復元しました。')),
                      );
                    }
                  } catch (e) {
                    if (context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('復元に失敗しました: $e'), backgroundColor: Colors.red),
                      );
                    }
                  }
                }
              }
            },
            itemBuilder: (context) => [
              const PopupMenuItem(value: 'export', child: Text('バックアップをファイル保存')),
              const PopupMenuItem(value: 'import', child: Text('ファイルから復元')),
            ],
          ),
        ],
      ),
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