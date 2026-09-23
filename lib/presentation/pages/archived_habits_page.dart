import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../app/providers.dart';

class ArchivedHabitsPage extends ConsumerWidget {
  const ArchivedHabitsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final archivedAsync = ref.watch(archivedHabitListProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('卒業名簿')),
      body: archivedAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, s) => Center(child: Text('エラーが発生しました: $e')),
        data: (habits) {
          if (habits.isEmpty) {
            return const Center(child: Text('卒業した習慣はまだありません。'));
          }
          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: habits.length,
            itemBuilder: (context, index) {
              final habit = habits[index];
              return Card(
                color: Colors.amber.shade50, // 卒業っぽく色を変える
                margin: const EdgeInsets.only(bottom: 16),
                child: ListTile(
                  contentPadding: const EdgeInsets.all(16),
                  leading: Transform.scale(
                    scale: habit.visualScale,
                    child: CircleAvatar(
                      backgroundColor: Colors.amber,
                      child: Text('St.${habit.stage}'),
                    ),
                  ),
                  title: Text(
                    habit.title,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text('最終累積ポイント: ${habit.totalPoints} pt'),
                  trailing: const Icon(Icons.workspace_premium, color: Colors.amber),
                ),
              );
            },
          );
        },
      ),
    );
  }
}