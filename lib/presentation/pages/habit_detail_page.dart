import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/models/habit_with_creature.dart';
import '../widgets/habit_chart_widget.dart';

class HabitDetailPage extends ConsumerWidget {
  final HabitWithCreature habit;

  const HabitDetailPage({super.key, required this.habit});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text(habit.title),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // キャラクター（進化段階）の拡大表示
            Transform.scale(
              scale: habit.visualScale * 2.0, // ホーム画面より大きく表示
              child: CircleAvatar(
                radius: 40,
                backgroundColor: Colors.green.shade200,
                child: Text('St.${habit.stage}', style: const TextStyle(fontSize: 24)),
              ),
            ),
            const SizedBox(height: 32),
            Text(
              '累積ポイント: ${habit.totalPoints} pt',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 32),
            // 詳細グラフ
            const Align(
              alignment: Alignment.centerLeft,
              child: Text('成長の記録', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 250,
              child: HabitChartWidget(habitId: habit.habitId),
            ),
            // 今後ここに詳細な記録履歴リストなどを追加可能
          ],
        ),
      ),
    );
  }
}