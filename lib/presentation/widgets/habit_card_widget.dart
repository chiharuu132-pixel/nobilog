import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../app/providers.dart';
import '../../domain/models/habit_with_creature.dart';
import '../pages/habit_detail_page.dart';
import 'habit_chart_widget.dart';

class HabitCardWidget extends ConsumerWidget {
  final HabitWithCreature habit;

  const HabitCardWidget({super.key, required this.habit});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isRecordedToday =
        habit.todayRecordState != null && habit.todayRecordState != 'cancelled';

    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => HabitDetailPage(habit: habit),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 証券アプリ風ヘッダー（アイコン・タイトル・現在値）
              _buildHeader(context, ref),
              const SizedBox(height: 16),

              // 軸付きミニチャート（タップイベント無効化済み）
              SizedBox(
                height: 110,
                child: HabitChartWidget(
                  habitId: habit.habitId,
                  showAxes: true,
                  enableTouch: false,
                ),
              ),
              const SizedBox(height: 16),

              // 卒業ボタン
              if (habit.stage >= 3) _buildArchiveButton(context, ref),

              // 昨日の記録ボタン
              if (habit.yesterdayRecordState == null)
                _buildYesterdayButton(context, ref),

              // 本日の記録操作エリア
              if (isRecordedToday)
                _buildRecordedTodayArea(context, ref)
              else
                _buildRecordButtons(context, ref),
            ],
          ),
        ),
      ),
    );
  }

  // --- 内部パーツ Widget ---

  /// 証券アプリ銘柄表示風ヘッダー
  Widget _buildHeader(BuildContext context, WidgetRef ref) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // アイコン（生物・段階）
        Transform.scale(
          scale: habit.visualScale,
          child: CircleAvatar(
            backgroundColor: Colors.green.shade100,
            radius: 22,
            child: Text(
              'St.${habit.stage}',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.green.shade900,
                fontSize: 12,
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),

        // 習慣名（銘柄名）
        Expanded(
          child: Text(
            habit.title,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        const SizedBox(width: 8),

        // 現在値（株価風表記）
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              '${habit.totalPoints}',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.primary,
                  ),
            ),
            const Text(
              'pt (現在値)',
              style: TextStyle(fontSize: 10, color: Colors.grey),
            ),
          ],
        ),

        // 設定メニュー
        PopupMenuButton<String>(
          icon: const Icon(Icons.more_vert, size: 20, color: Colors.grey),
          onSelected: (value) async {
            if (value == 'edit') {
              _showEditTitleDialog(context, ref);
            } else if (value == 'delete') {
              _showDeleteDialog(context, ref);
            }
          },
          itemBuilder: (context) => [
            const PopupMenuItem(value: 'edit', child: Text('名前を編集')),
            const PopupMenuItem(
              value: 'delete',
              child: Text('完全に削除', style: TextStyle(color: Colors.red)),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildArchiveButton(BuildContext context, WidgetRef ref) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 8),
      child: FilledButton.icon(
        onPressed: () async {
          final confirm = await showDialog<bool>(
            context: context,
            builder: (ctx) => AlertDialog(
              title: const Text('習慣の卒業'),
              content: const Text(
                'この習慣をアーカイブして、新しい習慣の枠を空けますか？\n（データは保存されます）',
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(ctx, false),
                  child: const Text('キャンセル'),
                ),
                FilledButton(
                  onPressed: () => Navigator.pop(ctx, true),
                  child: const Text('卒業する'),
                ),
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
    );
  }

  Widget _buildYesterdayButton(BuildContext context, WidgetRef ref) {
    return Align(
      alignment: Alignment.centerRight,
      child: TextButton.icon(
        onPressed: () => _showYesterdayRecordDialog(context, ref),
        icon: const Icon(Icons.history, size: 16),
        label: const Text('昨日の記録をつける', style: TextStyle(fontSize: 12)),
      ),
    );
  }

  Widget _buildRecordedTodayArea(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
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
        Align(
          alignment: Alignment.centerRight,
          child: TextButton.icon(
            onPressed: () async {
              await ref
                  .read(habitListProvider.notifier)
                  .clearTodayRecord(habit.habitId);
              ref.invalidate(habitChartProvider(habit.habitId));
            },
            icon: const Icon(Icons.undo, size: 14),
            label: const Text('取り消す', style: TextStyle(fontSize: 12)),
          ),
        ),
      ],
    );
  }

  Widget _buildRecordButtons(BuildContext context, WidgetRef ref) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        ElevatedButton(
          onPressed: () => _recordToday(ref, 'standard'),
          child: const Text('通常'),
        ),
        ElevatedButton(
          onPressed: () => _recordToday(ref, 'minimum'),
          child: const Text('最低'),
        ),
        OutlinedButton(
          onPressed: () => _recordToday(ref, 'rest'),
          child: const Text('休息'),
        ),
        FilledButton.tonal(
          onPressed: () async {
            await _recordToday(ref, 'missed');
            if (context.mounted) {
              await _checkAndShowSimplificationSuggestion(context, ref);
            }
          },
          style: FilledButton.styleFrom(backgroundColor: Colors.red.shade100),
          child: const Text('未達成', style: TextStyle(color: Colors.red)),
        ),
      ],
    );
  }

  // --- ロジック・ダイアログ処理 ---

  Future<void> _recordToday(WidgetRef ref, String targetState) async {
    await ref.read(habitListProvider.notifier).recordForDay(
          habitId: habit.habitId,
          targetState: targetState,
          offsetDays: 0,
          currentPoints: habit.totalPoints,
        );
    ref.invalidate(habitChartProvider(habit.habitId));
  }

  Future<void> _showYesterdayRecordDialog(
      BuildContext context, WidgetRef ref) async {
    await showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('昨日の記録'),
        content: const Text('昨日の達成状況を教えてください。'),
        actionsAlignment: MainAxisAlignment.spaceEvenly,
        actions: [
          ElevatedButton(
            onPressed: () => _recordYesterday(ref, ctx, 'standard'),
            child: const Text('通常'),
          ),
          ElevatedButton(
            onPressed: () => _recordYesterday(ref, ctx, 'minimum'),
            child: const Text('最低'),
          ),
          FilledButton.tonal(
            onPressed: () => _recordYesterday(ref, ctx, 'missed'),
            style:
                FilledButton.styleFrom(backgroundColor: Colors.red.shade100),
            child: const Text('未達成', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  void _recordYesterday(WidgetRef ref, BuildContext dialogCtx, String state) {
    ref.read(habitListProvider.notifier).recordForDay(
          habitId: habit.habitId,
          targetState: state,
          offsetDays: -1,
          currentPoints: habit.totalPoints,
        );
    ref.invalidate(habitChartProvider(habit.habitId));
    Navigator.pop(dialogCtx);
  }

  Future<void> _checkAndShowSimplificationSuggestion(
      BuildContext context, WidgetRef ref) async {
    final shouldSuggest = await ref
        .read(habitListProvider.notifier)
        .checkConsecutiveMissed(habit.habitId);

    if (shouldSuggest && context.mounted) {
      await showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('目標の見直し提案'),
          content: const Text(
            '3回連続で未達成になりました。\n'
            '無理をせず、まずは「最低ライン」の達成から再開してみませんか？',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: const Text('このまま続ける'),
            ),
            FilledButton(
              onPressed: () {
                Navigator.pop(ctx);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('最低ラインから無理なく再開していきましょう！')),
                );
              },
              child: const Text('了解'),
            ),
          ],
        ),
      );
    }
  }

  Future<void> _showEditTitleDialog(
      BuildContext context, WidgetRef ref) async {
    final controller = TextEditingController(text: habit.title);
    await showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('習慣の名前を編集'),
        content: TextField(
          controller: controller,
          autofocus: true,
          decoration: const InputDecoration(hintText: '新しい名前を入力'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('キャンセル'),
          ),
          FilledButton(
            onPressed: () {
              ref
                  .read(habitListProvider.notifier)
                  .updateHabitTitle(habit.habitId, controller.text);
              Navigator.pop(ctx);
            },
            child: const Text('保存'),
          ),
        ],
      ),
    );
  }

  Future<void> _showDeleteDialog(BuildContext context, WidgetRef ref) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('習慣の削除'),
        content: const Text('この習慣と関連するすべての記録を完全に削除します。よろしいですか？'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('キャンセル'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(ctx, true),
            style: FilledButton.styleFrom(backgroundColor: Colors.red),
            child: const Text('削除する'),
          ),
        ],
      ),
    );
    if (confirm == true) {
      ref.read(habitListProvider.notifier).deleteHabit(habit.habitId);
    }
  }
}